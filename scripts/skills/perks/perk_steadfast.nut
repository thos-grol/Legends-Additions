::Const.Strings.PerkName.Steadfast = "Endurance";

::Const.Strings.PerkDescription.Steadfast = "A fit body can endure greater stress..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n• " + ::MSU.Text.colorGreen("-90%") + "Accumulated Fatigue from being attacked. Invalid for attacks that specifically target fatigue."
+ "\n• " + ::MSU.Text.colorGreen("-50%") + "Accumulated Fatigue will affect Initiative"
+ "\n• \'Wait\' will no longer give an Initiative penalty.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Steadfast].Name = ::Const.Strings.PerkName.Steadfast;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Steadfast].Tooltip = ::Const.Strings.PerkDescription.Steadfast;

this.perk_steadfast <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.steadfast";
		this.m.Name = this.Const.Strings.PerkName.Steadfast;
		this.m.Description = this.Const.Strings.PerkDescription.Steadfast;
		this.m.Icon = "ui/perks/steadfast_circle.png";
		this.m.IconDisabled = "ui/perks/steadfast_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
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

