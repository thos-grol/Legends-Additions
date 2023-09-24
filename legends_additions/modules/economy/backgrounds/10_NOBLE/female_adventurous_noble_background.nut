::mods_hookExactClass("skills/backgrounds/female_adventurous_noble_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.ShieldTree,
				::Const.Perks.PolearmTree,
				::Const.Perks.BowTree
			],
			Defense = [],
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
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/pike"));
		}

		items.equip(::Const.World.Common.pickArmor([
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
		items.equip(::Const.World.Common.pickHelmet([
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

