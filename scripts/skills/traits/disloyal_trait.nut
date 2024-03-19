this.disloyal_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.disloyal";
		this.m.Name = "Disloyal";
		this.m.Icon = "ui/traits/trait_icon_35.png";
		this.m.Description = "I have to put myself first! This character is rather disloyal and will be fast to leave should you ever run out of crowns or provisions.";
		this.m.Titles = [
			"the Liar"
		];
		this.m.Excluded = [
			"trait.loyal",
			"trait.brave",
			"trait.fearless"
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
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is always content with being in reserve"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsContentWithBeingInReserve = true;
	}

});

