::mods_hookExactClass("entity/world/settlements/situations/ambushed_trade_routes_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.2;
		_modifiers.SellPriceMult *= 1.2;
		_modifiers.RarityMult *= 0.75;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("thief_background");
		_draftList.push("thief_background");
	}

});

