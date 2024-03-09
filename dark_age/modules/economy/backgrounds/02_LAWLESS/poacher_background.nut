::mods_hookExactClass("skills/backgrounds/poacher_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.BowTree,
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};

		this.m.Excluded = [
			"trait.loyal",

			"trait.bright",
			"trait.brave",
			"trait.fearless",

			"trait.night_blind",
			"trait.short_sighted",

			"trait.fat",
			"trait.clubfooted",

			"trait.seductive"
		];
	}

	o.getTooltip <- function ()
	{
		local ret = this.character_background.getTooltip();
		// ret.push({
		// 	id = 12,
		// 	type = "text",
		// 	icon = "ui/icons/special.png",
		// 	text = "Gains sling proficiency faster (+10 chance)"
		// });
		return ret;
	}

	o.onAddEquipment = function()
	{
		local actor = this.getContainer().getActor();
		// actor.getFlags().set("ProficiencyBonusSling", true);

		local items = this.getContainer().getActor().getItems();
		local r;

		items.equip(::new("scripts/items/weapons/legend_sling"));
		items.addToBag(::new("scripts/items/weapons/knife"));

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"ragged_surcoat"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			]
		]));

		this.m.Container.add(::new("scripts/skills/traits/_ranged_focus"));
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

