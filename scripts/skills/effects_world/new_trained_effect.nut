this.new_trained_effect <- this.inherit("scripts/skills/skill", {
	m = {
		XPGainMult = 1.0,
		Duration = 0,
		Battles = 0,
		IsCountingBattle = false,
		Proficiency = 0
	},
	function create()
	{
		this.m.ID = "effects.trained";
		this.m.Name = "Saturated Knowledge";
		this.m.Description = "Having had the honor of training with and learning from experienced fighters recently, this character has soaked in knowledge and now needs to apply what he learned on the battlefield in order to fully grasp it and make it his own.";
		this.m.Icon = "skills/status_effect_62.png";
		this.m.Type = this.m.Type | ::Const.SkillType.StatusEffect;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
		];
		ret.push({
			id = 7,
			type = "hint",
			icon = "ui/icons/warning.png",
			text = "Cannot train until tommorow"
		});
		return ret;
	}

	function onNewDay()
	{
		this.removeSelf();
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		local skill;
		local proficiencies = [
			"trait.proficiency_Axe",
			"trait.proficiency_Cleaver",
			"trait.proficiency_Sword",
			"trait.proficiency_Mace",
			"trait.proficiency_Hammer",
			"trait.proficiency_Flail",
			"trait.proficiency_Spear",
			"trait.proficiency_Polearm",
			"trait.proficiency_Fist",
			"trait.proficiency_Ranged",
		];
		foreach (proficiency in proficiencies)
		{
			skill = actor.getSkills().getSkillByID(proficiency);
			if (skill != null) skill.add_proficiency_amount(this.m.Proficiency);
		}
	}

	function add_proficiency(_amount)
	{
		this.m.Proficiency += _amount;
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeU16(this.m.Duration);
		_out.writeU16(this.m.Battles);
		_out.writeF32(this.m.XPGainMult);
		_out.writeString(this.m.Icon);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.Duration = _in.readU16();
		this.m.Battles = _in.readU16();
		this.m.XPGainMult = _in.readF32();
		this.m.Icon = _in.readString();
	}

});

