::mods_hookExactClass("entity/world/settlements/situations/legend_building_effort_situation", function(o) {
	o.getDescription = function()
	{
		if (this.m.Target != "")
		{
			return "In an effort to build the new " + this.m.Target.tolower() + ", building materials are in high demand and low supply.";
		}
		else
		{
			return this.m.Description;
		}
	}

	o.isValid = function()
	{
		if (this.m.Target == "")
		{
			return false;
		}

		return this.situation.isValid();
	}

	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuildingPriceMult *= 1.5;
		_modifiers.BuildingRarityMult *= 0.5;
	}

	o.onRemoved = function( _settlement )
	{
		foreach( a in _settlement.getAttachedLocations() )
		{
			if (!a.isBuilding())
			{
				continue;
			}

			_settlement.setResources(_settlement.getResources() - 50);
			a.setNew(false);
			a.setActive(true);
			break;
		}
	}

	o.onSerialize = function( _out )
	{
		this.situation.onSerialize(_out);
		_out.writeString(this.m.Target);
	}

	o.onDeserialize = function( _in )
	{
		this.situation.onDeserialize(_in);
		this.m.Target = _in.readString();
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

