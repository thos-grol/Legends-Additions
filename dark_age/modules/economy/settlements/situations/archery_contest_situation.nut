::mods_hookExactClass("entity/world/settlements/situations/archery_contest_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.RecruitsMult *= 1.25;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");

		if (_gender)
		{
			_draftList.push("female_adventurous_noble_background");
			_draftList.push("female_adventurous_noble_background");
			_draftList.push("female_disowned_noble_background");
		}

		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
		_draftList.push("legend_master_archer_background");
	}

});

