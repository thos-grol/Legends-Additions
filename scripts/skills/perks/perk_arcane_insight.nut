::Const.Strings.PerkName.ArcaneInsight <- "Arcane Insight";
::Const.Strings.PerkDescription.ArcaneInsight <- "Further inquiry into the arcane is the polishing of the mind..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("+1") + " Bright Trait tier"
+ "\n " + ::MSU.Text.colorRed("Non-refundable");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ArcaneInsight].Name = ::Const.Strings.PerkName.ArcaneInsight;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.ArcaneInsight].Tooltip = ::Const.Strings.PerkDescription.ArcaneInsight;

this.perk_arcane_insight <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.arcane_insight";
		this.m.Name = ::Const.Strings.PerkName.ArcaneInsight;
		this.m.Description = ::Const.Strings.PerkDescription.ArcaneInsight;
		this.m.Icon = "ui/perks/arcane_insight.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("trait.bright")) return;
		local bright = this.getContainer().getSkillByID("trait.bright");
		bright.upgrade();
	}
});
