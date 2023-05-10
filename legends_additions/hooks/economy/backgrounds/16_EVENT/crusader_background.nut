::mods_hookExactClass("skills/backgrounds/crusader_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.ResilientTree],
			[0.25, ::Const.Perks.ViciousTree],
			[0, ::Const.Perks.DeviousTree],
			[0, ::Const.Perks.OrganisedTree],
			[0, ::Const.Perks.LightArmorTree],
			[3, ::Const.Perks.ShieldTree],
			[0.5, ::Const.Perks.DaggerTree],
			[2, ::Const.Perks.SwordTree],
			[2, ::Const.Perks.MaceTree],
			[2, ::Const.Perks.FlailTree],
			[2, ::Const.Perks.HammerTree],
			[0.33, ::Const.Perks.PolearmTree],
			[0, ::Const.Perks.ThrowingTree],
			[0, ::Const.Perks.BowTree],
			[0, ::Const.Perks.CrossbowTree],
			[0, ::Const.Perks.SlingTree],
			[0.66, ::Const.Perks.SpearTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[70, ::Const.Perks.HolyManProfessionTree],
					[30, ::Const.Perks.SoldierProfessionTree]
				])
			],
			Enemy = [
				::Const.Perks.UndeadTree
			],
			Traits = [
				::Const.Perks.CalmTree
			],
			Class = [
				::Const.Perks.SergeantClassTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
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
		items.equip(this.new("scripts/items/weapons/greatsword"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"mail_hauberk"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"full_helm"
			]
		]));
	}

});

