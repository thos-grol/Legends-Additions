::mods_hookExactClass("entity/world/settlements/situations/merc_company_disbands_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.RecruitsMult *= 1.5;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_noble")
		{
			_draftList.push("legend_noble_2h");
			_draftList.push("legend_noble_shield");
			_draftList.push("legend_noble_ranged");
			_draftList.push("adventurous_noble_background");
			_draftList.push("adventurous_noble_background");
			_draftList.push("female_adventurous_noble_background");
			_draftList.push("female_adventurous_noble_background");
		}
	}

});

