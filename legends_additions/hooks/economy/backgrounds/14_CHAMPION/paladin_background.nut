::mods_hookExactClass("skills/backgrounds/paladin_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[1.2, ::Const.Perks.AgileTree],
			[0, ::Const.Perks.DeviousTree],
			[1.2, ::Const.Perks.FastTree],
			[0, ::Const.Perks.OrganisedTree],
			[1.33, ::Const.Perks.TrainedTree],
			[1.5, ::Const.Perks.MenderClassTree],
			[1.5, ::Const.Perks.SergeantClassTree],
			[1.5, ::Const.Perks.TacticianClassTree],
			[0, ::Const.Perks.LightArmorTree],
			[0, ::Const.Perks.BowTree],
			[0, ::Const.Perks.CrossbowTree],
			[0, ::Const.Perks.SlingTree],
			[0.5, ::Const.Perks.DaggerTree],
			[0, ::Const.Perks.RangedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[5, ::Const.Perks.SoldierProfessionTree],
					[5, ::Const.Perks.MilitiaProfessionTree],
					[3, ::Const.Perks.RaiderProfessionTree],
					[1, ::Const.Perks.NobleProfessionTree],
					[1, ::Const.Perks.WildlingProfessionTree],
					[1, ::Const.Perks.JugglerProfessionTree],
					[5, ::Const.Perks.ButcherProfessionTree],
					[5, ::Const.Perks.DiggerProfessionTree],
					[5, ::Const.Perks.FarmerProfessionTree],
					[5, ::Const.Perks.LaborerProfessionTree],
					[5, ::Const.Perks.LumberjackProfessionTree],
					[5, ::Const.Perks.MinerProfessionTree],
					[54, ::Const.Perks.NoTree]
				])
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/arming_sword",
				"weapons/fighting_axe",
				"weapons/winged_mace",
				"weapons/military_pick",
				"weapons/warhammer",
				"weapons/billhook",
				"weapons/longaxe",
				"weapons/greataxe",
				"weapons/greatsword"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/longsword",
					"weapons/polehammer",
					"weapons/two_handed_flail",
					"weapons/two_handed_flanged_mace"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/bardiche"
				]);
			}

			items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (items.hasEmptySlot(this.Const.ItemSlot.Offhand) && this.Math.rand(1, 100) <= 75)
		{
			local shields = [
				"shields/wooden_shield",
				"shields/wooden_shield",
				"shields/heater_shield",
				"shields/kite_shield"
			];
			items.equip(this.new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
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

