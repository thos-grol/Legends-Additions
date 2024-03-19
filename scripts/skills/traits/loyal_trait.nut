this.loyal_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.loyal";
		this.m.Name = "Loyal";
		this.m.Icon = "ui/traits/trait_icon_39.png";
		this.m.Description = "I\'m with you! This character is loyal to the end and much less likely to leave you even if you run out of crowns and provisions.";
		this.m.Titles = [
			"the Loyal",
			"the Follower",
			"the Dog"
		];
		this.m.Excluded = [
			"trait.disloyal",
			"trait.craven",
			"trait.fainthearted",
			"trait.dastard"
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
			}
		];
	}

});

