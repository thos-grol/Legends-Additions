this.night_owl_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.night_owl";
		this.m.Name = "Night Owl";
		this.m.Icon = "ui/traits/trait_icon_57.png";
		this.m.Description = "Some characters adapt to low light conditions better than others, and this individual is especially good at it. Halves the usual night penalties";
		this.m.Titles = [
			"Night Owl",
			"Eagle Eyes"
		];
		this.m.Excluded = [
			"trait.short_sighted",
			"trait.night_blind"
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
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+1[/color] Vision during Night time"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15%[/color] Ranged Hit Chance during Night time"
			},
		];
	}

	function onUpdate( _properties )
	{
	}

});

