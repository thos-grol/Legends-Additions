//cursed item with bound by life must roll serialization id
//curse - bound by life -> effect that kills unit on combat start if they are missing the item
	//addserialized stacking effect (bound by death) - if player is missing item id on combat start, kill them

//curse trait, cursed trait

//effect has cursed points. onadded if cursedtrait dne add it.
	//cursedtrait onupdate - checks amount of curse points. if curse points not enough, -10 max hp for each curse point over. if max hp not enough, kill character

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

	function onUpdate( _properties )
	{
		_properties.RerollDefenseChance += getRerollChance();
		_properties.Bravery += 10;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("Lucky")) return;

		local tier = 1; //Lucky
		local roll = ::Math.rand(1, 100);
		if (roll <= 1) tier = 4; //Heaven Defying Fortune
		else if (roll <= 5) tier = 3; //Chosen
		else if (roll <= 20) tier = 2; //Fortunate
		actor.getFlags().set("Lucky", tier);
	}

	function upgrade()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Lucky", ::Math.min(4, actor.getFlags().getAsInt("Lucky") + 1));
	}

	function getRerollChance()
	{
		local actor = this.getContainer().getActor();
		local luck_tier = getAdjustedLuckTier(actor.getFlags().getAsInt("Lucky"));

		switch(luck_tier)
		{
			case 0:
				return 0;
			case 1:
				return 10;
			case 2:
				return 30;
			case 3:
				return 50;
			case 4:
				return 90;
		}
	}

	function getAdjustedLuckTier(luck_tier)
	{
		local curse = getCursePoints();

		if (luck_tier == 4)
		{
			local luck = 8 - curse;
			if (luck <= 0) luck_tier--;
			curse = ::Math.max(0, curse - 8);
			if (curse == 0) return luck_tier;
		}

		if (luck_tier == 3)
		{
			local luck = 4 - curse;
			if (luck <= 0) luck_tier--;
			curse = ::Math.max(0, curse - 4);
			if (curse == 0) return luck_tier;
		}

		if (luck_tier == 2)
		{
			local luck = 2 - curse;
			if (luck <= 0) luck_tier--;
			curse = ::Math.max(0, curse - 2);
			if (curse == 0) return luck_tier;
		}

		if (luck_tier == 1)
		{
			local luck = 1 - curse;
			if (luck <= 0) luck_tier--;
			curse = ::Math.max(0, curse - 1);
			if (curse == 0) return luck_tier;
		}

		return luck_tier;
	}

	function getLuckyPoints()
	{
		local actor = this.getContainer().getActor();
		switch(actor.getFlags().getAsInt("Lucky"))
		{
			case 1:
				return 1;
			case 2:
				return 3;
			case 3:
				return 7;
			case 4:
				return 15;
		}
	}

	function getCursePoints()
	{
		local actor = this.getContainer().getActor();
		local curse = actor.getSkills().getSkillByID("effects.cursed");
		if (curse == null) return 0;
		return curse.getCursePoints();
	}

	function getName()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("Lucky")) return "Minor Luck";
		switch(actor.getFlags().getAsInt("Lucky"))
		{
			case 1:
				return "Minor Luck"
			case 2:
				return "Major Luck"
			case 3:
				return "Chosen"
			case 4:
				return "Fortune Rivalling Heaven"
		}
	}

	////// Tooltips

	function getTooltip()
	{
		local name = this.getName();
		local curse = getCursePoints();
		if (curse > 0) name += " (Suppressed)"

		local tooltip = [
			{
				id = 1,
				type = "title",
				text = name
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		getLuckTooltip(tooltip);

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = getCursePoints() + "/" + getLuckyPoints() + " Curses"
		});


		return tooltip;
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

		_tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Will"
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
			case 2:
				return "Things seem to go well a lot for this character."
			case 3:
				return "This character is the chosen one. Their luck represents the trend of the world."
			case 4:
				return "This character's luck defies the balance of heaven. Their enemies might choke to death on air before hitting them."
		}
	}

});

