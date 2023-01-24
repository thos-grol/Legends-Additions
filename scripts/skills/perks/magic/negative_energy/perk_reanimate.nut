this.perk_reanimate <- this.inherit("scripts/skills/magic_perk", {
	m = {},
	function create()
	{
		this.m.ID = "perk.negative_energy_hand";
		this.m.Name = ::Const.Strings.PerkName.Reanimate;
		this.m.Description = ::Const.Strings.PerkDescription.Reanimate;
		this.m.Icon = "skills/active_26.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.School = ::Const.Magic.Type.NegativeEnergy;
	}

	function onAddedSuccessful()
	{
		if (!this.m.Container.hasSkill("actives.reanimate"))
		{
			this.m.Container.add(::new("scripts/skills/actives/reanimate"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.reanimate");
	}

});

