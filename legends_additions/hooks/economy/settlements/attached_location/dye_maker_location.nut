::mods_hookExactClass("entity/world/attached_location/dye_maker_location.nut", function(o) {
	o.onUpdateProduce = function( _list )
	{
		_list.push("trade/dies_item");
	}

	o.onUpdateDraftList = function( _list, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (!this.isActive())
		{
			return;
		}

		_list.push("apprentice_background");
		_list.push("caravan_hand_background");
		_list.push("tailor_background");

		if (_gender)
		{
			_list.push("female_tailor_background");
		}
	}

	o.onUpdateShopList = function( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "trade/dies_item"
			});
			_list.push({
				R = 0,
				P = 1.0,
				S = "weapons/legend_wooden_pitchfork"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/jesters_hat"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/jesters_hat"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "helmets/legend_noble_floppy_hat"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "helmets/legend_noble_hat"
			});
			_list.push({
				R = 80,
				P = 1.0,
				S = "helmets/legend_noble_hood"
			});

			if (this.Const.DLC.Unhold && !::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
			{
				_list.push({
					R = 30,
					P = 1.0,
					S = "misc/paint_set_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_black_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_red_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_orange_red_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_white_blue_item"
				});
				_list.push({
					R = 50,
					P = 1.0,
					S = "misc/paint_white_green_yellow_item"
				});
			}
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 0,
				P = 1.0,
				S = "helmets/named/jugglers_hat"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/named/jugglers_padded_hat"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "helmets/named/death_jesters_helm"
			});
		}
	}

});
