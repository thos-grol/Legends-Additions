::mods_hookExactClass("entity/world/settlements/situations/legend_militant_townsfolk_situation", function(o) {
	o.onUpdate = function( _modifiers )
	{
		_modifiers.FoodRarityMult *= 0.75;
		_modifiers.MineralRarityMult *= 0.25;
		_modifiers.BuildingRarityMult *= 0.25;
		_modifiers.RecruitsMult *= 4;
	}

	o.onUpdateShop = function( _stash )
	{
		if (_stash.getID() == "shop")
		{
			local wc = ::MSU.Class.WeightedContainer([
				[
					1,
					"scripts/items/weapons/legend_hoe"
				],
				[
					1,
					"scripts/items/weapons/legend_scythe"
				],
				[
					2,
					"scripts/items/weapons/pitchfork"
				],
				[
					2,
					"scripts/items/weapons/warfork"
				],
				[
					1,
					"scripts/items/weapons/wooden_flail"
				],
				[
					1,
					"scripts/items/weapons/butchers_cleaver"
				],
				[
					2,
					"scripts/items/weapons/legend_militia_glaive"
				],
				[
					1,
					"scripts/items/weapons/militia_spear"
				],
				[
					1,
					"scripts/items/weapons/legend_saw"
				],
				[
					1,
					"scripts/items/weapons/legend_shovel"
				],
				[
					1,
					"scripts/items/weapons/legend_slingshot"
				],
				[
					1,
					"scripts/items/weapons/legend_tipstaff"
				],
				[
					2,
					"scripts/items/weapons/hooked_blade"
				],
				[
					1,
					"scripts/items/weapons/legend_sickle"
				],
				[
					1,
					"scripts/items/weapons/legend_hoe"
				],
				[
					1,
					"scripts/items/weapons/two_handed_wooden_flail"
				],
				[
					1,
					"scripts/items/weapons/woodcutters_axe"
				],
				[
					1,
					"scripts/items/weapons/hatchet"
				]
			]);
			local amt = ::Math.rand(10, 15);

			for( local i = 0; i < amt; i++ )
			{
				local item = this.new(wc.roll());

				if (item.getConditionMax() > 1)
				{
					if (::Math.rand(1, 100) <= 50)
					{
						local condition = ::Math.rand(item.getConditionMax() * 0.4, item.getConditionMax() * 0.9);
						item.setCondition(condition);
					}
				}

				_stash.add(item);
			}
		}
	}

	o.onUpdateDraftList = function( _draftList, _gender = null )
	{
		_gender = ::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled";
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("miller_background");
		_draftList.push("miller_background");
		_draftList.push("miller_background");
		_draftList.push("butcher_background");
		_draftList.push("butcher_background");
		_draftList.push("butcher_background");
		_draftList.push("shepherd_background");
		_draftList.push("shepherd_background");
		_draftList.push("shepherd_background");
		_draftList.push("apprentice_background");
		_draftList.push("apprentice_background");
	}

});

