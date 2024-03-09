::mods_hookExactClass("skills/backgrounds/refugee_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree,
			],
			Defense = [],
			Traits = [],
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
		r = ::Math.rand(0, 4);

		if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/wooden_stick"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"tattered_sackcloth"
			],
			[
				1,
				"sackcloth"
			],
			[
				1,
				"legend_rabble_tunic"
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

