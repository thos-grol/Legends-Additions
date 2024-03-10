::mods_hookExactClass("skills/backgrounds/cultist_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.CleaverTree
			],
			Defense = [],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.NinetailsClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = ::Math.rand(0, 8);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/legend_chain"));
		}
		else if (r == 4)
		{
			if (::Const.DLC.Wildmen)
			{
				items.equip(::new("scripts/items/weapons/battle_whip"));
			}
			else if (!::Const.DLC.Wildmen)
			{
				items.equip(::new("scripts/items/weapons/legend_cat_o_nine_tails"));
			}
		}
		else if (r >= 5)
		{
			items.equip(::new("scripts/items/weapons/legend_cat_o_nine_tails"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"monk_robe"
			],
			[
				1,
				"cultist_leather_robe"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"cultist_hood"
			],
			[
				1,
				"hood"
			],
			[
				1,
				"cultist_leather_hood"
			]
		]));
	}

	o.onChangeAttributes <- function()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

});

