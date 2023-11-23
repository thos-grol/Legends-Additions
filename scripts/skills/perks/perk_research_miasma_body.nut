::Const.Strings.PerkName.ResearchMiasmaBody <- "Research - Miasma Body";
::Const.Strings.PerkDescription.ResearchMiasmaBody <- "Reveal the power hidden in the flesh..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On Round Start, For Undead Summons:")
+ "\n All tiles in ZOC have a 33% chance of spawning a miasma cloud that inflicts the decay effect";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ResearchMiasmaBody].Name = ::Const.Strings.PerkName.ResearchMiasmaBody;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ResearchMiasmaBody].Tooltip = ::Const.Strings.PerkDescription.ResearchMiasmaBody;

this.perk_research_miasma_body <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.research.miasma_body";
		this.m.Name = ::Const.Strings.PerkName.ResearchMiasmaBody;
		this.m.Description = ::Const.Strings.PerkDescription.ResearchMiasmaBody;
		this.m.Icon = "ui/perks/strange_strikes.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}
});
