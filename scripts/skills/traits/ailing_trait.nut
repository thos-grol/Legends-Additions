this.ailing_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.ailing";
		this.m.Name = "Ailing";
		this.m.Icon = "ui/traits/trait_icon_59.png";
		this.m.Description = "This character is always pale and sickly, which makes him particularly susceptible to poisons.";
		this.m.Titles = [
			"the Pale",
			"the Sickly",
			"the Ailing"
		];
		this.m.Excluded = [
			"trait.tough",
			"trait.iron_jaw",
			"trait.survivor",
			"trait.strong",
			"trait.athletic",
			"trait.iron_lungs",
			"trait.lucky",
			"trait.clubfooted"
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
				icon = "ui/icons/special.png",
				text = "Poison effects last [color=" + this.Const.UI.Color.NegativeValue + "]1[/color] additional turn"
			}
		];
	}

});

