::mods_hookExactClass("skills/backgrounds/companion_1h_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.PerkGroupMultipliers <- [
			[2, ::Const.Perks.CalmTree],
			[2, ::Const.Perks.TalentedTree],
			[2, ::Const.Perks.TrainedTree],
			[0.25, ::Const.Perks.OrganisedTree],
			[0, ::Const.Perks.DeviousTree],
			[2, ::Const.Perks.SergeantClassTree],
			[2, ::Const.Perks.TacticianClassTree],
			[3, ::Const.Perks.HeavyArmorTree],
			[3, ::Const.Perks.MediumArmorTree],
			[2, ::Const.Perks.LightArmorTree],
			[3, ::Const.Perks.TwoHandedTree],
			[0, ::Const.Perks.BowTree],
			[0, ::Const.Perks.SlingTree],
			[0, ::Const.Perks.CrossbowTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::MSU.Class.WeightedContainer([
					[6, ::Const.Perks.MilitiaProfessionTree],
					[6, ::Const.Perks.ButcherProfessionTree],
					[6, ::Const.Perks.BlacksmithProfessionTree],
					[6, ::Const.Perks.MinerProfessionTree],
					[6, ::Const.Perks.FarmerProfessionTree],
					[6, ::Const.Perks.DiggerProfessionTree],
					[6, ::Const.Perks.LumberjackProfessionTree],
					[6, ::Const.Perks.LaborerProfessionTree],
					[6, ::Const.Perks.SoldierProfessionTree],
					[1, ::Const.Perks.JugglerProfessionTree],
					[43, ::Const.Perks.NoTree]
				])
			],
			Weapon = [
				::Const.Perks.SpearTree
			],
			Defense = [
				::Const.Perks.ShieldTree
			],
			Styles = [
				::Const.Perks.OneHandedTree
			]
		};
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
	}

	o.onAddEquipment = function()
	{
		local talents = this.getContainer().getActor().getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Hitpoints] = 2;
		talents[this.Const.Attributes.Fatigue] = 1;
		talents[this.Const.Attributes.Bravery] = 1;
		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.new("scripts/items/shields/wooden_shield"));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"gambeson"
			]
		]));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				"full_aketon_cap"
			],
			[
				1,
				"full_leather_cap"
			]
		]);
		items.equip(item);
	}

});

