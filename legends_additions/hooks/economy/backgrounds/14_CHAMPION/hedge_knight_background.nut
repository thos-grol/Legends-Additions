::mods_hookExactClass("skills/backgrounds/hedge_knight_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[0.25, ::Const.Perks.AgileTree],
			[0.25, ::Const.Perks.FastTree],
			[0.1, ::Const.Perks.DeviousTree],
			[0.1, ::Const.Perks.OrganisedTree],
			[0.5, ::Const.Perks.TalentedTree],
			[0.5, ::Const.Perks.CalmTree],
			[2, ::Const.Perks.TacticianClassTree],
			[2, ::Const.Perks.MediumArmorTree],
			[0.66, ::Const.Perks.ShieldTree],
			[0.1, ::Const.Perks.LightArmorTree],
			[0, ::Const.Perks.BowTree],
			[0, ::Const.Perks.CrossbowTree],
			[0.5, ::Const.Perks.DaggerTree],
			[0, ::Const.Perks.SlingTree],
			[0.16, ::Const.Perks.SpearTree],
			[0, ::Const.Perks.StaffTree],
			[0, ::Const.Perks.ThrowingTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[20, ::Const.Perks.RaiderProfessionTree],
					[10, ::Const.Perks.SoldierProfessionTree],
					[70, ::Const.Perks.NoTree]
				])
			],
			Defense = [
				::Const.Perks.HeavyArmorTree
			],
			Styles = [
				::Const.Perks.OneHandedTree,
				::Const.Perks.TwoHandedTree
			],
			Enemy = [
				::Const.Perks.SwordmastersTree
			]

		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/greataxe"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/greatsword"));
		}

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
		local helm = [
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
		];

		if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		{
			helm.push([
				1,
				"theamson_barbute_helmet"
			]);
		}

		items.equip(this.Const.World.Common.pickHelmet(helm));
	}

});

