::mods_hookExactClass("entity/world/attached_location/hunters_cabin_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("supplies/cured_venison_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("butcher_background");
		_list.push("butcher_background");
		_list.push("hunter_background");
		_list.push("hunter_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("poacher_background");
		_list.push("legend_taxidermist_background");

		if (this.Math.rand(0, 9) == 1)
		{
			_list.push("legend_master_archer_background");
		}

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r;

			if (this.World.Assets.getOrigin().getID() == "scenario.legends_rangers")
			{
				r = this.Math.rand(0, 9);

				if (r == 1)
				{
					_list.push("legend_master_archer_background");
					_list.push("legend_ranger_background");
				}
			}
			else
			{
				r = this.Math.rand(0, 9);

				if (r == 1)
				{
					_list.push("legend_master_archer_background");
				}
			}
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "supplies/cured_venison_item"
			});
			_list.push({
				R = 0,
				P = 0.9,
				S = "supplies/legend_fresh_meat_item"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "weapons/short_bow"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "weapons/hunting_bow"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "weapons/war_bow"
			});
			_list.push({
				R = 90,
				P = 1.0,
				S = "weapons/greenskins/goblin_bow"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/hood"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/knife"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "tents/tent_hunter"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/hunters_hat"
			});

			if (this.Const.DLC.Unhold)
			{
				_list.extend([
					{
						R = 10,
						P = 1.0,
						S = "weapons/spetum"
					}
				]);
			}
		}
	}

});
