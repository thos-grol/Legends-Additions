::Const.Strings.PerkName.SpecFistC <- "Fist Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecFistC].Name = ::Const.Strings.PerkName.SpecFistC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecFistC].Tooltip = ::Const.Strings.PerkDescription.LegendSpecFists;

this.perk_mastery_fistc <- this.inherit("scripts/skills/perks/perk_mastery_fist", {
	m = {},
	function create()
	{
		this.perk_mastery_fist.create();
		this.m.ID = "perk.mastery.fistc";
		this.m.Name = ::Const.Strings.PerkName.SpecFistC;
	}
});

