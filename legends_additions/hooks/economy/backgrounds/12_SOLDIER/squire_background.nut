::mods_hookExactClass("skills/backgrounds/squire_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[3, ::Const.Perks.CalmTree],
			[0.2, ::Const.Perks.OrganisedTree],
			[0.25, ::Const.Perks.DeviousTree],
			[0.5, ::Const.Perks.ShieldTree],
			[2, ::Const.Perks.HeavyArmorTree],
			[0.5, ::Const.Perks.SpearTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[30, ::Const.Perks.SoldierProfessionTree],
					[70, ::Const.Perks.NoTree]
				])
			],
			Traits = [
				::Const.Perks.TrainedTree
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[75, ::Const.Perks.SergeantClassTree],
					[25, ::Const.Perks.TacticianClassTree]
				])
			],
			Weapon = [
				::Const.Perks.PolearmTree,
				::Const.Perks.SwordTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"padded_leather"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"gambeson"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"nasal_helmet"
			],
			[
				1,
				"full_aketon_cap"
			],
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"open_leather_cap"
			]
		]));
	}

});

