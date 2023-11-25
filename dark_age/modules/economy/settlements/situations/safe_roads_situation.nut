::mods_hookExactClass("entity/world/settlements/situations/safe_roads_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.PriceMult *= 1.1;
		_modifiers.RarityMult *= 1.1;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("caravan_hand_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("vagabond_background");




		_draftList.push("messenger_background");
		_draftList.push("gambler_background");


		_draftList.push("historian_background");
		_draftList.push("adventurous_noble_background");


		if (_gender)
		{
			_draftList.push("female_adventurous_noble_background");
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_crusader")
		{
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
			_draftList.push("legend_pilgrim_background");
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_man_at_arms_background");




		}
	}

});

