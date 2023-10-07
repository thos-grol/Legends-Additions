this.legend_throw_knife <- this.inherit("scripts/skills/skill", {
	m = {
		AdditionalAccuracy = 5,
		AdditionalHitChance = -10,
		Charges = 3
	},
	function create()
	{
		this.m.ID = "actives.legend_throw_knife";
		this.m.Name = "Throw Knife";
		this.m.Description = "Throw a knife at an enemy.";
		this.m.Icon = "skills/active_87.png";
		this.m.IconDisabled = "skills/active_87_sw.png";
		this.m.Overlay = "active_87";
		this.m.SoundOnUse = [
			"sounds/combat/throw_axe_01.wav",
			"sounds/combat/throw_axe_02.wav",
			"sounds/combat/throw_axe_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/throw_axe_hit_01.wav",
			"sounds/combat/throw_axe_hit_02.wav",
			"sounds/combat/throw_axe_hit_03.wav"
		];
		this.m.SoundOnHitDelay = -150;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.Delay = 750;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = true;
		this.m.IsWeaponSkill = true;
		this.m.IsDoingForwardMove = false;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 2;
		this.m.MaxRange = 3;
		this.m.MaxLevelDifference = 4;
		this.m.ProjectileType = this.Const.ProjectileType.Axe;
		this.m.ProjectileTimeScale = 1.5;
		this.m.IsProjectileRotated = false;
	}

	function getTooltip()
	{
		local ret = this.getRangedTooltip(this.getDefaultTooltip());
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/asset_ammo.png",
			text = "This unit has [color=" + this.Const.UI.Color.PositiveValue + "]" + this.m.Charges + "[/color] throws left"
		});

		return ret;
	}

	function isUsable()
	{
		local has_dagger = false;
		local items = this.getContainer().getActor().getAllItems();
		foreach(i in items)
		{
			if (i.isWeaponType(::Const.Items.WeaponType.Dagger)) has_dagger = true;
		}
		return this.Tactical.isActive() && this.skill.isUsable() && this.m.Charges > 0 && has_dagger;
	}

	function isHidden()
	{
		local has_dagger = false;
		local items = this.getContainer().getActor().getAllItems();
		foreach(i in items)
		{
			if (i.isWeaponType(::Const.Items.WeaponType.Dagger)) has_dagger = true;
		}

		return this.m.Charges <= 0 || !has_dagger;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this) return;
		local actor = this.getContainer().getActor();
		local mhand = actor.getMainhandItem();
		if (mhand != null && !mhand.isWeaponType(::Const.Items.WeaponType.Dagger)) //if mainhand isn't dagger, need to remove weapon properties
		{
			_properties.DamageRegularMin -= mhand.m.RegularDamage;
			_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
			_properties.DamageArmorMult /= mhand.m.ArmorDamageMult;
			_properties.DamageDirectMult /= mhand.m.DirectDamageMult;
		}

		if (!mhand.isWeaponType(::Const.Items.WeaponType.Dagger)) //if mainhand isn't dagger, need to get dagger properties
		{
			local items = this.getContainer().getActor().getAllItems();
			foreach(i in items)
			{
				if (!i.isWeaponType(::Const.Items.WeaponType.Dagger)) continue;
				_properties.DamageRegularMin += i.m.RegularDamage;
				_properties.DamageRegularMax += i.m.RegularDamageMax;
				_properties.DamageArmorMult *= i.m.ArmorDamageMult;
				_properties.DamageDirectMult *= i.m.DirectDamageMult;
				break;
			}
		}

	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Charges = 3;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Charges = ::Math.max(this.m.Charges - 1, 0);
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInDaggers ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

});

