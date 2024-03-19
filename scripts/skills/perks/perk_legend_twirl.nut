::Const.Strings.PerkName.LegendTwirl <- "Twirl";
::Const.Strings.PerkDescription.LegendTwirl <- "Twirl with grace through battle"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On enemy attack miss:")
+ "\n"+"If this character and enemy are eligible for rotation, swap positions and stagger the enemy. Gain 100 Defence until turn start"
+ "\n"+::MSU.Text.colorRed("Cooldown: 2 turns. Killing an enemy will reset the cooldown")

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Stagger: (Removed on turn start)")
+ "\n"+::MSU.Text.colorRed("– 50% Agility")
+ "\n"+::MSU.Text.colorRed("– 25 Defense")
+ "\n"+::MSU.Text.colorRed("+Cancels Shieldwall, Spearwall, Return Favor, and Riposte");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Name = ::Const.Strings.PerkName.LegendTwirl;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Tooltip = ::Const.Strings.PerkDescription.LegendTwirl;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Icon = "ui/perks/twirl.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].IconDisabled = "ui/perks/twirl_bw.png";

//////////////////

::Const.Strings.PerkName.Rotation = "Rotation";
::Const.Strings.PerkDescription.Rotation = "Rotate!"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Rotation\' (3 AP, 25 Fat):")
+ "\nSwitch places with an allied unit"
+ "\n"+::MSU.Text.colorRed("Invalid if either character is stunned, rooted or otherwise disabled");

//////////////////

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Rotation].Name = ::Const.Strings.PerkName.Rotation;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Rotation].Tooltip = ::Const.Strings.PerkDescription.Rotation;

this.perk_legend_twirl <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 0,
		CooldownMax = 2,
		Active = false
	},
	function create()
	{
		this.m.ID = "perk.legend_twirl";
		this.m.Name = ::Const.Strings.PerkName.LegendTwirl;
		this.m.Description = ::Const.Strings.PerkDescription.LegendTwirl;
		this.m.Icon = "ui/perks/twirl_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function activate()
	{
		this.m.Cooldown = this.m.CooldownMax;
		this.m.Active = true;
	}

	function can_be_used()
	{
		return this.m.Cooldown == 0;
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		this.m.Cooldown = 0;
	}

	function onTurnStart()
	{
		this.m.Active = false;
		if (this.m.Cooldown > 0) this.m.Cooldown--;
	}

	function onUpdate( _properties )
	{
		if (this.m.Active)
		{
			_properties.MeleeDefense += 100;
		}
	}

});

