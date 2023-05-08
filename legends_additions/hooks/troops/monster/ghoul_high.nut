::mods_hookExactClass("entity/tactical/enemies/ghoul_high", function(o) {
	o.onInit = function()
	{
		this.ghoul.onInit();
		this.grow(true);
		this.grow(true);
	}

});

