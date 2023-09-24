this.perk_mastery_hammer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.hammer";
		this.m.Name = ::Const.Strings.PerkName.SpecHammer;
		this.m.Description = ::Const.Strings.PerkDescription.SpecHammer;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInHammers = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Hammer"))
			this.m.Container.add(this.new("scripts/skills/traits/_proficiency_Hammer"));
	}

});

