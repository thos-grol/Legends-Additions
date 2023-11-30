this.blueprint_potion_winter_05 <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/anatomist/mage_winter_potion_item");
		this.m.Cost = 200;
		local ingredients = [
			{
				Script = "scripts/items/misc/anatomist/nachzehrer_potion_item",
				Num = 1
			},
			{
				Script = "scripts/items/misc/magic/soul_splinter",
				Num = 3
			},
		];
		this.init(ingredients);
	}

	function isCraftable()
	{
		return this.World.Retinue.hasFollower("follower.alchemist")
			&& this.World.Statistics.getFlags().has("potion_winter")
			&& this.blueprint.isCraftable();
	}

	function isQualified()
	{
		return this.blueprint.isQualified()
			&& this.World.Statistics.getFlags().has("potion_winter")
			&& this.World.Retinue.hasFollower("follower.alchemist");
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/anatomist/mage_winter_potion_item"));
	}

});

