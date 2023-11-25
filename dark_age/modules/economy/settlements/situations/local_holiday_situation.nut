::mods_hookExactClass("entity/world/settlements/situations/local_holiday_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.SellPriceMult *= 1.05;
		_modifiers.BuyPriceMult *= 0.95;
		_modifiers.FoodRarityMult *= 1.5;
		_modifiers.FoodPriceMult *= 0.9;
	}

});

