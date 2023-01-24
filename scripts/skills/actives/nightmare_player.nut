this.nightmare_player <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.nightmare_player";
		this.m.Name = "Nightmare";
		this.m.Description = "Torment the victim's soul lured into sleep with nightmares, bringing them ever closer to oblivion. The damage from nigtmares increases as your resolve is stronger than that of the victim's.";
		this.m.KilledString = "Died of nightmares";
		this.m.Icon = "skills/active_117.png";
		this.m.IconDisabled = "skills/active_117_sw.png";
		this.m.Overlay = "active_117";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/alp_nightmare_01.wav",
			"sounds/enemies/dlc2/alp_nightmare_02.wav",
			"sounds/enemies/dlc2/alp_nightmare_03.wav",
			"sounds/enemies/dlc2/alp_nightmare_04.wav",
			"sounds/enemies/dlc2/alp_nightmare_05.wav",
			"sounds/enemies/dlc2/alp_nightmare_06.wav"
		];
		this.m.IsUsingActorPitch = true;
		this.m.Type = ::Const.SkillType.Active | ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted + 1;
		this.m.IsRemovedAfterBattle = false;
		this.m.Delay = 400;
		this.m.IsSerialized = true;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingHitchance = false;
		this.m.IsDoingForwardMove = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.DirectDamageMult = 1.0;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + ::Const.UI.Color.DamageValue + "]" + 15 + "[/color] - [color=" + ::Const.UI.Color.DamageValue + "]" + 35 + "[/color] mental damage to hitpoints"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + ::Const.UI.Color.PositiveValue + "]" + this.m.MaxRange + "[/color] tiles"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "Damage is multiplied by the ratio between the character\'s and target\'s resolve"
			}
		]);
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.ActionPointCost = this.getContainer().getActor().getFlags().has("alp_8") ? 3 : 4;
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

		local b = this.getContainer().getActor().getAIAgent().getBehavior(::Const.AI.Behavior.ID.AttackDefault);
		local myTile = this.getContainer().getActor().getTile();
		local targets = b.queryTargetsInMeleeRange(this.getMinRange(), this.getMaxRange());
		
		foreach( t in targets )
		{
			if (this.onVerifyTarget(myTile, t.getTile()))
			{
				return true;
			}
		}

		return false;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		return _targetTile.getEntity().getSkills().getSkillByID("effects.sleeping") != null;
	}

	function onUpdate( _properties )
	{
		_properties.IsIgnoringArmorOnAttack = true;
	}

	function onUse( _user, _targetTile )
	{
		local tag = {
			User = _user,
			TargetTile = _targetTile
		};

		if (_targetTile.IsVisibleForPlayer || !_user.isHiddenToPlayer())
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, this.onDelayedEffect.bindenv(this), tag);
		}
		else
		{
			this.onDelayedEffect(tag);
		}

		return true;
	}

	function onDelayedEffect( _tag )
	{
		local targetTile = _tag.TargetTile;
		local user = _tag.User;
		local target = targetTile.getEntity();
		local hitInfo = clone ::Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.Math.rand(this.getDamage(target, 15), this.getDamage(target, 35));
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = ::Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		target.onDamageReceived(user, this, hitInfo);
	}

	function getDamage( _actor, baseDamage )
	{
		if (_actor == null)
		{
			return 0;
		}
		local hasMastery = this.getContainer().getActor().getFlags().has("alp_8");
		local masteryModifier = hasMastery ?  1.1 : 1.0;
		local multiplier = this.m.Container.getActor().getCurrentProperties().getBravery() * masteryModifier / _actor.getCurrentProperties().getBravery()
		return this.Math.maxf(this.Math.floor(baseDamage * multiplier), 0);
	}

	function getHitFactors( _targetTile )
	{
		local ret = [];
		local _user = this.m.Container.getActor();
		local target = _targetTile.IsOccupiedByActor ? _targetTile.getEntity() : null;

		if (target == null)
		{
			return ret;
		}
		ret.extend([
			{
				icon = "ui/icons/bravery.png",
				text = "Target\'s resolve: [color=#0b0084]" + target.getCurrentProperties().getBravery() + "[/color]"
			}
		]);

		local hasMastery = _user.getFlags().has("alp_8");
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

		local masteryModifier = hasMastery ?  1.1 : 1.0;
		local chance_attack = _user.getBravery() * masteryModifier;
		local diff_modifier = chance_attack / target.getBravery()
		ret.extend([
			{
				icon = "ui/icons/special.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]" + chance_attack + "[/color]" + " / [color=" + ::Const.UI.Color.NegativeValue + "]" + target.getBravery() + "[/color] = " + diff_modifier + "x damage"
			}
		]);

		ret.extend([
			{
				icon = "ui/icons/regular_damage.png",
				text = "Inflicts [color=" + ::Const.UI.Color.DamageValue + "]" + this.getDamage(target, 10) + "[/color] - [color=" + ::Const.UI.Color.DamageValue + "]" + this.getDamage(target, 25) + "[/color] damage to hitpoints, ignoring armor."
			}
		]);

		return ret;
		
	}

});

