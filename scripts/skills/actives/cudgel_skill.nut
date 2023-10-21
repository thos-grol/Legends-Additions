this.cudgel_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.cudgel";
		this.m.Name = "Cudgel";
		this.m.Description = "A slow overhead strike performed with full force to cudgel a target to pulp. Anyone hit with a blow like this will be dazed and gasping for air, unable to put full force behind their blows for two turns.";
		this.m.KilledString = "Cudgeled to death";
		this.m.Icon = "skills/active_133.png";
		this.m.IconDisabled = "skills/active_133_sw.png";
		this.m.Overlay = "active_133";
		this.m.SoundOnUse = [
			"sounds/combat/cudgel_01.wav",
			"sounds/combat/cudgel_02.wav",
			"sounds/combat/cudgel_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/cudgel_hit_01.wav",
			"sounds/combat/cudgel_hit_02.wav",
			"sounds/combat/cudgel_hit_03.wav",
			"sounds/combat/cudgel_hit_04.wav"
		];
		this.m.SoundVolume = 1.25;
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.BluntBody;
		this.m.InjuriesOnHead = ::Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.5;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.ChanceDecapitate = 0;
		this.m.ChanceDisembowel = 0;
		this.m.ChanceSmash = 66;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		ret.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Inflicts [color=" + ::Const.UI.Color.DamageValue + "]" + ::Const.Combat.FatigueReceivedPerHit * 4 + "[/color] extra fatigue"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a [color=" + ::Const.UI.Color.PositiveValue + "]100%[/color] chance to daze on a hit"
		});
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInHammers ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectBash);
		local success = this.attackEntity(_user, target);

		if (!_user.isAlive() || _user.isDying())
		{
			return success;
		}

		if (success && target.isAlive() && !target.getCurrentProperties().IsImmuneToDaze)
		{
			target.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

			if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " struck a blow that leaves " + ::Const.UI.getColorizedEntityName(target) + " dazed");
			}
		}

		return success;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			_properties.DamageRegularMin += 20;
			_properties.DamageRegularMax += 20;
			_properties.FatigueDealtPerHitMult += 4.0;
		}
	}

});

