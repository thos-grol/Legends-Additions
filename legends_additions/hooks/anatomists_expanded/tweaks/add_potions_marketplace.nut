::mods_hookExactClass("entity/world/attached_location/stone_watchtower_location", function (o)
{
	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function(_id, _list)
	{
		onUpdateShopList(_id, _list);
		if (_id != "building.marketplace") return;
		_list.push({
			R = 90,
			P = 1.0,
			S = "misc/anatomist/orc_young_potion_item"
		});
		_list.push({
			R = 90,
			P = 1.0,
			S = "misc/anatomist/direwolf_potion_item"
		});
		_list.push({
			R = 90,
			P = 1.0,
			S = "misc/anatomist/goblin_grunt_potion_item"
		});


	}
});

::mods_hookExactClass("entity/world/attached_location/stone_watchtower_oriental_location", function (o)
{
	local onUpdateDraftList = o.onUpdateDraftList;
	o.onUpdateDraftList = function( _list, _gender = null )
	{
		onUpdateDraftList(_list, _gender);
		_list.push("anatomist_background");
	}

	local onUpdateShopList = o.onUpdateShopList;
	o.onUpdateShopList = function(_id, _list)
	{
		onUpdateShopList(_id, _list);
		if (_id != "building.marketplace") return;
		_list.push({
			R = 90,
			P = 1.0,
			S = "misc/anatomist/serpent_potion_item"
		});
		_list.push({
			R = 90,
			P = 1.0,
			S = "misc/anatomist/nachzehrer_potion_item"
		});
		_list.push({
			R = 90,
			P = 1.0,
			S = "misc/anatomist/webknecht_potion_item"
		});
	}
});