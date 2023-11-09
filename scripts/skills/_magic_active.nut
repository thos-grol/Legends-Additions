this._magic_active <- this.inherit("scripts/skills/skill", {
	m = {
		ManaCost = 1,
		Cooldown_Max = 0,
		Cooldown = 0,
	},
	function create()
	{
	}

	function getTooltip() //TODO: examine, add mana info
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [
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
	}

	function onTurnStart()
	{
		if (this.m.Cooldown > 0) this.m.Cooldown--;
	}

	function onUse( _user, _targetTile )
	{
		local mana_pool = a.getSkills().getSkillByID("trait.mana_pool");
		mana_pool.modify(this.m.ManaCost * -1);
		this.m.Cooldown = this.m.Cooldown_Max;
		cast(_user, _targetTile);

		return true;
	}

	function cast( _user, _targetTile )
	{
	}

	function isUsable()
	{
		if (this.m.Cooldown > 0) return false;

		local a = this.m.Container.getActor();
		if (!this.m.IsUsable || !a.getCurrentProperties().IsAbleToUseSkills) return false;
		if (!a.getSkills().hasSkill("trait.mana_pool")) return false;

		local mana_pool = a.getSkills().getSkillByID("trait.mana_pool");
		return mana_pool.is_payable(this.m.ManaCost);
	}

});

