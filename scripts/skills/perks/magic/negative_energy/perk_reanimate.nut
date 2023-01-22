this.perk_reanimate <- this.inherit("scripts/skills/magic_perk", {
	m = {},
	function create()
	{
		this.m.ID = "perk.negative_energy_hand";
		this.m.Name = this.Const.Strings.PerkName.Reanimate;
		this.m.Description = this.Const.Strings.PerkDescription.Reanimate;
		this.m.Icon = "skills/active_26.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.School = this.Const.Magic.Type.NegativeEnergy;
	}

	function onAddedSuccessful()
	{
		if (!this.m.Container.hasSkill("actives.reanimate"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/reanimate"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.reanimate");
	}

});

