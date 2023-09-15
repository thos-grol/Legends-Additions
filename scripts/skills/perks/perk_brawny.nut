::Const.Strings.PerkDescription.Brawny = "Get accustomed to the weight of armor..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n"+::MSU.Text.colorGreen("-30%") + " Fatigue and Initiative penalty from armor"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]While over 90% Fatigued:[/u]")
+ "\n"+::MSU.Text.colorGreen("+5") + " Fatigue recovery";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Brawny].Tooltip = ::Const.Strings.PerkDescription.Brawny;

this.perk_brawny <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.brawny";
		this.m.Name = this.Const.Strings.PerkName.Brawny;
		this.m.Description = this.Const.Strings.PerkDescription.Brawny;
		this.m.Icon = "ui/perks/perk_40.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
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

