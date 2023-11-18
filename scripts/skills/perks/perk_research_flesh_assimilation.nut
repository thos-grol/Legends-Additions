::Const.Strings.PerkName.ResearchFleshAssimilation <- "Research - Flesh Assimilation";
::Const.Strings.PerkDescription.ResearchFleshAssimilation <- "The flesh is eternal..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\nThis unit's flesh servant has a 10% chance to assimilate a perk from a killed enemy"
+ "\n"+::MSU.Text.colorRed("Can only assimilate up to 10 perks");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ResearchFleshAssimilation].Name = ::Const.Strings.PerkName.ResearchFleshAssimilation;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ResearchFleshAssimilation].Tooltip = ::Const.Strings.PerkDescription.ResearchFleshAssimilation;

this.perk_research_flesh_assimilation <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.research.flesh_assimilation";
		this.m.Name = ::Const.Strings.PerkName.ResearchFleshAssimilation;
		this.m.Description = ::Const.Strings.PerkDescription.ResearchFleshAssimilation;
		this.m.Icon = "ui/perks/strange_strikes.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
});
