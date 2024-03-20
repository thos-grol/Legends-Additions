::mods_hookExactClass("skills/backgrounds/retired_soldier_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;
		this.m.PerkTreeDynamicMins.Traits = 3;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.AxeTree,
				::Const.Perks.ShieldTree
			],
			Defense = [
				::Const.Perks.HeavyArmorTree,
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.TrainedTree,
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};

		this.m.IsGuaranteed = [
			"old_trait"
		];

		
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(::new("scripts/items/weapons/hand_axe"));

		r = ::Math.rand(0, 3);
		if (r == 0)
		{
			items.equip(::new("scripts/items/shields/wooden_shield"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"patched_mail_shirt"
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"basic_mail_shirt"
			],
			[
				1,
				"worn_mail_shirt"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				2,
				""
			],
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
				"mail_coif"
			],
			[
				1,
				"rusty_mail_coif"
			],
			[
				1,
				"aketon_cap"
			],
			[
				1,
				"full_aketon_cap"
			]
		]));
	}

	o.onChangeAttributes <- function()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
				0
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				20,
				20
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				20,
				20
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

});

