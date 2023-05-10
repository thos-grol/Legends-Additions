::mods_hookExactClass("skills/backgrounds/wildman_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.ResilientTree],
			[2, ::Const.Perks.ViciousTree],
			[0.4, ::Const.Perks.DeviousTree],
			[2, ::Const.Perks.LargeTree],
			[2, ::Const.Perks.SturdyTree],
			[2, ::Const.Perks.UnstoppableTree],
			[0.4, ::Const.Perks.TrainedTree],
			[0.5, ::Const.Perks.MenderClassTree],
			[2, ::Const.Perks.ScoutClassTree],
			[3, ::Const.Perks.HeavyArmorTree],
			[3, ::Const.Perks.MaceTree],
			[3, ::Const.Perks.HammerTree],
			[2, ::Const.Perks.AxeTree],
			[0.66, ::Const.Perks.SpearTree],
			[0.5, ::Const.Perks.SwordTree],
			[0, ::Const.Perks.StaffTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.WildlingProfessionTree
			],
			Styles = [
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

		if (this.Const.DLC.Unhold)
		{
			r = this.Math.rand(0, 7);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/wooden_stick"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_metal_club"));
			}
			else if (r == 3)
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_wooden_club"));
			}
			else if (r == 4)
			{
				items.equip(this.new("scripts/items/weapons/boar_spear"));
			}
			else if (r == 5)
			{
				items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
			}
			else if (r == 6)
			{
				items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
			}
			else if (r == 7)
			{
				items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
			}
		}
		else
		{
			r = this.Math.rand(0, 6);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/wooden_stick"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_metal_club"));
			}
			else if (r == 3)
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_wooden_club"));
			}
			else if (r == 4)
			{
				items.equip(this.new("scripts/items/weapons/boar_spear"));
			}
			else if (r == 5)
			{
				items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
			}
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"legend_rabble_fur"
			]
		]));
	}

});
