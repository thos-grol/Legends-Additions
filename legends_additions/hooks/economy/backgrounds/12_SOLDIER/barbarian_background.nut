::mods_hookExactClass("skills/backgrounds/barbarian_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.25, ::Const.Perks.CalmTree],
			[0, ::Const.Perks.OrganisedTree],
			[3, ::Const.Perks.UnstoppableTree],
			[2, ::Const.Perks.ViciousTree],
			[0.2, ::Const.Perks.ClerkClassTree],
			[0, ::Const.Perks.EntertainerClassTree],
			[0.2, ::Const.Perks.ShieldTree],
			[3, ::Const.Perks.HeavyArmorTree],
			[2, ::Const.Perks.AxeTree],
			[2, ::Const.Perks.HammerTree],
			[2, ::Const.Perks.MaceTree],
			[2, ::Const.Perks.CleaverTree],
			[0, ::Const.Perks.BowTree],
			[0, ::Const.Perks.SlingTree],
			[0, ::Const.Perks.CrossbowTree],
			[0.5, ::Const.Perks.DaggerTree],
			[0.5, ::Const.Perks.PolearmTree],
			[0.66, ::Const.Perks.SpearTree],
			[0, ::Const.Perks.StaffTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[50, ::Const.Perks.RaiderProfessionTree],
					[50, ::Const.Perks.WildlingProfessionTree]
				])
			],
			Traits = [
				::MSU.Class.WeightedContainer([
					[50, ::Const.Perks.LargeTree],
					[50, ::Const.Perks.AgileTree]
				])
			],
			Styles = [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 3);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/axehammer"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/crude_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}

		items.equip(this.Const.World.Common.pickArmor([
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
		items.equip(this.Const.World.Common.pickHelmet([
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

});
