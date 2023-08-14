this.perk_meditation_underworld_thoughts <- this.inherit("scripts/skills/magic_perk", {
	m = {},
	function create()
	{
		this.m.ID = "perk.meditation_underworld_thoughts";
		this.m.Name = ::Const.Strings.PerkName.MeditiationUnderworldThoughts;
		this.m.Description = ::Const.Strings.PerkDescription.MeditiationUnderworldThoughts;
		this.m.Icon = "ui/perks/meditation_underworld.png";
		this.m.IconDisabled = "ui/perks/meditation_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.School = ::Const.Magic.Type.NegativeEnergy;
	}

	function onAddedSuccessful()
	{
		if (!this.m.Container.hasSkill("actives.battle_meditation"))
		{
			this.m.Container.add(::new("scripts/skills/actives/battle_meditation"));
		}
	}

	function onRemoved()
	{
	}

});

