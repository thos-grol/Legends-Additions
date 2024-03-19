this.lead_by_example_effect <- this.inherit("scripts/skills/skill", {
	m = {
		MeleeSkill = 0,
		MeleeDefense = 0,
		RangedDefense = 0,
		Bravery = 0
	},
	function create()
	{
		this.m.ID = "effects.lead_by_example";
		this.m.Name = "Lead by Example";
		this.m.Description = "This character has been inspired by their commander.";
		this.m.Icon = "ui/perks/lead_by_example.png";
		this.m.IconMini = "perk_01_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		return [
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
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.MeleeSkill + "[/color] Attack"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.MeleeDefense + "[/color] Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.m.Bravery + "[/color] Will"
			}
		];
	}

	function onAfterUpdate( _properties )
	{
		_properties.MeleeSkill += this.m.MeleeSkill;
		_properties.MeleeDefense += this.m.MeleeDefense;
		_properties.Bravery += this.m.Bravery;
	}

});

