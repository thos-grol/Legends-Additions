::mods_hookExactClass("entity/world/settlements/buildings/arena_building", function(o) {
	o.refreshCooldown = function()
	{
		this.m.CooldownUntil = this.World.getTime().Days + 1;
	}

	o.isClosed = function()
	{
		return this.World.getTime().Days < this.m.CooldownUntil;
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_list.push("gladiator_background");
		_list.push("gladiator_background");
		_list.push("gladiator_background");
		_list.push("gladiator_background");
	}

});
