this.perk_meditation_underworld_thoughts <- this.inherit("scripts/skills/magic_perk", {
	m = {},
	function create()
	{
		this.m.ID = "perk.meditation_underworld_thoughts";
		this.m.Name = this.Const.Strings.PerkName.MeditiationUnderworldThoughts;
		this.m.Description = this.Const.Strings.PerkDescription.MeditiationUnderworldThoughts;
		this.m.Icon = "ui/perks/meditation_underworld.png";
		this.m.IconDisabled = "ui/perks/meditation_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.School = this.Const.Magic.Type.NegativeEnergy;
	}

	function onAddedSuccessful()
	{
		if (!this.m.Container.hasSkill("actives.battle_meditation"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/battle_meditation"));
		}
	}

	function onRemoved()
	{
	}

});

