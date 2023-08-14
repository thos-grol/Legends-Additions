this.magic_skill <- this.inherit("scripts/skills/skill", {
	m = {
		ManaCost = 1,
		Cooldown_Max = 0,
		Cooldown = 0,
		Duration = 0,
		AdditionalAccuracy = 0,
		AdditionalHitChance = 0
	},
	function create()
	{
	}

	function getTooltip()
	{
		return this.getDefaultTooltip();
	}

	function onUpdate( _properties )
	{
		// _properties.DamageInitiativeMin = this.m.DamageInitiativeMin;
		// _properties.DamageInitiativeMax = this.m.DamageInitiativeMax;
		// _properties.DamageInitiativeCutoff = this.m.DamageInitiativeCutoff;
	}

	function onTurnStart()
	{
		if (this.m.Cooldown > 0) this.m.Cooldown--;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this)
		{
			local mana_pool = a.getSkills().getSkillByID("trait.mana_pool");
			mana_pool.remove_mana(this.m.ManaCost);
			this.m.Cooldown = this.m.Cooldown_Max;

			// _properties.DamageRegularMin = _properties.getInitiativeMinDamage();
			// _properties.DamageRegularMax = _properties.getInitiativeMaxDamage();
			_properties.RangedSkill += this.m.AdditionalAccuracy;
			_properties.MeleeSkill += this.m.AdditionalAccuracy;
			_properties.HitChanceAdditionalWithEachTile += this.m.AdditionalHitChance;
		}
	}

	function isUsable()
	{
		if (this.m.Cooldown > 0) return false;

		local a = this.m.Container.getActor();
		if (!this.m.IsUsable || !a.getCurrentProperties().IsAbleToUseSkills) return false;
		if (!a.getSkills().hasSkill("trait.mana_pool")) return false;

		local mana_pool = a.getSkills().getSkillByID("trait.mana_pool");
		return mana_pool.can_pay(this.m.ManaCost);
	}

});

