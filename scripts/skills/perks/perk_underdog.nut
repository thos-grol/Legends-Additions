::Const.Strings.PerkName.Underdog = "Underdog";
::Const.Strings.PerkDescription.Underdog = "Dog or Wolf?"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.colorGreen("+5") + " Surrounded Defense";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Underdog].Name = ::Const.Strings.PerkName.Underdog;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Underdog].Tooltip = ::Const.Strings.PerkDescription.Underdog;

this.perk_underdog <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.underdog";
		this.m.Name = this.Const.Strings.PerkName.Underdog;
		this.m.Description = this.Const.Strings.PerkDescription.Underdog;
		this.m.Icon = "ui/perks/perk_21.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.SurroundedDefense += 5;
	}

});

