::mods_hookExactClass("entity/world/settlements/situations/mirage_sightings_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r;

			if (this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
			{
				r = ::Math.rand(0, 5);

				if (r == 1)
				{
					_draftList.push("legend_illusionist_background");
				}
			}
			else
			{
				r = ::Math.rand(0, 9);

				if (r == 1)
				{
					_draftList.push("legend_illusionist_background");
				}
			}
		}
	}

});

