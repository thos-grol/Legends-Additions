::mods_hookExactClass("skills/backgrounds/killer_on_the_run_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
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
		r = ::Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/dagger"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/knife"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			]
		]));

		::Z.Perks.add(this.getContainer().getActor(), ::Const.Perks.PerkDefs.QuickHands, 0);

	}

	o.onChangeAttributes <- function()
	{
		local c = {
			Hitpoints = [
				-20,
				-20,
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
				20,
				20
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				-10,
				-10,
			],
			RangedDefense = [
				20,
				20
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

});
