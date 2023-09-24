this.perk_mastery_dagger <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.dagger";
		this.m.Name = ::Const.Strings.PerkName.SpecDagger;
		this.m.Description = ::Const.Strings.PerkDescription.SpecDagger;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInDaggers = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Dagger"))
			this.m.Container.add(this.new("scripts/skills/traits/_proficiency_Dagger"));
	}

});

