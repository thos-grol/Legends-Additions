::mods_hookExactClass("entity/world/attached_location/legend_degrading_effort_situation", function(o) {
	o.getDescription = function()
	{
		return this.m.Description;
	}

	o.isValid = function()
	{
		return this.situation.isValid();
	}

	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuildingPriceMult *= 0.5;
		_modifiers.BuildingRarityMult *= 0.55;
	}

	o.onRemoved = function( _settlement )
	{
		_settlement.changeSize(_settlement.getSize() - 1);
	}

	o.onSerialize = function( _out )
	{
		this.situation.onSerialize(_out);
	}

	o.onDeserialize = function( _in )
	{
		this.situation.onDeserialize(_in);
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
	}

});

