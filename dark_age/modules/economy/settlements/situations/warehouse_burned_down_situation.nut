::mods_hookExactClass("entity/world/settlements/situations/warehouse_burned_down_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 1.05;
		_modifiers.RarityMult *= 0.5;
	}

});

