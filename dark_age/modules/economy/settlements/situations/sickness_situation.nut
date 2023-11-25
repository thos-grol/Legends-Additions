::mods_hookExactClass("entity/world/attached_location/sickness_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.MedicalPriceMult *= 3.0;
		_modifiers.RecruitsMult *= 0.25;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("beggar_background");
		_draftList.push("beggar_background");
		_draftList.push("monk_background");

		if (_gender)
		{
			_draftList.push("legend_nun_background");
			_draftList.push("legend_herbalist_background");
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			
			
			
			
			
			
			
			
		}

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			_draftList.push("legend_diviner_background");
		}
	}

});

