this.natural_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.natural";
		this.m.Name = "Talented";
		this.m.Icon = "ui/traits/natural_trait.png";
		this.m.Description = "Has natural skills, talents and abilities.";
		this.m.Titles = [
			"the Talented",
			"the Smart",
			"the Natural",
			"the Gifted"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.insecure",
			"trait.craven",
			"trait.hesitant",
			"trait.dastard",
			"trait.fainthearted",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.slack",
			"trait.pessimist",
			"trait.dumb",
			"trait.fainthearted",
			"trait.frail"
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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character's hit dice has an upper bound of 95 (instead of 100)"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Enemy's hit dice against this character have a lower bound of 6 (instead of 1)"
			}
		];
	}

});

