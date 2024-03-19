this.paranoid_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.paranoid";
		this.m.Name = "Paranoid";
		this.m.Icon = "ui/traits/trait_icon_55.png";
		this.m.Description = "I swear that bush over there was moving! This character is extra cautious and reluctant to move ahead.";
		this.m.Titles = [
			"the Crazy",
			"the Paranoid"
		];
		this.m.Excluded = [
			"trait.optimist",
			"trait.fearless",
			"trait.brave",
			"trait.determined",
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.ambitious",
			"trait.seductive",
			"trait.natural"
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
				icon = "ui/icons/ranged_defense.png",
				text = "Has [color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Defense"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-20[/color] Agility"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 10;
		_properties.Initiative += -20;
	}

});

