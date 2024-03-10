this.thresh_berserk_chain <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 20,
		SoundsA = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		],
		SoundsB = [
			"sounds/combat/chop_hit_01.wav",
			"sounds/combat/chop_hit_02.wav",
			"sounds/combat/chop_hit_03.wav"
		]
	},
	function create()
	{
		this.m.ID = "actives.thresh";
		this.m.Name = "Thresh";
		this.m.Description = "Threshing all the targets around you, foe and friend alike, with a reckless round swing. Not hard to evade because it is not aimed at anything, but can be devastating if it connects. Has a chance to stun targets hit for one turn. Be careful around your own men unless you want to relieve your payroll!";
		this.m.KilledString = "Smashed";
		this.m.Icon = "skills/active_46.png";
		this.m.IconDisabled = "skills/active_46_sw.png";
		this.m.Overlay = "active_46";
		this.m.SoundOnUse = [
			"sounds/combat/thresh_01.wav",
			"sounds/combat/thresh_02.wav",
			"sounds/combat/thresh_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/thresh_hit_01.wav",
			"sounds/combat/thresh_hit_02.wav",
			"sounds/combat/thresh_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAOE = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.HitChanceBonus = -15;
		this.m.DirectDamageMult = 0.3;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 35;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 20;
		this.m.ChanceSmash = 99;
	}

	function addResources()
	{
		foreach( r in this.m.SoundsA )
		{
			this.Tactical.addResource(r);
		}

		foreach( r in this.m.SoundsB )
		{
			this.Tactical.addResource(r);
		}
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local hitchanceBonus = this.m.HitChanceBonus;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
		{
			hitchanceBonus = hitchanceBonus + 5;
		}

		ret.extend([
			{
				id = 7,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]" + hitchanceBonus + "%[/color] chance to hit"
			},
			{
				id = 8,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] chance to stun on a hit"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Can hit up to 6 targets"
			}
		]);

		local dmg = 5;
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts additional stacking [color=" + ::Const.UI.Color.DamageValue + "]" + dmg + "[/color] bleeding damage per turn, for 2 turns"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInFlails ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local ret = false;
		local ownTile = this.m.Container.getActor().getTile();
		local soundBackup = [];
		this.spawnAttackEffect(ownTile, this.Const.Tactical.AttackEffectThresh);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					if (ret && soundBackup.len() == 0)
					{
						soundBackup = this.m.SoundOnHit;
						this.m.SoundOnHit = [];
					}

					local target = _targetTile.getEntity();
					local hp = target.getHitpoints();
					local success = this.attackEntity(_user, target);
					ret = success || ret;

					if (_user.isAlive() && !_user.isDying())
					{
						if (success && tile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned"))
						{
							target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

							if (!_user.isHiddenToPlayer() && tile.IsVisibleForPlayer)
							{
								this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
							}
						}
					}

					if (!target.isAlive() || target.isDying())
					{
						if (this.isKindOf(target, "lindwurm_tail") || !target.getCurrentProperties().IsImmuneToBleeding)
						{
							this.Sound.play(this.m.SoundsA[::Math.rand(0, this.m.SoundsA.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
						}
						else
						{
							this.Sound.play(this.m.SoundsB[::Math.rand(0, this.m.SoundsB.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
						}
					}
					else if (!target.getCurrentProperties().IsImmuneToBleeding && hp - target.getHitpoints() >= ::Const.Combat.MinDamageToApplyBleeding)
					{
						local effect = ::new("scripts/skills/effects/bleeding_effect");
						if (_user.getFaction() == ::Const.Faction.Player) effect.setActor(this.getContainer().getActor());
						effect.setDamage(5);
						target.getSkills().add(effect);

						if (_user.getSkills().hasSkill("perk.legend_lacerate")) 
						{
							effect = ::new("scripts/skills/effects/bleeding_effect");
							if (_user.getFaction() == ::Const.Faction.Player) effect.setActor(this.getContainer().getActor());
							effect.setDamage(5);
							target.getSkills().add(effect);
						}

						this.Sound.play(this.m.SoundsA[::Math.rand(0, this.m.SoundsA.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
					}
					else
					{
						this.Sound.play(this.m.SoundsB[::Math.rand(0, this.m.SoundsB.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
					}
				}
			}
		}

		if (ret && this.m.SoundOnHit.len() == 0)
		{
			this.m.SoundOnHit = soundBackup;
		}

		return ret;
	}

	function onTargetSelected( _targetTile )
	{
		local ownTile = this.m.Container.getActor().getTile();

		for( local i = 0; i != 6; i = ++i )
		{
			if (!ownTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = ownTile.getNextTile(i);

				if (!tile.IsEmpty && tile.getEntity().isAttackable() && this.Math.abs(tile.Level - ownTile.Level) <= 1)
				{
					this.Tactical.getHighlighter().addOverlayIcon(this.Const.Tactical.Settings.AreaOfEffectIcon, tile, tile.Pos.X, tile.Pos.Y);
				}
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
			{
				_properties.MeleeSkill -= 10;
			}
			else
			{
				_properties.MeleeSkill -= 15;
			}
		}
	}

});

