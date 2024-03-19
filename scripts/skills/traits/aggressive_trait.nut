//TODO: rethink
this.aggressive_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.aggressive";
		this.m.Name = "Aggressive";
		this.m.Icon = "ui/traits/aggressive_trait.png";
		this.m.Description = "This character is pretty aggressive, even to their own detriment.";
		this.m.Titles = [
			"the Boar",
			"the Fire",
			"the Crazy"
		];
		this.m.Excluded = [
			"trait.clumsy",
			"trait.pessimist",
			"trait.weasel",
			"trait.insecure",
			"trait.craven",
			"trait.hesitant",
			"trait.dastard",
			"trait.fainthearted",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.fear_nobles",
			"trait.slack",
			"trait.pragmatic"
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
				icon = "ui/icons/strength.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+15[/color] Strength"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-3[/color] Defense from each surrounding enemy"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Will never start combat at wavering morale"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.RangedSkill += 15;
		_properties.SurroundedDefense -= 3;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();

		if (actor.getMoraleState() < ::Const.MoraleState.Steady)
		{
			actor.setMoraleState(::Const.MoraleState.Steady);
		}
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Vicious", true);
	}

});

