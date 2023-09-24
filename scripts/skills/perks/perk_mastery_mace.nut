this.perk_mastery_mace <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.mace";
		this.m.Name = ::Const.Strings.PerkName.SpecMace;
		this.m.Description = ::Const.Strings.PerkDescription.SpecMace;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInMaces = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Mace"))
			this.m.Container.add(this.new("scripts/skills/traits/_proficiency_Mace"));
	}

});

