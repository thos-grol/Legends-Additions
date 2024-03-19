this.greedy_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.greedy";
		this.m.Name = "Greedy";
		this.m.Icon = "ui/traits/trait_icon_06.png";
		this.m.Description = "I want more! This character is greedy and will demand a higher daily payment than others with a similar background, as well as being fast to leave you if you ever run out of crowns.";
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
			}
		];
	}

	function addTitle()
	{
		this.character_trait.addTitle();
	}

	function onUpdate( _properties )
	{
		_properties.DailyWageMult *= 1.15;
	}

});

