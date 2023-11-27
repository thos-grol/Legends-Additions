::Const.Strings.PerkName.ResearchFleshOverclocking <- "Research - Flesh Overclocking";
::Const.Strings.PerkDescription.ResearchFleshOverclocking <- "Reveal the power hidden in the flesh..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Summoned undead and this unit:")
+ "\n " + ::MSU.Text.colorGreen("– 20%") + " damage taken"
+ "\n " + ::MSU.Text.colorGreen("+10%") + " initiative";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ResearchFleshOverclocking].Name = ::Const.Strings.PerkName.ResearchFleshOverclocking;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ResearchFleshOverclocking].Tooltip = ::Const.Strings.PerkDescription.ResearchFleshOverclocking;

this.perk_research_flesh_overclocking <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.research.flesh_overclocking";
		this.m.Name = ::Const.Strings.PerkName.ResearchFleshOverclocking;
		this.m.Description = ::Const.Strings.PerkDescription.ResearchFleshOverclocking;
		this.m.Icon = "ui/perks/strange_strikes.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedTotalMult *= 0.8;
		_properties.InitiativeMult *= 1.1;
	}
});
