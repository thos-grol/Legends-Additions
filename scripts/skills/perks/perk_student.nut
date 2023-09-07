::Const.Strings.PerkName.Student = "Student";

::Const.Strings.PerkDescription.Student = "There is an ocean of knowledge out there, and this character has the talent to grasp a tiny portion of it..."
+ "\n\n[color=" + ::Const.UI.Color.NegativeValue + "][u]Passive:[/u][/color]"
+ "\n• " + ::MSU.Text.colorGreen("+20%") + " EXP gain"
+ "\n• At " + ::MSU.Text.colorRed("Level 11") + ", " + ::MSU.Text.colorGreen("+1") + " perk point"
+ "\n• Grants an attribute level up with maximum rolls and without taking stars into account.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Student].Name = ::Const.Strings.PerkName.Student;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Student].Tooltip = ::Const.Strings.PerkDescription.Student;

this.perk_student <- this.inherit("scripts/skills/skill", {
	m = {
		IsApplied = false
	},
	function create()
	{
		this.m.ID = "perk.student";
		this.m.Name = this.Const.Strings.PerkName.Student;
		this.m.Description = this.Const.Strings.PerkDescription.Student;
		this.m.Icon = "ui/perks/perk_21.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().getLevel() < 99)
		{
			_properties.XPGainMult *= 1.2;
		}
	}

	function onAdded()
	{
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

