::Const.Strings.PerkName.SunderingStrikes = "Sundering Strikes";
::Const.Strings.PerkDescription.SunderingStrikes = "This character's immense strength cause them to sunder both armor and flesh..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Attacks inflict:")
+ "\n"+::MSU.Text.colorGreen("+X%") + " armor damage"
+ "\n"+::MSU.Text.colorGreen("– X%") + " injury resistance"
+ "\n"+::MSU.Text.colorRed("X is Strength");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SunderingStrikes].Name = ::Const.Strings.PerkName.SunderingStrikes;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SunderingStrikes].Tooltip = ::Const.Strings.PerkDescription.SunderingStrikes;

this.perk_sundering_strikes <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.sundering_strikes";
		this.m.Name = ::Const.Strings.PerkName.SunderingStrikes;
		this.m.Description = ::Const.Strings.PerkDescription.SunderingStrikes;
		this.m.Icon = "ui/perks/sunderingstrikes_circle.png";
		this.m.IconDisabled = "ui/perks/sunderingstrikes_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		local strength = actor.m.CurrentProperties.getRangedSkill();
		_properties.DamageArmorMult *= 1.0 + strength / 100.0;
		_properties.ThresholdToInflictInjuryMult *= ::Math.minf(1.0, ::Math.maxf(0.01, 1.0 - strength / 100.0));
	}

});

