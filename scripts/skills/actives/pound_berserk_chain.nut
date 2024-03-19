this.pound_berserk_chain <- this.inherit("scripts/skills/skill", {
	m = {
		StunChance = 30,
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
		this.m.ID = "actives.pound";
		this.m.Name = "Pound (2 tile range)";
		this.m.Description = "Pound the target into the ground with the chain and striking head. Somewhat unpredictable, but able to strike over or around shield cover with a bit of luck. A target hit with enough force may be stunned for one turn.";
		this.m.KilledString = "Pounded to death";
		this.m.Icon = "skills/active_50.png";
		this.m.IconDisabled = "skills/active_50_sw.png";
		this.m.Overlay = "active_50";
		this.m.SoundOnUse = [
			"sounds/combat/pound_01.wav",
			"sounds/combat/pound_02.wav",
			"sounds/combat/pound_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/pound_hit_01.wav",
			"sounds/combat/pound_hit_02.wav",
			"sounds/combat/pound_hit_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsShieldRelevant = false;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.4;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 2;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 66;
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
		local p = this.getContainer().buildPropertiesForUse(this, null);
		local damage_regular_min = this.Math.floor(p.DamageRegularMin * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_regular_max = this.Math.floor(p.DamageRegularMax * p.DamageRegularMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_min = this.Math.floor(p.DamageRegularMin * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_Armor_max = this.Math.floor(p.DamageRegularMax * p.DamageArmorMult * p.DamageTotalMult * p.MeleeDamageMult);
		local damage_direct_max = this.Math.floor(damage_regular_max * (this.m.DirectDamageMult + p.DamageDirectAdd + p.DamageDirectMeleeAdd));
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
		ret.push({
			id = 4,
			type = "text",
			icon = "ui/icons/regular_damage.png",
			text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_regular_max + "[/color] damage to hitpoints, of which [color=" + this.Const.UI.Color.DamageValue + "]0[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_direct_max + "[/color] can ignore armor"
		});

		if (damage_Armor_max > 0)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/armor_damage.png",
				text = "Inflicts [color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_min + "[/color] - [color=" + this.Const.UI.Color.DamageValue + "]" + damage_Armor_max + "[/color] damage to armor"
			});
		}

		if (p.IsSpecializedInFlails)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Hits to the head ignore an additional [color=" + this.Const.UI.Color.PositiveValue + "]20%[/color] of armor"
			});
		}
		else
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Hits to the head ignore an additional [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of armor"
			});
		}

		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.StunChance + "%[/color] chance to stun on a hit"
		});
		ret.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Ignores the bonus to Defense granted by shields"
		});

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
		this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectBash);
		local target = _targetTile.getEntity();
		local hp = target.getHitpoints();
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying()) return success;

		if (success && _targetTile.IsOccupiedByActor && this.Math.rand(1, 100) <= this.m.StunChance && !target.getCurrentProperties().IsImmuneToStun && !target.getSkills().hasSkill("effects.stunned"))
		{
			target.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " has stunned " + this.Const.UI.getColorizedEntityName(target) + " for one turn");
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

		return success;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill == this && _hitInfo.BodyPart == this.Const.BodyPart.Head)
		{
			if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInFlails)
			{
				_hitInfo.DamageDirect += 0.2;
			}
			else
			{
				_hitInfo.DamageDirect += 0.1;
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
		}
	}

});

