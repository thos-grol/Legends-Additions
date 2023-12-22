::mods_hookExactClass("skills/backgrounds/raider_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.AxeTree,
				::Const.Perks.HammerTree,
				::Const.Perks.ShieldTree,
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
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
		r = ::Math.rand(0, 5);

		if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/morning_star"));
		}

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
				"leather_lamellar"
			],
			[
				1,
				"worn_mail_shirt"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"dented_nasal_helmet"
			],
			[
				1,
				"nasal_helmet_with_rusty_mail"
			]
		]));
	}

});

