::Const.Strings.PerkName.ResearchRottenOffering <- "Research - Rotten Offering";
::Const.Strings.PerkDescription.ResearchRottenOffering <- "Offer decaying flesh as the sacrement..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Mark of Decay:")
+ "\n"+ ::MSU.Text.colorGreen("+ 200%") + " target attraction to the marked unit"
+ "\nUnits killed with Mark of Decay have a 10% chance to be reanimated on round end";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ResearchRottenOffering].Name = ::Const.Strings.PerkName.ResearchRottenOffering;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ResearchRottenOffering].Tooltip = ::Const.Strings.PerkDescription.ResearchRottenOffering;

this.perk_research_rotten_offering <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.research.rotten_offering";
		this.m.Name = ::Const.Strings.PerkName.ResearchRottenOffering;
		this.m.Description = ::Const.Strings.PerkDescription.ResearchRottenOffering;
		this.m.Icon = "ui/perks/strange_strikes.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
});
