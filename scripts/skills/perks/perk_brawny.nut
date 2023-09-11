//TODO: rewrite using new format
::Const.Strings.PerkDescription.Brawny = "Trade hit for hit with heavy armor..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.LightBlue, "[u]Passive:[/u]")
+ "\n• " + ::MSU.Text.colorGreen("-30%") + " Fatigue and Initiative penalty from wearing armor."
+ "\n• " + ::MSU.Text.colorGreen("+5") + " Fatigue recovery while over 90% fatigued.";

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

