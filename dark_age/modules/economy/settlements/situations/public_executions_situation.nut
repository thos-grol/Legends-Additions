::mods_hookExactClass("entity/world/settlements/situations/public_executions_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodRarityMult *= 1.35;
		_modifiers.FoodPriceMult *= 1.15;
	}

});

