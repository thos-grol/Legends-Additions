::Const.Strings.PerkName.Dismemberment <- "Dismemberment";
::Const.Strings.PerkDescription.Dismemberment <- "Learn to butcher flesh..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Attacks inflict:")
+ "\n"+::MSU.Text.colorGreen("– X%") + " injury resistance"
+ "\n"+::MSU.Text.colorRed("X is 35% of maximum damage")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Cutting attacks:")
+ "\nCan apply injuries to the undead";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Dismemberment].Name = ::Const.Strings.PerkName.Dismemberment;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Dismemberment].Tooltip = ::Const.Strings.PerkDescription.Dismemberment;

this.perk_dismemberment <- this.inherit("scripts/skills/skill", {
	m = {
		PercentageOfMaximumDamage = 35,
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.dismemberment";
		this.m.Name = ::Const.Strings.PerkName.Dismemberment;
		this.m.Description = ::Const.Strings.PerkDescription.Dismemberment;
		this.m.Icon = "ui/perks/dismemberment.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack())
		{
			_properties.ThresholdToInflictInjuryMult *= 1.0 - (this.m.PercentageOfMaximumDamage * 0.01 * _properties.getDamageRegularMax() * 0.01);
		}
	}
});
