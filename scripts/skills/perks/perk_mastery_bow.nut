this.perk_mastery_bow <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.bow";
		this.m.Name = this.Const.Strings.PerkName.SpecBow;
		this.m.Description = this.Const.Strings.PerkDescription.SpecBow;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.Vision += 1;
		_properties.IsSpecializedInBows = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Bow"))
			this.m.Container.add(this.new("scripts/skills/traits/_proficiency_Bow"));
	}

});

