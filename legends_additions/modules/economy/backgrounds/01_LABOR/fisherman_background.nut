::mods_hookExactClass("skills/backgrounds/fisherman_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.SpearTree,
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [
				::Const.Perks.FitTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.BeastClassTree
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
			text = "Gains spear proficiency faster (+5 chance)"
		});
		return ret;
	}

	o.onAddEquipment = function()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("ProficiencyBonusSpear", true);

		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}

		items.equip(this.new("scripts/items/tools/throwing_net"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			],
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"linen_tunic",
				this.Math.rand(6, 7)
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"straw_hat"
			],
			[
				1,
				""
			]
		]));
	}

});

