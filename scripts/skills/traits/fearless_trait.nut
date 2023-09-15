this.fearless_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.fearless";
		this.m.Name = "Fearless";
		this.m.Icon = "ui/traits/trait_icon_30.png";
		this.m.Description = "There are a lot of old friends to meet in the afterlife. This character is not afraid of death.";
		this.m.Titles = [
			"the Fearless"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.insecure",
			"trait.craven",
			"trait.hesitant",
			"trait.dastard",
			"trait.fainthearted",
			"trait.brave",
			"trait.superstitious",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.slack"
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery += 10;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Tenacious", true);
	}

});

