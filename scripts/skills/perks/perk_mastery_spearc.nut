::Const.Strings.PerkName.SpecSpearC <- "Spear Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSpearC].Name = ::Const.Strings.PerkName.SpecSpearC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSpearC].Tooltip = ::Const.Strings.PerkDescription.SpecSpear;

this.perk_mastery_spearc <- this.inherit("scripts/skills/perks/perk_mastery_spear", {
	m = {},
	function create()
	{
		this.perk_mastery_spear.create();
		this.m.ID = "perk.mastery.spearc";
		this.m.Name = ::Const.Strings.PerkName.SpecSpearC;
	}
});

