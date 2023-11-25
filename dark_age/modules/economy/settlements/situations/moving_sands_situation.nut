::mods_hookExactClass("entity/world/settlements/situations/moving_sands_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.85;
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

