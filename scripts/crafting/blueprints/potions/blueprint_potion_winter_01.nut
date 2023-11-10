//FEATURE_0: add more recipes
this.blueprint_potion_winter_01 <- this.inherit("scripts/crafting/blueprint", {
	m = {},
	function create()
	{
		this.blueprint.create();
		this.m.Type = this.Const.Items.ItemType.Usable;
		this.m.PreviewCraftable = this.new("scripts/items/misc/anatomist/mage_winter_potion_item");
		this.m.Cost = 200;
		local ingredients = [
			{
				Script = "scripts/items/misc/anatomist/direwolf_potion_item",
				Num = 1
			},
			//FEATURE_0: add other drops to the recipe
		];
		this.init(ingredients);
	}

	function isCraftable()
	{
		//FEATURE_0: add check for tome reward
		return this.World.Retinue.hasFollower("follower.alchemist")
			&& this.blueprint.isCraftable();
	}

	function isQualified()
	{
		//FEATURE_0: add check for tome reward
		return this.blueprint.isQualified()
			&& this.World.Retinue.hasFollower("follower.alchemist");
	}

	function onCraft( _stash )
	{
		_stash.add(this.new("scripts/items/misc/anatomist/mage_winter_potion_item"));
	}

});

