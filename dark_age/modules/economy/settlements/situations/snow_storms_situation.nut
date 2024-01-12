::mods_hookExactClass("entity/world/settlements/situations/snow_storms_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.2;
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.75;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r;

			if (this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
			{
				r = ::Math.rand(0, 50);

				if (r == 1)
				{
					this._list.push("legend_diviner_background");
				}
			}
			else if (this.World.Assets.getOrigin().getID() == "scenario.legends_sisterhood")
			{
				r = ::Math.rand(0, 9);

				if (r == 1)
				{
					this._list.push("legend_diviner_background");
				}
			}
			else
			{
				r = ::Math.rand(0, 90);

				if (r == 1)
				{
					this._list.push("legend_diviner_background");
				}
			}
		}
	}

});

