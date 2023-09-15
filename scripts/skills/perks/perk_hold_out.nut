::Const.Strings.PerkName.HoldOut <- "Resilient";
::Const.Strings.PerkDescription.HoldOut <- "Blink and you miss me..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n"+::MSU.Text.colorGreen("– 1 duration for negative status effects")
+ "\n"+::MSU.Text.colorGreen("+8") + " Hitpoints"
+ "\n"+::MSU.Text.colorGreen("+33%") + " chance to survive being struck down (Base: 33%)";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.HoldOut].Name = ::Const.Strings.PerkName.HoldOut;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.HoldOut].Tooltip = ::Const.Strings.PerkDescription.HoldOut;

this.perk_hold_out <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.hold_out";
		this.m.Name = this.Const.Strings.PerkName.HoldOut;
		this.m.Description = this.Const.Strings.PerkDescription.HoldOut;
		this.m.Icon = "ui/perks/perk_04.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.NegativeStatusEffectDuration += -1;
		_properties.Hitpoints += 8;
		_properties.SurviveWithInjuryChanceMult *= 2.0;
	}

});

