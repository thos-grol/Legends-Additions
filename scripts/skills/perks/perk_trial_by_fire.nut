::Const.Strings.PerkName.TrialByFire = "Trial By Fire";
::Const.Strings.PerkDescription.TrialByFire = "Soldiers are forged by battle..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.colorGreen("+1") + " Level for all units below Level 5 upon victory"
+ "\n• \'Rally the Troops\' (5 AP, 25 Fat): Rally fleeing allies, and raise morale of all nearby allies to a steady level. Higher resolve increases the chance to succeed";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.TrialByFire].Name = ::Const.Strings.PerkName.TrialByFire;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.TrialByFire].Tooltip = ::Const.Strings.PerkDescription.TrialByFire;

this.perk_inspiring_presence <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.trial_by_fire";
		this.m.Name = this.Const.Strings.PerkName.TrialByFire;
		this.m.Description = this.Const.Strings.PerkDescription.TrialByFire;
		this.m.Icon = "ui/perks/perk_28.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.rally_the_troops"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/rally_the_troops"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.rally_the_troops");
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.33;
	}



});

