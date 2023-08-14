this.cultist_compassion_ritual <- this.inherit("scripts/skills/skill", {
	m = {
		chance = 0,
		isCombat = false
	},
	function create()
	{
		this.m.ID = "perk.compassion_ritual";
		this.m.Name = ::Const.Strings.PerkName.CompassionRitual;
		this.m.Description = ::Const.Strings.PerkDescription.CompassionRitual;
		this.m.Icon = "ui/perks/compassion_ritual.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.compassion_ritual"))
		{
			this.m.Container.add(::new("scripts/skills/actives/cultist_compassion_ritual"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.compassion_ritual");
	}

	

});

