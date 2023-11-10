::mods_hookExactClass("skills/backgrounds/legend_crusader_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SwordTree,
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree
				::Const.Perks.IndestructibleTree,
				::Const.Perks.MartyrTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FaithClassTree
			],
			Magic = []
		};
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.MeleeDefense] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r <= 2)
		{
			items.equip(::new("scripts/items/weapons/flail"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 4)
		{
			items.equip(::new("scripts/items/weapons/warhammer"));
		}

		local shield;
		r = this.Math.rand(0, 4);

		if (r <= 2)
		{
			shield = ::new("scripts/items/shields/legend_tower_shield");
		}
		else if (r == 3)
		{
			shield = ::new("scripts/items/shields/heater_shield");
		}
		else if (r == 4)
		{
			shield = ::new("scripts/items/shields/kite_shield");
		}

		shield.onPaintSpecificColor(23);
		items.equip(shield);
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
		local item = ::Const.World.Common.pickHelmet([
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
		]);

		if (item != null)
		{
			item.onPaint(::Const.Items.Paint.None);
			items.equip(item);
		}
	}

});

