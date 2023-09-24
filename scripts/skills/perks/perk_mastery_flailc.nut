::Const.Strings.PerkName.SpecFlailC <- "Flail Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecFlailC].Name = ::Const.Strings.PerkName.SpecFlailC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecFlailC].Tooltip = ::Const.Strings.PerkDescription.SpecFlail;

this.perk_mastery_flailc <- this.inherit("scripts/skills/perks/perk_mastery_flail", {
	m = {},
	function create()
	{
		this.perk_mastery_flail.create();
		this.m.ID = "perk.mastery.flailc";
		this.m.Name = ::Const.Strings.PerkName.SpecFlailC;
	}
});

