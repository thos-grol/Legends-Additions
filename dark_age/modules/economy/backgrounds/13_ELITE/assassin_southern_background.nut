::mods_hookExactClass("skills/backgrounds/assassin_southern_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.BowTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,

			],
			Magic = [
				::Const.Perks.AssassinMagicTree
			]
		};


	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/oriental/qatal_dagger"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/dagger"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(::new("scripts/items/tools/smoke_bomb_item"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/tools/daze_bomb_item"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"oriental/thick_nomad_robe"
			],
			[
				1,
				"oriental/assassin_robe"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"oriental/assassin_head_wrap"
			]
		]));
	}

});

