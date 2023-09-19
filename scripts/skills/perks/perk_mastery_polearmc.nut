::Const.Strings.PerkName.SpecPolearmC <- "Polearm Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecPolearmC].Name = ::Const.Strings.PerkName.SpecPolearmC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecPolearmC].Tooltip = ::Const.Strings.PerkDescription.SpecPolearm;

this.perk_mastery_polearmc <- this.inherit("scripts/skills/perks/perk_mastery_polearm", {
	m = {},
	function create()
	{
		this.perk_mastery_polearm.create();
		this.m.ID = "perk.mastery.polearmc";
		this.m.Name = this.Const.Strings.PerkName.SpecPolearmC;
	}
});

