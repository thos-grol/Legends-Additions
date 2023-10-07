::Const.Strings.PerkName.SpecRangedC <- "Ranged Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecRangedC].Name = ::Const.Strings.PerkName.SpecRangedC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecRangedC].Tooltip = ::Const.Strings.PerkDescription.SpecBow;

this.perk_mastery_rangedc <- this.inherit("scripts/skills/perks/perk_mastery_bow", {
	m = {},
	function create()
	{
		this.perk_mastery_bow.create();
		this.m.ID = "perk.mastery.rangedc";
		this.m.Name = ::Const.Strings.PerkName.SpecRangedC;
	}
});

