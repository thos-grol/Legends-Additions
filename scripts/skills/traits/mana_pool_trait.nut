this.mana_pool_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.mana_pool";
		this.m.Name = "Mana Pool";
		this.m.Icon = "ui/traits/effect_mc_02.png";
		this.m.Description = "Represents this character's mana pool.";
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
			//FEATURE_3: info that mana is refilled on new day
			{
				id = 7,
				type = "progressbar",
				icon = "ui/icons/sturdiness.png",
				value = actor.getFlags().getAsInt("mana"),
				valueMax = actor.getFlags().getAsInt("mana_max"),
				text = "" + actor.getFlags().getAsInt("mana") + " / " + actor.getFlags().getAsInt("mana_max") + "",
				style = "armor-body-slim"
			}
		];

		return ret;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("mana")) actor.getFlags().set("mana", 1);
		if (!actor.getFlags().has("mana_max")) actor.getFlags().set("mana_max", 1);
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
		//refill mana
		actor.getFlags().set("mana", actor.getFlags().getAsInt("mana_max"));

		//FEATURE_3: TRAIT check bag slots for valid aspected items to consume, upgrade
	}

	function upgrade( _amount )
	{
		actor.getFlags().set("mana_max", actor.getFlags().getAsInt("mana") + _amount);
		actor.getFlags().set("mana", actor.getFlags().getAsInt("mana") + _amount);
	}
});

