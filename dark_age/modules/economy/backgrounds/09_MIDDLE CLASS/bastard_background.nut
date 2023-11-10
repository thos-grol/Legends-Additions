::mods_hookExactClass("skills/backgrounds/bastard_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.ShieldTree
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
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/shortsword"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/hand_axe"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(::new("scripts/items/shields/heater_shield"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"padded_leather"
			],
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"padded_surcoat"
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
				"hood"
			]
		]));
	}

});
