::mods_hookExactClass("skills/backgrounds/legend_blacksmith_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.AgileTree],
			[0.1, ::Const.Perks.DeviousTree],
			[0.5, ::Const.Perks.FastTree],
			[1.5, ::Const.Perks.LargeTree],
			[1.5, ::Const.Perks.ResilientTree],
			[1.5, ::Const.Perks.SturdyTree],
			[2, ::Const.Perks.OrganisedTree],
			[0.33, ::Const.Perks.LightArmorTree],
			[0, ::Const.Perks.BowTree],
			[0, ::Const.Perks.CrossbowTree],
			[0, ::Const.Perks.SlingTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.BlacksmithProfessionTree
			],
			Class = [
				::Const.Perks.MenderClassTree
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
		items.equip(this.new("scripts/items/weapons/legend_hammer"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"legend_blacksmith_apron"
			]
		]));
	}

});

