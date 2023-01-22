this.entertainer_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.entertrainer";
		this.m.Name = "Entertainer";
		this.m.Icon = "ui/traits/trait_icon_63.png";
		this.m.Description = "This character is skilled in entertaining and can help in various scenarios.";
		this.m.Order = this.Const.SkillOrder.Background + 10;
		this.m.Type = this.m.Type;
		this.m.Titles = [];
		this.m.Excluded = [];
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Charm."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Subterfuge. (Determines success of getting away with crimes.)"
			}
		];
	}

});

