::Const.Strings.PerkName.LegendPeaceful = "Clarity";
::Const.Strings.PerkDescription.LegendPeaceful = "Take a glimpse of the landscape and draw it from memory..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+25%") + " Reflex";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendPeaceful].Name = ::Const.Strings.PerkName.LegendPeaceful;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendPeaceful].Tooltip = ::Const.Strings.PerkDescription.LegendPeaceful;

this.perk_legend_peaceful <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_peaceful";
		this.m.Name = ::Const.Strings.PerkName.LegendPeaceful;
		this.m.Description = ::Const.Strings.PerkDescription.LegendPeaceful;
		this.m.Icon = "ui/perks/peaceful_circle.png";
		this.m.IconDisabled = "ui/perks/peaceful_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.RangedDefenseMult *= 1.25;
	}

});

