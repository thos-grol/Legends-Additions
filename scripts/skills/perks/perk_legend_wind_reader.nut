::Const.Strings.PerkName.LegendWindReader = "Wind Reader";
::Const.Strings.PerkDescription.LegendWindReader = "Read the wind, calculate trajectories..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("+5") + " Attack"
+ "\n"+::MSU.Text.colorGreen("+10") + " Defense";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendWindReader].Name = ::Const.Strings.PerkName.LegendWindReader;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendWindReader].Tooltip = ::Const.Strings.PerkDescription.LegendWindReader;

this.perk_legend_wind_reader <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_wind_reader";
		this.m.Name = ::Const.Strings.PerkName.LegendWindReader;
		this.m.Description = ::Const.Strings.PerkDescription.LegendWindReader;
		this.m.Icon = "ui/perks/wind_reader.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 5;
		_properties.MeleeDefense += 10;
	}

});

