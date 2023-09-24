::Const.Strings.PerkName.SpecMaceC <- "Mace Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecMaceC].Name = ::Const.Strings.PerkName.SpecMaceC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecMaceC].Tooltip = ::Const.Strings.PerkDescription.SpecMace;

this.perk_mastery_macec <- this.inherit("scripts/skills/perks/perk_mastery_mace", {
	m = {},
	function create()
	{
		this.perk_mastery_mace.create();
		this.m.ID = "perk.mastery.macec";
		this.m.Name = ::Const.Strings.PerkName.SpecMaceC;
	}
});

