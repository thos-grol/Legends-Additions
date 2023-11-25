::mods_hookExactClass("entity/world/attached_location/ceremonial_season_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.IncensePriceMult *= 1.5;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("monk_background");
		_draftList.push("monk_background");
		_draftList.push("cultist_background");
		// _draftList.push("flagellant_background");

		if (_gender)
		{
			_draftList.push("legend_nun_background");
			_draftList.push("legend_nun_background");
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_crusader")
		{
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
		}
	}

});

