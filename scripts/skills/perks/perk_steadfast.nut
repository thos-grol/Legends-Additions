::Const.Strings.PerkName.Steadfast = "Endurance";
::Const.Strings.PerkDescription.Steadfast = "Endure and in enduring, become strong..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("– 90%") + " Fatigue from being attacked"
+ "\n" + ::MSU.Text.colorGreen("– 50%") + " effect of Fatigue on Agility"

+ "\n" + ::MSU.Text.colorRed("Invalid for attacks that specifically target fatigue")
+ "\n\n" + ::MSU.Text.colorGreen("\'Wait\' will no longer give an Agility penalty");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Steadfast].Name = ::Const.Strings.PerkName.Steadfast;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Steadfast].Tooltip = ::Const.Strings.PerkDescription.Steadfast;

this.perk_steadfast <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.steadfast";
		this.m.Name = ::Const.Strings.PerkName.Steadfast;
		this.m.Description = ::Const.Strings.PerkDescription.Steadfast;
		this.m.Icon = "ui/perks/steadfast_circle.png";
		this.m.IconDisabled = "ui/perks/steadfast_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.FatigueReceivedPerHitMult *= 0.1;
		_properties.FatigueLossOnBeingMissedMult *= 0.1;
		_properties.FatigueToInitiativeRate *= 0.5;
		_properties.InitiativeAfterWaitMult = 1.0;
	}

});

