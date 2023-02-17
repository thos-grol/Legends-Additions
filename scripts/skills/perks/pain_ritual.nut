this.pain_ritual <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.pain_ritual";
		this.m.Name = ::Const.Strings.PerkName.PainRitual;
		this.m.Description = ::Const.Strings.PerkDescription.PainRitual;
		this.m.Icon = "ui/perks/pain_ritual.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.pain_ritual"))
		{
			this.m.Container.add(::new("scripts/skills/actives/pain_ritual"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.pain_ritual");
	}

});