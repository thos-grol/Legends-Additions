this.perk_mastery_crossbow <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.crossbow";
		this.m.Name = this.Const.Strings.PerkName.SpecCrossbow;
		this.m.Description = this.Const.Strings.PerkDescription.SpecCrossbow;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInCrossbows = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Crossbow"))
			this.m.Container.add(this.new("scripts/skills/traits/_proficiency_Crossbow"));
	}

});

