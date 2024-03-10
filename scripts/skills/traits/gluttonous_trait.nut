this.gluttonous_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.gluttonous";
		this.m.Name = "Gluttonous";
		this.m.Icon = "ui/traits/trait_icon_07.png";
		this.m.Description = "Tasty, let\'s have another one! Better bring extra provisions when traveling with this character and expect them to leave fast if you ever run out of provisions entirely. +4 daily cost";
		this.m.Titles = [
			"the Swine"
		];
		this.m.Excluded = [
			"trait.athletic",
			"trait.iron_lungs",
			"trait.spartan",
			"trait.fragile",
			"trait.light"
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

	function addTitle()
	{
		this.character_trait.addTitle();
	}

});

