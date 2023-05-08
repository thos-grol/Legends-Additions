::mods_hookExactClass("entity/tactical/enemies/zombie_knight_bodyguard", function(o) {
	o.onInit = function()
	{
		this.zombie_knight.onInit();
		local b = this.m.BaseProperties;
		b.IsSpecializedInShields = true;
	}

});

