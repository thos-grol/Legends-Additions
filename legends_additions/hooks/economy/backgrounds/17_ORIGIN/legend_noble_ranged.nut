::mods_hookExactClass("skills/backgrounds/legend_noble_ranged", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.1, ::Const.Perks.OrganisedTree],
			[3, ::Const.Perks.MediumArmorTree],
			[9, ::Const.Perks.BowTree],
			[0.5, ::Const.Perks.PolearmTree],
			[0, ::Const.Perks.StaffTree],
			[3, ::Const.Perks.SlingTree],
			[0, ::Const.Perks.ThrowingTree]
		];

		this.m.PerkTreeDynamic = {
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Weapon = [
				::Const.Perks.CrossbowTree
			],
			Styles = [
				::Const.Perks.RangedTree,
				::Const.Perks.OneHandedTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"open_leather_cap"
			]
		]));
		items.equip(this.new("scripts/items/weapons/light_crossbow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		items.addToBag(this.new("scripts/items/weapons/knife"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				2,
				"padded_surcoat"
			],
			[
				1,
				"basic_mail_shirt"
			]
		]));
	}

});

