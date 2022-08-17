this.sleep_player <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.sleep_player";
		this.m.Name = "Sleep";
		this.m.Description = "Lull them into the land of dreams. The success rate is determined by the difference in resolve between the character and the target.";
		this.m.Icon = "skills/active_116.png";
		this.m.IconDisabled = "skills/active_116_sw.png";
		this.m.Overlay = "active_116";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/alp_sleep_01.wav",
			"sounds/enemies/dlc2/alp_sleep_02.wav",
			"sounds/enemies/dlc2/alp_sleep_03.wav",
			"sounds/enemies/dlc2/alp_sleep_04.wav",
			"sounds/enemies/dlc2/alp_sleep_05.wav",
			"sounds/enemies/dlc2/alp_sleep_06.wav",
			"sounds/enemies/dlc2/alp_sleep_07.wav",
			"sounds/enemies/dlc2/alp_sleep_08.wav",
			"sounds/enemies/dlc2/alp_sleep_09.wav",
			"sounds/enemies/dlc2/alp_sleep_10.wav",
			"sounds/enemies/dlc2/alp_sleep_11.wav",
			"sounds/enemies/dlc2/alp_sleep_12.wav"
		];
		this.m.IsUsingActorPitch = true;
		this.m.IsSerialized = true;
		this.m.Type = this.Const.SkillType.Active | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 600;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.skill.getDefaultUtilityTooltip();
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "Has a range of [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.MaxRange + "[/color] tiles"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Puts target to [color=" + this.Const.UI.Color.PositiveValue + "]Sleep[/color]"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.ActionPointCost = this.getContainer().getActor().getFlags().has("alp_8") ? 3 : 4;
	}

	function onVerifyTarget( _userTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_userTile, _targetTile))
		{
			return false;
		}

		if (_targetTile.getEntity().getCurrentProperties().IsStunned)
		{
			return false;
		}

		return true;
	}

	function isUsable()
	{
		if (!this.skill.isUsable())
		{
			return false;
		}

		if (this.getContainer().getActor().isPlayerControlled())
		{
			return true;
		}

		local b = this.getContainer().getActor().getAIAgent().getBehavior(this.Const.AI.Behavior.ID.AttackDefault);
		local targets = b.queryTargetsInMeleeRange(this.getMinRange(), this.getMaxRange());
		local myTile = this.getContainer().getActor().getTile();

		foreach( t in targets )
		{
			if (this.onVerifyTarget(myTile, t.getTile()))
			{
				return true;
			}
		}

		return false;
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 600, this.onDelayedEffect.bindenv(this), tag);
		return true;
	}

	function onDelayedEffect( _tag )
	{
		local targets = [];
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;

		if (_targetTile.IsOccupiedByActor)
		{
			local entity = _targetTile.getEntity();
			targets.push(entity);
		}

		local hasMastery = this.getContainer().getActor().getFlags().has("alp_8");
		local masteryModifier = hasMastery ?  1.1 : 1.0;
		local chance_attack = _user.getBravery() * masteryModifier;

		foreach( target in targets )
		{
			if (!this.isViableTarget(_user, target))
			{
				continue;
			}

			local chance = this.getHitchance(target);
			local roll = this.Math.rand(1, 100);
			if (roll > chance)
			{
				if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists the urge to sleep thanks to his resolve (Chance: " + chance + ", Rolled: " + roll + ")");
				}
				continue;
			}

			local oldRoll = roll;
			if (this.Math.rand(1, 100) <= target.getCurrentProperties().RerollMoraleChance)
			{
				roll = this.Math.rand(1, 100);
				if (roll > chance)
				{
					if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
					{
						this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " resists the urge to sleep thanks to his resolve (Chance: " + chance + ", Rolled: " + roll + ")");
					}
					continue;
				}
			}

			roll = oldRoll;

			if (!_user.isHiddenToPlayer() && !target.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(target) + " falls to sleep (Chance: " + chance + ", Rolled: " + roll + ")");
			}

			local sleep = this.new("scripts/skills/effects/sleeping_effect");
			target.getFlags().set("resist_sleep", 0);
			target.getSkills().add(sleep);
			sleep.m.TurnsLeft += hasMastery ? 1 : 0;
		}
	}

	function isViableTarget( _user, _target )
	{
		if (_target.getCurrentProperties().MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] >= 1000.0)
		{
			return false;
		}

		if (_target.isNonCombatant())
		{
			return false;
		}

		if (_target.getFlags().has("alp"))
		{
			return false;
		}

		local invalid = [
			this.Const.EntityType.Alp,
			this.Const.EntityType.AlpShadow,
			this.Const.EntityType.LegendDemonAlp
		];
		return invalid.find(_target.getType()) == null;
	}

	function getHitchance( _targetEntity )
	{
		local target = _targetEntity;
		local _user = this.getContainer().getActor();

		local hasMastery = this.getContainer().getActor().getFlags().has("alp_8");
		local masteryModifier = hasMastery ?  1.1 : 1.0;
		local chance_attack = _user.getBravery() * masteryModifier;
		
		local modifier_defender_morale = 0;
		modifier_defender_morale = target.getMoraleState() < 3 ? -0.15 : modifier_defender_morale;
		modifier_defender_morale = target.getMoraleState() > 3 ? 0.15 : modifier_defender_morale;
		
		local chance_defend = this.Math.floor((target.getBravery()/(chance_attack) - 0.25 + modifier_defender_morale) * 100);
		chance_defend = this.Math.minf(100, this.Math.maxf(0, chance_defend)); //make sure chance is within bounds
		chance_defend = target.getMoraleState() == this.Const.MoraleState.Ignore ? 0 : chance_defend;

		return 100 - chance_defend;

	}

	function getHitFactors( _targetTile )
	{
		local ret = [];
		local _user = this.getContainer().getActor();
		local target = _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null;
		
		if (target == null)
		{
			return ret;
		}
		
		local hasMastery = this.getContainer().getActor().getFlags().has("alp_8");
		local masteryModifier = hasMastery ?  1.1 : 1.0;
		local chance_attack = _user.getBravery() * masteryModifier;
		
		local modifier_defender_morale = 0;
		modifier_defender_morale = target.getMoraleState() < 3 ? -0.15 : modifier_defender_morale;
		modifier_defender_morale = target.getMoraleState() > 3 ? 0.15 : modifier_defender_morale;
		
		local chance_defend = this.Math.floor((target.getBravery()/(chance_attack) - 0.25 + modifier_defender_morale) * 100);
		chance_defend = this.Math.minf(100, this.Math.maxf(0, chance_defend)); //make sure chance is within bounds
		chance_defend = target.getMoraleState() == this.Const.MoraleState.Ignore ? 0 : chance_defend;

		if (target.isNonCombatant())
		{
			ret.push({
				icon = "ui/icons/cancel.png",
				text = "Why?"
			});
			return ret;
		}

		if (!this.isViableTarget(_user, target))
		{
			ret.push({
				icon = "ui/icons/cancel.png",
				text = "Immune to sleep"
			});
			return ret;
		}

		if (target.getCurrentProperties().IsStunned)
		{
			ret.push({
				icon = "ui/icons/cancel.png",
				text = "Can\'t put to sleep right now"
			});
			return ret;
		}

		if (target.isAlliedWith(_user))
		{
			ret.push({
				icon = "ui/icons/cancel.png",
				text = "Allied"
			});
			return ret;
		}

		if (target.getMoraleState() == this.Const.MoraleState.Ignore)
		{
			ret.push({
				icon = "ui/icons/cancel.png",
				text = "Can\'t resist"
			});
			return ret;
		}

		ret.extend([
			{
				icon = "ui/icons/bravery.png",
				text = "Target\'s resolve: [color=#0b0084]" + target.getBravery() + "[/color]"
			}
		]);

		if (hasMastery)
		{
			ret.extend([
				{
					icon = "ui/icons/bravery.png",
					text = "Resolve: [color=#0b0084]" + _user.getBravery() * 1.1 + "[/color]"
				}
			]);
		}
		else
		{
			ret.extend([
				{
					icon = "ui/icons/bravery.png",
					text = "Resolve: [color=#0b0084]" + _user.getBravery() + "[/color]"
				}
			]);
		}

		local calculated_chance = this.Math.floor(target.getBravery()/(chance_attack) * 100);
		ret.extend([
			{
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + target.getBravery() + "[/color]" + " / [color=" + this.Const.UI.Color.PositiveValue + "]" + chance_attack + "[/color] = " + "[color=" + this.Const.UI.Color.NegativeValue + "]" + calculated_chance + "[/color]%"
			}
		]);

		ret.extend([
			{
				icon = "ui/tooltips/positive.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "] -25%[/color] (Base hit chance)"
			}
		]);

		if (target.getMoraleState() > 3)
		{
			ret.extend([
				{
					icon = "ui/tooltips/negative.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 15 + "%[/color] (High Morale)"
				}
			]);
		}
		else if (target.getMoraleState() < 3)
		{
			ret.extend([
				{
					icon = "ui/tooltips/positive.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + 15 + "%[/color] (Low Morale)"
				}
			]);
		}
		ret.extend([
			{
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + chance_defend + "[/color]% chance to defend"
			}
		]);

		return ret;
	}

});

