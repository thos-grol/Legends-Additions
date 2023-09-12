::Const.Strings.PerkName.FortifiedMind = "Inner Faith";
::Const.Strings.PerkDescription.FortifiedMind = "Faith can move mountains..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n"+::MSU.Text.colorGreen("+25%") + " Resolve"
+ "\nRemoves "+::MSU.Text.colorRed("Superstitious, Dastard, Insecure, and Craven") + " from this unit";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.FortifiedMind].Name = ::Const.Strings.PerkName.FortifiedMind;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.FortifiedMind].Tooltip = ::Const.Strings.PerkDescription.FortifiedMind;

this.perk_fortified_mind <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.fortified_mind";
		this.m.Name = this.Const.Strings.PerkName.FortifiedMind;
		this.m.Description = this.Const.Strings.PerkDescription.FortifiedMind;
		this.m.Icon = "ui/perks/perk_08.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.BraveryMult *= 1.25;
	}

	function onAdded()
	{
		if (this.m.Container.hasSkill("trait.superstitious")) this.m.Container.removeByID("trait.superstitious");
		if (this.m.Container.hasSkill("trait.dastard")) this.m.Container.removeByID("trait.dastard");
		if (this.m.Container.hasSkill("trait.insecure")) this.m.Container.removeByID("trait.insecure");
		if (this.m.Container.hasSkill("trait.craven")) this.m.Container.removeByID("trait.craven");
	}

});

