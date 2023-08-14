::mods_hookExactClass("entity/tactical/enemies/legend_skin_ghoul_med", function(o) {
	o.onInit = function()
	{
		this.legend_skin_ghoul.onInit();
		this.legend_skin_ghoul.grow(true);
	}

});

