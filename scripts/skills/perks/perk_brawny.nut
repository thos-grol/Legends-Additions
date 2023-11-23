::Const.Strings.PerkDescription.Brawny = "Greater fitness, heavier armor..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("– 30%") + " Fatigue and Initiative penalty from armor"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "While over 90% Fatigued:")
+ "\n"+::MSU.Text.colorGreen("+5") + " Fatigue recovery";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Brawny].Tooltip = ::Const.Strings.PerkDescription.Brawny;

this.perk_brawny <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.brawny";
		this.m.Name = ::Const.Strings.PerkName.Brawny;
		this.m.Description = ::Const.Strings.PerkDescription.Brawny;
		this.m.Icon = "ui/perks/perk_40.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getFatigue() / actor.getFatigueMax() > 0.9)
			_properties.FatigueRecoveryRate += 5;
	}
});

