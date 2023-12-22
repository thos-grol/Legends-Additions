::mods_hookExactClass("skills/backgrounds/legend_master_archer_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 4;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.BowTree,
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.CalmTree,
				::Const.Perks.LargeTree,
				::Const.Perks.TrainedTree,
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = [
				::Const.Perks.RangerHuntMagicTree
			]
		};
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.RangedSkill] = 3;
		talents[::Const.Attributes.Hitpoints] = 3;
		talents[::Const.Attributes.MeleeDefense] = 3;

		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(::new("scripts/items/weapons/war_bow"));
		items.equip(::new("scripts/items/ammo/huge_quiver_of_arrows"));
		r = ::Math.rand(0, 1);

		if (r == 0)
		{
			items.addToBag(::new("scripts/items/weapons/knife"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"thick_tunic"
			],
			[
				1,
				"leather_tunic"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			]
		]));
	}

});

