::mods_hookExactClass("entity/world/settlements/situations/well_supplied_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.PriceMult *= 0.9;
		_modifiers.RarityMult *= 1.5;
	}

});

