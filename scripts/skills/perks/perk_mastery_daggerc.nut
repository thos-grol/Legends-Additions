::Const.Strings.PerkName.SpecDaggerC <- "Dagger Mastery";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecDaggerC].Name = ::Const.Strings.PerkName.SpecDaggerC;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecDaggerC].Tooltip = ::Const.Strings.PerkDescription.SpecDagger;

this.perk_mastery_daggerc <- this.inherit("scripts/skills/perks/perk_mastery_dagger", {
	m = {},
	function create()
	{
		this.perk_mastery_dagger.create();
		this.m.ID = "perk.mastery.daggerc";
		this.m.Name = this.Const.Strings.PerkName.SpecDaggerC;
	}
});

