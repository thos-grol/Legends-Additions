::Const.Strings.PerkName.SpecAxeC <- "Axe Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecAxeC].Name = ::Const.Strings.PerkName.SpecAxeC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecAxeC].Tooltip = ::Const.Strings.PerkDescription.SpecAxe;

this.perk_mastery_axec <- this.inherit("scripts/skills/perks/perk_mastery_axe", {
	m = {},
	function create()
	{
		this.perk_mastery_axe.create();
		this.m.ID = "perk.mastery.axec";
		this.m.Name = this.Const.Strings.PerkName.SpecAxeC;
	}
});

