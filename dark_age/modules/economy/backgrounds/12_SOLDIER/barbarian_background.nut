::mods_hookExactClass("skills/backgrounds/barbarian_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.AxeTree,
				::Const.Perks.HammerTree,
				::Const.Perks.ShieldTree,
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.FastTree,
				::Const.Perks.TrainedTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(2, 3);

		if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/barbarians/crude_axe"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"barbarians/thick_furs_armor"
			],
			[
				1,
				"barbarians/reinforced_animal_hide_armor"
			],
			[
				1,
				"barbarians/hide_and_bone_armor"
			],
			[
				1,
				"barbarians/scrap_metal_armor"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/bear_headpiece"
			],
			[
				1,
				"barbarians/leather_headband"
			],
			[
				1,
				"barbarians/leather_helmet"
			]
		]));
	}

	o.onChangeAttributes = function()
	{
		local c = {
			Hitpoints = [
				10,
				5
			],
			Bravery = [
				15,
				20
			],
			Stamina = [
				10,
				5
			],
			MeleeSkill = [
				10,
				5
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
				5,
				10
			]
		};
		return c;
	}

});
