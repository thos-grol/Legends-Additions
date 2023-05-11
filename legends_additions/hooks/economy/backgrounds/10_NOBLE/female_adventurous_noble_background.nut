::mods_hookExactClass("skills/backgrounds/female_adventurous_noble_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.25, ::Const.Perks.ResilientTree],
			[0.25, ::Const.Perks.LargeTree],
			[0.25, ::Const.Perks.SturdyTree],
			[0.5, ::Const.Perks.ShieldTree],
			[2, ::Const.Perks.MediumArmorTree],
			[3, ::Const.Perks.CrossbowTree],
			[0.33, ::Const.Perks.SlingTree],
			[1.5, ::Const.Perks.PolearmTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.NobleProfessionTree
			],
			Traits = [
				::Const.Perks.AgileTree
			],
			Class = [
				::MSU.Class.WeightedContainer([
					[50, ::Const.Perks.SergeantClassTree],
					[50, ::Const.Perks.TacticianClassTree]
				])
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Weapon = [
				::Const.Perks.BowTree
			],
			Styles = [
				::Const.Perks.RangedTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/pike"));
		}

		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"mail_shirt"
			],
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"mail_hauberk"
			]
		]));
		items.equip(this.Const.World.Common.pickHelmet([
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
				"nasal_helmet_with_mail"
			],
			[
				1,
				"mail_coif"
			],
			[
				1,
				"legend_noble_floppy_hat"
			],
			[
				1,
				"legend_noble_hat"
			],
			[
				1,
				"legend_noble_hood"
			],
			[
				1,
				"legend_noble_crown"
			],
			[
				2,
				""
			]
		]));
	}

});

