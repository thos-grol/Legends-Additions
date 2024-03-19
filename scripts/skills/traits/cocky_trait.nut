this.cocky_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.cocky";
		this.m.Name = "Cocky";
		this.m.Icon = "ui/traits/trait_icon_24.png";
		this.m.Description = "All too easy! This character can be a bit too cocky for his own good. ";
		this.m.Titles = [
			"the Brave",
			"the Braggart"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.hesitant",
			"trait.pessimist",
			"trait.dastard",
			"trait.insecure",
			"trait.craven",
			"trait.fainthearted",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.teamplayer"
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Will"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Defense"
			},
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 20;
		_properties.MeleeDefense += -10;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Tenacious", true);
	}

});

