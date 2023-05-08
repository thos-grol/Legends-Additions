::mods_hookExactClass("entity/world/attached_location/beekeeper_location", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/mead_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		if (!this.isActive()) return;

		_list.push("farmhand_background");
		_list.push("farmhand_background");

		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		if (_gender)
		{
			_list.push("female_farmhand_background");
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "supplies/mead_item"
			});
		}
	}

});
