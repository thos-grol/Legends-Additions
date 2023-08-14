::mods_hookExactClass("entity/tactical/enemies/ghoul_medium", function(o) {
	o.onInit = function()
	{
		this.ghoul.onInit();
		this.grow(true);
	}

});

