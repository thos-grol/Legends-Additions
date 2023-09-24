::mods_hookExactClass("skills/backgrounds/hedge_knight_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.GreatSwordTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.AxeTree,
				::Const.Perks.MaceTree,
				::Const.Perks.FlailTree,
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree
			],
			Enemy = [
				::Const.Perks.SwordmastersTree
			],
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
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/greataxe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/greatsword"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"mail_hauberk"
			],
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"scale_armor"
			],
			[
				1,
				"reinforced_mail_hauberk"
			],
			[
				1,
				"worn_mail_shirt"
			]
		]));
		local helm = [
			[
				1,
				"nasal_helmet"
			],
			[
				1,
				"nasal_helmet_with_mail"
			],
			[
				1,
				"mail_coif"
			],
			[
				1,
				"bascinet_with_mail"
			],
			[
				1,
				"closed_flat_top_helmet"
			]
		];

		helm.push([
			1,
			"theamson_barbute_helmet"
		]);

		items.equip(::Const.World.Common.pickHelmet(helm));
	}

});

