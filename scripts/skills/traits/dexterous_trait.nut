this.dexterous_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.dexterous";
		this.m.Name = "Dexterous";
		this.m.Icon = "ui/traits/trait_icon_34.png";
		this.m.Description = "A dexterous character has an easier time hitting their opponent";
		this.m.Excluded = [
			"trait.clumsy"
		];
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Skill"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 10;
	}

});

