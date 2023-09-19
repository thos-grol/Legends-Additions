::Const.Strings.PerkName.SpecBowC <- "Bow Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecBowC].Name = ::Const.Strings.PerkName.SpecBowC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecBowC].Tooltip = ::Const.Strings.PerkDescription.SpecBow;

this.perk_mastery_bowc <- this.inherit("scripts/skills/perks/perk_mastery_bow", {
	m = {},
	function create()
	{
		this.perk_mastery_bow.create();
		this.m.ID = "perk.mastery.bowc";
		this.m.Name = this.Const.Strings.PerkName.SpecBowC;
	}
});

