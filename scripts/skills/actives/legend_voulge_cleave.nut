this.legend_voulge_cleave <- this.inherit("scripts/skills/skill", {
	m = {
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
		this.m.ID = "actives.legend_voulge_cleave";
		this.m.Name = "Cleave";
		this.m.Description = "A brute force cleaving attack that can inflict bleeding wounds if there is no armor absorbing the blow and if the target is able to bleed at all.";
		this.m.KilledString = "Cleaved";
		this.m.Icon = "skills/active_19.png";
		this.m.IconDisabled = "skills/active_19_sw.png";
		this.m.Overlay = "active_19";
		this.m.SoundOnUse = [
			"sounds/combat/cleave_01.wav",
			"sounds/combat/cleave_02.wav",
			"sounds/combat/cleave_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = ::Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 50;
		this.m.ChanceDisembowel = 33;
		this.m.ChanceSmash = 0;
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
		this.m.FatigueCostMult = _properties.IsSpecializedInCleavers ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectChop);
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, _targetTile.getEntity());

		if (!_user.isAlive() || _user.isDying()) return;
		if (success)
		{
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

				if (_user.getFaction() == ::Const.Faction.Player)
				{
					effect.setActor(this.getContainer().getActor());
				}

				effect.setDamage(5);
				target.getSkills().add(effect);
				this.Sound.play(this.m.SoundsA[::Math.rand(0, this.m.SoundsA.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
			}
			else
			{
				this.Sound.play(this.m.SoundsB[::Math.rand(0, this.m.SoundsB.len() - 1)], ::Const.Sound.Volume.Skill, _user.getPos());
			}
		}

		return success;
	}

});

