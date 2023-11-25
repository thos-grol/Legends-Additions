::mods_hookExactClass("entity/world/attached_location/legends_off_book_deal_situation", function(o) {
	o.setStacks = function( _stacks )
	{
		this.m.Stacks = _stacks;
	}

	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.0 + this.m.Stacks * this.m.BuyPriceMultPerStack;
		_modifiers.RarityMult *= 1.0 + this.m.Stacks * this.m.RarityMultPerStack;
	}

});

