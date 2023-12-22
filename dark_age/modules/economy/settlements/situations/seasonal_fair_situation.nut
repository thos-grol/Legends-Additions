::mods_hookExactClass("entity/world/settlements/situations/seasonal_fair_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.PriceMult *= 1.25;
		_modifiers.RarityMult *= 1.25;
		_modifiers.FoodRarityMult *= 1.25;
		_modifiers.MedicalRarityMult *= 1.25;
		_modifiers.RecruitsMult *= 1.25;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		
		
		
		
		
		
		_draftList.push("juggler_background");
		_draftList.push("juggler_background");
		_draftList.push("juggler_background");
		
		
		
		_draftList.push("legend_master_archer_background");

		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			
			
			
			
			
			
			
			
		}

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			local r;

			if (this.World.Assets.getOrigin().getID() == "scenario.legends_seer")
			{
				_draftList.push("legend_entrancer_background");
			}
			else if (this.World.Assets.getOrigin().getID() == "scenario.legends_sisterhood")
			{
				_draftList.push("legend_entrancer_background");
			}
			else if (this.World.Assets.getOrigin().getID() == "scenario.legends_troupe")
			{
				_draftList.push("legend_illusionist_background");
			}
			else
			{
				r = ::Math.rand(0, 9);

				if (r == 1)
				{
					_draftList.push("legend_entrancer_background");
				}
			}
		}
	}

});

