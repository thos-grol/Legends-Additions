::mods_hookExactClass("entity/world/settlements/situations/slave_revolt_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.RecruitsMult *= 0.75;
		_modifiers.RarityMult *= 0.5;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		for( local i = _draftList.len() - 1; i >= 0; i = i )
		{
			if (_draftList[i] == "slave_background" || _draftList[i] == "slave_southern_background")
			{
				_draftList.remove(i);
			}

			i = --i;
		}


	}

});

