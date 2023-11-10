::mods_hookExactClass("skills/backgrounds/sellsword_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree,
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
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
		r = this.Math.rand(0, 4);

		local item;

		if (r == 0) item = ::new("scripts/items/weapons/flail");
		else if (r == 1) item = ::new("scripts/items/weapons/hand_axe");
		else if (r == 2) item = ::new("scripts/items/weapons/greataxe");
		else if (r == 3) item = ::new("scripts/items/weapons/billhook");
		else item = ::new("scripts/items/weapons/winged_mace");

		this.addPerkGroup(::Z.Perks.tree(item));
		items.equip(item);

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"patched_mail_shirt"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"worn_mail_shirt"
			],
			[
				1,
				"leather_lamellar"
			],
			[
				1,
				"mail_shirt"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"nasal_helmet"
			],
			[
				1,
				"padded_nasal_helmet"
			],
			[
				1,
				"mail_coif"
			],
			[
				1,
				"closed_mail_coif"
			],
			[
				1,
				"reinforced_mail_coif"
			],
			[
				1,
				"kettle_hat"
			],
			[
				1,
				"padded_kettle_hat"
			],
			[
				1,
				"hood"
			]
		]));
	}

});

