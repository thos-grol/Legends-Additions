::mods_hookExactClass("entity/world/attached_location/gem_mine_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/uncut_gems_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("sellsword_background");
		_list.push("caravan_hand_background");
		_list.push("thief_background");
	}

	o.onUpdateShopList = function( _id, _list )
	{
		switch(_id)
		{
		case "building.marketplace":
			_list.push({
				R = 20,
				P = 1.0,
				S = "weapons/pickaxe"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "weapons/military_pick"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "tents/tent_enchant"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/uncut_gems_item"
			});
			break;

		default:
			if (_id == "building.specialized_trader")
			{
			}
		}
	}

	o.getNewResources = function()
	{
		return 2;
	}

});

