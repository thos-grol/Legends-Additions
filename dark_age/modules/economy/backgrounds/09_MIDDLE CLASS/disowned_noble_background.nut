::mods_hookExactClass("skills/backgrounds/disowned_noble_background", function(o) {
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
		r = ::Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/shortsword"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/militia_spear"));
		}

		r = ::Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(::new("scripts/items/shields/wooden_shield"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/shields/buckler_shield"));
		}

		items.equip(::Const.World.Common.pickArmor([
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
				"mail_shirt"
			],
			[
				1,
				"mail_hauberk"
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
				"aketon_cap"
			],
			[
				1,
				"full_aketon_cap"
			],
			[
				1,
				"mail_coif"
			],
			[
				1,
				"feathered_hat"
			],
			[
				3,
				""
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
				0,
				0
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
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

