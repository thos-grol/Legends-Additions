::mods_hookExactClass("entity/world/settlements/situations/witch_burnings_situation", function(o) {
	o.onRemoved = function( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodRarityMult *= 1.35;
		_modifiers.FoodPriceMult *= 1.15;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");

		if (_gender)
		{
			_draftList.push("legend_nun_background");
		}

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			_draftList.push("legend_witch_background");
			_draftList.push("legend_spiritualist_background");
			_draftList.push("legend_diviner_background");
			_draftList.push("legend_entrancer_background");
		}
	}

});

