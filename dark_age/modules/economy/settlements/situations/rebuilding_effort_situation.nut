::mods_hookExactClass("entity/world/attached_location/rebuilding_effort_situation", function(o) {
	o.getDescription = function()
	{
		if (this.m.Target != "")
		{
			return "In an effort to rebuild the nearby " + this.m.Target.tolower() + ", building materials are in high demand and low supply.";
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
		_modifiers.BuildingPriceMult *= 1.35;
		_modifiers.BuildingRarityMult *= 0.5;
	}

	o.onRemoved = function( _settlement )
	{
		if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getID() == "contract.raze_attached_location")
		{
			return;
		}

		local candidates = [];

		foreach( a in _settlement.getAttachedLocations() )
		{
			if (a.isActive())
			{
				continue;
			}

			candidates.push(a);
		}

		if (candidates.len() != 0)
		{
			local a = candidates[this.Math.rand(0, candidates.len() - 1)];
			a.setActive(true);
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


			if (this.LegendsMod.Configs().LegendMagicEnabled())
			{
				local r;

				if (this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
				{
					r = this.Math.rand(0, 50);

					if (r == 1)
					{
						_draftList.push("legend_transmuter_background");
					}
				}
				else
				{
					r = this.Math.rand(0, 90);

					if (r == 1)
					{
						_draftList.push("legend_transmuter_background");
					}
				}
			}
		}

		
		
		
	}

});

