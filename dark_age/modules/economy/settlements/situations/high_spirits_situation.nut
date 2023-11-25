::mods_hookExactClass("entity/world/attached_location/high_spirits_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.SellPriceMult *= 1.05;
		_modifiers.BuyPriceMult *= 0.95;
		_modifiers.RarityMult *= 1.1;
	}

});

