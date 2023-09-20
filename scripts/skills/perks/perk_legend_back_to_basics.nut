::Const.Strings.PerkDescription.LegendBackToBasics = "The basics make a master..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+2") + " perk points, "
+ "\n" + ::MSU.Text.colorRed("Resets this unit\'s perk row to 3")
+ "\n\n" + ::MSU.Text.colorRed("Is not refundable");


::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendBackToBasics].Tooltip = ::Const.Strings.PerkDescription.LegendBackToBasics;

this.perk_legend_back_to_basics <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_back_to_basics";
		this.m.Name = this.Const.Strings.PerkName.LegendBackToBasics;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBackToBasics;
		this.m.Icon = "ui/perks/back_to_basics_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("perk_back_to_basics")) return;
		if (!::MSU.isKindOf(actor, "player"))  return;

		actor.m.PerkPointsSpent = 2;
		actor.m.PerkPoints += 2;
		actor.getFlags().set("perk_back_to_basics", true);
	}

});

