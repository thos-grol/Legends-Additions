this.mana_pool_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.mana_pool";
		this.m.Name = "Mana Pool";
		this.m.Icon = "ui/traits/effect_mc_02.png";
		this.m.Description = "Represents this character's mana pool. On new day, this character can consume an aspected material (matching their potion) in their bag slots to increase the capactiy of the mana pool\n\n Mana is refilled on a new day";
		this.m.Order = ::Const.SkillOrder.Trait - 10;
		this.m.Type = this.m.Type;
		this.m.Titles = [];
		this.m.Excluded = [];
	}

	function getTooltip()
	{
		local actor = this.getContainer().getActor();

		local ret = [
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
				id = 7,
				type = "progressbar",
				icon = "ui/icons/special.png",
				value = actor.getFlags().getAsInt("mana"),
				valueMax = actor.getFlags().getAsInt("mana_max"),
				text = "" + actor.getFlags().getAsInt("mana") + " / " + actor.getFlags().getAsInt("mana_max") + "",
				style = "fatigue-slim"
			}
		];

		return ret;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("mana")) actor.getFlags().set("mana", 2);
		if (!actor.getFlags().has("mana_max")) actor.getFlags().set("mana_max", 2);
	}

	function is_payable( _amount )
	{
		local actor = this.getContainer().getActor();
		return (actor.getFlags().getAsInt("mana") - _amount) >= 0;
	}

	function modify( _amount )
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("mana", ::Math.min(actor.getFlags().getAsInt("mana") + _amount, actor.getFlags().getAsInt("mana_max")));
	}

	function onNewDay()
	{
		local actor = this.getContainer().getActor();

		//check bag slots for valid aspected items to consume, upgrade
		local items = actor.getItems().getAllItems();
		foreach(i in items)
		{
			if (i == null) continue;
			if (!("Consumable" in i.m)) continue;
			if (!i.m.Consumable) continue;
			if (!("Aspect" in i.m)) continue;

			if (!actor.getFlags().has(i.m.Aspect)) continue;

			upgrade(i.m.Aspect_Amount);
			actor.getItems().removeFromBag(i)
			break;
		}

		//refill mana
		actor.getFlags().set("mana", actor.getFlags().getAsInt("mana_max"));
	}

	function upgrade( _amount )
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("mana_max", actor.getFlags().getAsInt("mana") + _amount);
		actor.getFlags().set("mana", actor.getFlags().getAsInt("mana") + _amount);
	}
});

