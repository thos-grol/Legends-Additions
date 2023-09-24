::Const.Strings.PerkName.SpecCrossbowC <- "Crossbow Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecCrossbowC].Name = ::Const.Strings.PerkName.SpecCrossbowC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecCrossbowC].Tooltip = ::Const.Strings.PerkDescription.SpecCrossbow;

this.perk_mastery_crossbowc <- this.inherit("scripts/skills/perks/perk_mastery_crossbow", {
	m = {},
	function create()
	{
		this.perk_mastery_crossbow.create();
		this.m.ID = "perk.mastery.crossbowc";
		this.m.Name = ::Const.Strings.PerkName.SpecCrossbowC;
	}
});

