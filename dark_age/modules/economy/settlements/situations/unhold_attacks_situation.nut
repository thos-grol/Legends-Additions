::mods_hookExactClass("entity/world/settlements/situations/unhold_attacks_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.1;
		_modifiers.SellPriceMult *= 0.9;
		_modifiers.RarityMult *= 0.9;
		_modifiers.RecruitsMult *= 0.75;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

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
			_draftList.push("legend_man_at_arms_background");
			_draftList.push("legend_man_at_arms_background");
		}

		
		
		
		
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
	}

});

