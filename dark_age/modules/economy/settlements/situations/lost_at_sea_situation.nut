::mods_hookExactClass("entity/world/settlements/situations/lost_at_sea_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodRarityMult *= 0.5;
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.RecruitsMult *= 0.5;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}
	}

});

