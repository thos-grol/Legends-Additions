::Const.Strings.PerkName.LegendAlert = "Fast";
::Const.Strings.PerkDescription.LegendAlert = "Fast, like the wind..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.colorGreen("+20%") + " Initiative";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAlert].Name = ::Const.Strings.PerkName.LegendAlert;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAlert].Tooltip = ::Const.Strings.PerkDescription.LegendAlert;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAlert].Icon = "ui/perks/rf_blitzkrieg.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendAlert].IconDisabled = "ui/perks/rf_blitzkrieg_bw.png";

this.perk_legend_alert <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_alert";
		this.m.Name = this.Const.Strings.PerkName.LegendAlert;
		this.m.Description = this.Const.Strings.PerkDescription.LegendAlert;
		this.m.Icon = "ui/perks/rf_blitzkrieg.png";
		this.m.IconDisabled = "ui/perks/rf_blitzkrieg_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 1.2;
	}

});

