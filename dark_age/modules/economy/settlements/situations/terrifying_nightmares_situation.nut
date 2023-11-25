::mods_hookExactClass("entity/world/attached_location/terrifying_nightmares_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.RecruitsMult *= 0.8;
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";

		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			_draftList.push("legend_nightwatch_background");
			_draftList.push("legend_nightwatch_background");
			_draftList.push("legend_nightwatch_background");
			_draftList.push("legend_man_at_arms_background");
		}

		if (this.LegendsMod.Configs().LegendMagicEnabled())
		{
			if (this.World.Assets.getOrigin().getID() == "scenario.legends_warlock")
			{
				this.r = this.Math.rand(0, 9);

				if (this.r == 1)
				{
					this._list.push("legend_vampire_background");
				}
			}
		}

		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");
		//_draftList.push("witchhunter_background");


	}

});

