this.new_trained_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Proficiency = 0,
		Applied = false,
		Mode = "None",
		Stat = ""
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
		if (this.m.Applied) return;
		this.m.Applied = true;

		if (this.m.Mode == "Proficiency")
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
		else if (this.m.Mode == "Stat")
		{
			local actor = this.getContainer().getActor();

			if (this.m.Stat == "trainable_hitpoints")
				actor.getBaseProperties().Hitpoints += ::Math.min(10, actor.getFlags().getAsInt(this.m.Stat));
			else if (this.m.Stat == "trainable_resolve") 
				actor.getBaseProperties().Bravery += ::Math.min(10, actor.getFlags().getAsInt(this.m.Stat));
			else if (this.m.Stat == "trainable_fatigue") 
				actor.getBaseProperties().Stamina += ::Math.min(10, actor.getFlags().getAsInt(this.m.Stat));
			else if (this.m.Stat == "trainable_initiative") 
				actor.getBaseProperties().Initiative += ::Math.min(10, actor.getFlags().getAsInt(this.m.Stat));
			else if (this.m.Stat == "trainable_meleeskill") 
				actor.getBaseProperties().MeleeSkill += ::Math.min(10, actor.getFlags().getAsInt(this.m.Stat));
			else if (this.m.Stat == "trainable_meleedefense") 
				actor.getBaseProperties().MeleeDefense += ::Math.min(10, actor.getFlags().getAsInt(this.m.Stat));
			else if (this.m.Stat == "trainable_rangedskill") 
				actor.getBaseProperties().RangedSkill += ::Math.min(10, actor.getFlags().getAsInt(this.m.Stat));
			else if (this.m.Stat == "trainable_rangeddefense") 
				actor.getBaseProperties().RangedDefense += ::Math.min(10, actor.getFlags().getAsInt(this.m.Stat));

			actor.getFlags().set(this.m.Stat, ::Math.max(0, actor.getFlags().getAsInt(this.m.Stat) - 10))
			actor.getSkills().update();
		}
	}

	function add_proficiency(_amount)
	{
		this.m.Proficiency += _amount;
	}

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeString(this.m.Icon);
		_out.writeBool(this.m.Applied);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.Icon = _in.readString();
		this.m.Applied = _in.readBool();


	}

});

