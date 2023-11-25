::mods_hookExactClass("skills/backgrounds/lumberjack_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.AxeTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.LargeTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.WoodaxeClassTree
			],
			Magic = []
		};
	}

	o.getTooltip <- function ()
	{
		local ret = this.character_background.getTooltip();
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/special.png",
			text = "Gains axe proficiency faster (+10 chance)"
		});
		return ret;
	}

	o.onAddEquipment = function()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("ProficiencyBonusAxe", true);

		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/hand_axe"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/hatchet"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/woodcutters_axe"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/legend_saw"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				2,
				"padded_surcoat"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic",
				6
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"hood"
			]
		]));
	}

});

