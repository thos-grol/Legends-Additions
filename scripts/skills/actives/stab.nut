this.stab <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.stab";
		this.m.Name = "Stab";
		this.m.Description = "A quick and fast stab.";
		this.m.KilledString = "Stabbed";
		this.m.Icon = "skills/active_03.png";
		this.m.IconDisabled = "skills/active_03_sw.png";
		this.m.Overlay = "active_03";
		this.m.SoundOnUse = [
			"sounds/combat/stab_01.wav",
			"sounds/combat/stab_02.wav",
			"sounds/combat/stab_03.wav"
		];
		this.m.SoundOnHitHitpoints = [
			"sounds/combat/stab_hit_01.wav",
			"sounds/combat/stab_hit_02.wav",
			"sounds/combat/stab_hit_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsWeaponSkill = true;
		this.m.InjuriesOnBody = ::Const.Injury.PiercingBody;
		this.m.InjuriesOnHead = ::Const.Injury.PiercingHead;
		this.m.DirectDamageMult = 0.2;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 7;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		return ret;
	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInSwords)
		{
			this.m.FatigueCostMult = ::Const.Combat.WeaponSpecFatigueMult;
		}
		this.m.ActionPointCost = 3;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

