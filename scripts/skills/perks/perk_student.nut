::Const.Strings.PerkName.Student = "Student";
::Const.Strings.PerkDescription.Student = "There is an ocean of knowledge out there, and this character has the talent to grasp a tiny portion of it..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("250%") + " EXP gain"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Upon reaching Level 10:")
+ "\n"+::MSU.Text.colorGreen("+1") + " perk point";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Student].Name = ::Const.Strings.PerkName.Student;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Student].Tooltip = ::Const.Strings.PerkDescription.Student;

this.perk_student <- this.inherit("scripts/skills/skill", {
	m = {
		IsApplied = false
	},
	function create()
	{
		this.m.ID = "perk.student";
		this.m.Name = ::Const.Strings.PerkName.Student;
		this.m.Description = ::Const.Strings.PerkDescription.Student;
		this.m.Icon = "ui/perks/perk_21.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getLevel() < 99)
		{
			_properties.XPGainMult *= 2.5;
		}
	}

	function onAdded()
	{
		if (this.getContainer().getActor() != ::Const.Faction.Player) return;
		if (!this.m.IsApplied)
		{
			this.m.IsApplied = true;
			local actor = this.getContainer().getActor();
			actor.m.LevelUps += 1;
			actor.fillAttributeLevelUpValues(1, true);
		}
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.IsApplied = true;
	}

});

