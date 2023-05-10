::mods_hookExactClass("skills/backgrounds/legend_crusader_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.ResilientTree],
			[0.25, ::Const.Perks.ViciousTree],
			[0, ::Const.Perks.DeviousTree],
			[0.1, ::Const.Perks.OrganisedTree],
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
			[0.5, ::Const.Perks.SpearTree]
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
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeDefense] = 3;
		this.getContainer().getActor().fillTalentValues(2, true);
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r <= 2)
		{
			items.equip(this.new("scripts/items/weapons/flail"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/warhammer"));
		}

		local shield;
		r = this.Math.rand(0, 4);

		if (r <= 2)
		{
			shield = this.new("scripts/items/shields/legend_tower_shield");
		}
		else if (r == 3)
		{
			shield = this.new("scripts/items/shields/heater_shield");
		}
		else if (r == 4)
		{
			shield = this.new("scripts/items/shields/kite_shield");
		}

		shield.onPaintSpecificColor(23);
		items.equip(shield);
		items.equip(this.Const.World.Common.pickArmor([
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
		local item = this.Const.World.Common.pickHelmet([
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
			item.onPaint(this.Const.Items.Paint.None);
			items.equip(item);
		}
	}

});

