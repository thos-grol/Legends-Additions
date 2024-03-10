this.player_character_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.player";
		this.m.Name = "Avatar";
		this.m.Icon = "ui/traits/trait_icon_63.png";
		this.m.Description = "This is your avatar. Die and it's game over.";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
		this.m.Type = this.m.Type;
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.loyal",
			"trait.disloyal",
			"trait.greedy"
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]Immune to charm effects.[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]Will never desert the company.[/color]"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 10;
	}

});

