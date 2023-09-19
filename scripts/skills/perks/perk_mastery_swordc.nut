::Const.Strings.PerkName.SpecSwordC <- "Sword Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSwordC].Name = ::Const.Strings.PerkName.SpecSwordC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSwordC].Tooltip = ::Const.Strings.PerkDescription.SpecSword;

this.perk_mastery_swordc <- this.inherit("scripts/skills/perks/perk_mastery_sword", {
	m = {},
	function create()
	{
		this.perk_mastery_sword.create();
		this.m.ID = "perk.mastery.swordc";
		this.m.Name = this.Const.Strings.PerkName.SpecSwordC;
	}
});

