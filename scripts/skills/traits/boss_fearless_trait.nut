this.boss_fearless_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.boss_fearless";
		this.m.Name = "Boss Resolve";
		this.m.Icon = "ui/traits/trait_icon_30.png";
		this.m.Description = "This character is not afraid... until they get low.";
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
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]Unbreakable... as long as they are over 25% health."
			}
		];
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (actor.getHitpointsPct() > 0.25)
		{
			_properties.IsAffectedByDyingAllies = false;
			_properties.IsAffectedByLosingHitpoints = false;
			_properties.Bravery += 120;
		}
		else
		{
			_properties.IsAffectedByDyingAllies = true;
			_properties.IsAffectedByLosingHitpoints = true;
			_properties.Bravery += 40;
		}

	}

});

