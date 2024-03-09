::mods_hookExactClass("entity/world/settlements/situations/raided_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.RecruitsMult *= 0.5;
		_modifiers.RarityMult *= 0.5;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("refugee_background");
		_draftList.push("cripple_background");
		_draftList.push("cripple_background");
		_draftList.push("beggar_background");

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_necro")
		{
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
			_draftList.push("legend_puppet_background");
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
		}
	}

});

