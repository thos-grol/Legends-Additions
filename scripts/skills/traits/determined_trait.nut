this.determined_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.determined";
		this.m.Name = "Determined";
		this.m.Icon = "ui/traits/trait_icon_31.png";
		this.m.Description = "Don\'t worry, I got this. This character shows a formidable amount of self-confidence.";
		this.m.Excluded = [
			"trait.weasel",
			"trait.dastard",
			"trait.insecure",
			"trait.fainthearted",
			"trait.craven",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.double_tongued"
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Will"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Will start combat at confident morale if permitted by mood"
			}
		];
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();

		if (actor.getMoodState() >= ::Const.MoodState.Neutral && actor.getMoraleState() < ::Const.MoraleState.Confident)
		{
			actor.setMoraleState(::Const.MoraleState.Confident);
		}
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

