::Const.Strings.PerkName.SpecHammerC <- "Hammer Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecHammerC].Name = ::Const.Strings.PerkName.SpecHammerC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecHammerC].Tooltip = ::Const.Strings.PerkDescription.SpecHammer;

this.perk_mastery_hammerc <- this.inherit("scripts/skills/perks/perk_mastery_hammer", {
	m = {},
	function create()
	{
		this.perk_mastery_hammer.create();
		this.m.ID = "perk.mastery.hammerc";
		this.m.Name = ::Const.Strings.PerkName.SpecHammerC;
	}
});

