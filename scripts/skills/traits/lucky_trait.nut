this.lucky_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.lucky";
		this.m.Name = "Lucky";
		this.m.Icon = "ui/traits/trait_icon_54.png";
		this.m.Description = "Fate is certainty while luck is uncertainty. This character is has strong luck, blessed by the powers of Destiny.";
		this.m.Titles = [
			"the Lucky",
			"the Blessed"
		];
		this.m.Excluded = [
			"trait.pessimist",
			"trait.clumsy",
			"trait.ailing",
			"trait.clubfooted"
		];
	}

	function getTooltip()
	{
		local tooltip = [
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
		getLuckTooltip(tooltip);
		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.RerollDefenseChance += 10;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("Lucky")) return;

		local tier = 1;
		local roll = this.Math.rand(1, 100);
		if (roll <= 1) tier = 9; //Heaven Defying Fortune
		if (roll <= 5) tier = 5; //Plane's Chosen
		if (roll <= 20) tier = 3; //Fortunate
		else tier = 1; //Lucky
		
		actor.getFlags().set("Lucky", tier);
	}

	function boostLuck()
	{
		if (tier == 1) tier = 3;
		else if (tier == 3) tier = 5;
		else if (tier == 5) tier = 9;
	}

	function getRerollChance()
	{
		return 10 * this.getContainer().getActor().getFlags().getAsInt("Lucky");
	}

	function getName()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("Lucky")) return "Minor Luck";
		switch(actor.getFlags().getAsInt("Lucky"))
		{
			case 1:
				return "Minor Luck"
			case 3:
				return "Major Luck"
			case 5:
				return "Chosen"
			case 9:
				return "Fortune Rivalling Heaven"
		}
	}

	function getLuckTooltip( _tooltip )
	{
		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = getLuckTooltipHelper()
		});
		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Has a " + ::MSU.Text.colorGreen( getRerollChance() ) + "% chance to have any attacker require two successful attack rolls in order to hit"
		});
		return _tooltip;
	}

	function getLuckTooltipHelper()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("Lucky")) return "Things seem to go well once in a while for this character.";
		switch(this.getContainer().getActor().getFlags().getAsInt("Lucky"))
		{
			case 1:
				return "Things seem to go well once in a while for this character."
			case 3:
				return "Things seem to go well a lot for this character."
			case 5:
				return "This character is the chosen one. Their luck represents the trend of the world."
			case 9:
				return "This character's luck defies the balance of heaven. Their enemies might choke to death on air before hitting them."
		}
	}

});

