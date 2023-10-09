::mods_hookExactClass("entity/world/attached_location/dye_maker_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/dies_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive()) return;

		_list.push("apprentice_background");
		_list.push("caravan_hand_background");
		//_list.push("tailor_background");

		
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/dies_item"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "helmets/named/jugglers_hat"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/named/jugglers_padded_hat"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "helmets/named/death_jesters_helm"
			});
		}
	}

});
