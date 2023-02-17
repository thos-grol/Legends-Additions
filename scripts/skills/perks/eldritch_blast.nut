this.eldritch_blast <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.eldritch_blast";
		this.m.Name = ::Const.Strings.PerkName.EldritchBlast;
		this.m.Description = ::Const.Strings.PerkDescription.EldritchBlast;
		this.m.Icon = "ui/perks/eldritch_blast.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.eldritch_blast"))
		{
			this.m.Container.add(::new("scripts/skills/actives/eldritch_blast"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.eldritch_blast");
	}

	function onUpdated( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}

});