//TODO: rewrite using new format
::Const.Strings.PerkName.SunderingStrikes = "Sundering Strikes";
::Const.Strings.PerkDescription.SunderingStrikes = "This character's immense strength cause them to sunder both armor and flesh..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n• For any weapon:"
+ "\n• " + ::MSU.Text.colorGreen("+20%") + " armor damage"
+ "\n• " + ::MSU.Text.colorGreen("+33%") + " injury threshold.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SunderingStrikes].Name = ::Const.Strings.PerkName.SunderingStrikes;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SunderingStrikes].Tooltip = ::Const.Strings.PerkDescription.SunderingStrikes;

this.perk_sundering_strikes <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.sundering_strikes";
		this.m.Name = this.Const.Strings.PerkName.SunderingStrikes;
		this.m.Description = this.Const.Strings.PerkDescription.SunderingStrikes;
		this.m.Icon = "ui/perks/sunderingstrikes_circle.png";
		this.m.IconDisabled = "ui/perks/sunderingstrikes_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.DamageArmorMult += 0.2;
		_properties.ThresholdToInflictInjuryMult *= 0.66;
	}

});

