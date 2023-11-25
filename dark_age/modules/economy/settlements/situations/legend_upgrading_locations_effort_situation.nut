::mods_hookExactClass("entity/world/attached_location/legend_upgrading_locations_effort_situation", function(o) {
	o.getDescription = function()
	{
		return "In an effort to expand and upgrade the settlement, building materials are in high demand and low supply.";
	}

	o.isValid = function()
	{
		return this.situation.isValid();
	}

	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuildingPriceMult *= 2.0;
		_modifiers.BuildingRarityMult *= 0.75;
	}

	o.onRemoved = function( _settlement )
	{
		_settlement.setResources(_settlement.getResources() - 50);
		_settlement.m.AttachedLocationsMax + 1;
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

		if (this.m.IsSouthern)
		{
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("daytaler_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
			_draftList.push("slave_southern_background");
		}
		else
		{
			_draftList.push("lumberjack_background");
			_draftList.push("lumberjack_background");
			_draftList.push("mason_background");
			_draftList.push("mason_background");
			_draftList.push("daytaler_background");
			_draftList.push("daytaler_background");
			_draftList.push("daytaler_background");
		}
	}

});

