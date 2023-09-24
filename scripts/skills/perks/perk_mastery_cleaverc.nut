::Const.Strings.PerkName.SpecCleaverC <- "Cleaver Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecCleaverC].Name = ::Const.Strings.PerkName.SpecCleaverC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecCleaverC].Tooltip = ::Const.Strings.PerkDescription.SpecCleaver;

this.perk_mastery_cleaverc <- this.inherit("scripts/skills/perks/perk_mastery_cleaver", {
	m = {},
	function create()
	{
		this.perk_mastery_cleaver.create();
		this.m.ID = "perk.mastery.cleaverc";
		this.m.Name = ::Const.Strings.PerkName.SpecCleaverC;
	}
});

