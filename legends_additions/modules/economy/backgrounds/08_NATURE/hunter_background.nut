::mods_hookExactClass("skills/backgrounds/hunter_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.BowTree,
				::Const.Perks.DaggerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.ShortbowClassTree
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
			text = "Gains bow proficiency faster (+5 chance)"
		});
		return ret;
	}

	o.onAddEquipment = function()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("ProficiencyBonusBow", true);

		local items = this.getContainer().getActor().getItems();
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));

		if (this.Math.rand(0, 1) == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic"
			],
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"linen_tunic"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			]
		]));
	}

});

