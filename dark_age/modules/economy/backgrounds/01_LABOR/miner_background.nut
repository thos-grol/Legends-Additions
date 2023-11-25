::mods_hookExactClass("skills/backgrounds/miner_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.HammerTree
			],
			Defense = [
				::Const.Perks.LightArmorTree
			],
			Traits = [],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.PickaxeClassTree
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
			text = "Gains hammer proficiency faster (+10 chance)"
		});
		return ret;
	}

	o.onAddEquipment = function()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("ProficiencyBonusHammer", true);

		local items = this.getContainer().getActor().getItems();
		items.equip(::new("scripts/items/weapons/pickaxe"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
			]
		]));
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				""
			],
			[
				1,
				"mouth_piece"
			]
		]));
	}

});

