::mods_hookExactClass("skills/backgrounds/butcher_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.CleaverTree
			],
			Defense = [],
			Traits = [
				::Const.Perks.ViciousTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree,
				::Const.Perks.ButcherClassTree
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
			text = "Gains cleaver proficiency faster (+5 chance)"
		});
		return ret;
	}

	o.onAddEquipment = function()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("ProficiencyBonusCleaver", true);

		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(::new("scripts/items/weapons/butchers_cleaver"));
		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"butcher_apron"
			]
		]));
	}

});

