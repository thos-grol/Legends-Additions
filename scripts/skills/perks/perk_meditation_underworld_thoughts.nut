::Const.Strings.PerkName.MeditationUnderworldThoughts <- "Underworld Thoughts";
::Const.Strings.PerkDescription.MeditationUnderworldThoughts <- ::MSU.Text.color(::Z.Color.Purple, "Meditation")
+ "\nJourney through the underworld..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Improves summoned undead:")
+ "\n"+::MSU.Text.colorGreen("+33%") + " chance to survive being struck down (Base: 33%)"
+ "\n\n"+::MSU.Text.colorRed("Unlocks winter potion recipe, but an alchemist and anatomist is needed");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.MeditationUnderworldThoughts].Name = ::Const.Strings.PerkName.MeditationUnderworldThoughts;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.MeditationUnderworldThoughts].Tooltip = ::Const.Strings.PerkDescription.MeditationUnderworldThoughts;

this.perk_meditation_underworld_thoughts <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.meditation.underworld_thoughts";
		this.m.Name = ::Const.Strings.PerkName.MeditationUnderworldThoughts;
		this.m.Description = ::Const.Strings.PerkDescription.MeditationUnderworldThoughts;
		this.m.Icon = "ui/perks/perk_04.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.NoRefund <- true;
	}

	function onAdded()
	{
		this.World.Statistics.getFlags().set("potion_winter", true);
	}


});

