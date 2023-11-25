::mods_hookExactClass("skills/backgrounds/farmhand_background", function(o) {
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.DailyCost = ::Z.Backgrounds.Wages[this.m.ID].DailyCost;
		this.m.HiringCost = ::Z.Backgrounds.Wages[this.m.ID].HiringCost;

		this.m.PerkTreeDynamic = {
			Weapon = [
				::Const.Perks.PolearmTree
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
				::Const.Perks.PitchforkClassTree
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
			text = "Gains polearm proficiency faster (+10 chance)"
		});
		return ret;
	}

	o.onAddEquipment = function()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("ProficiencyBonusPolearm", true);
		
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(::new("scripts/items/weapons/legend_scythe"));
		}
		else if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/legend_hoe"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/pitchfork"));
		}
		else if (r == 4)
		{
			items.equip(::new("scripts/items/weapons/legend_wooden_pitchfork"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"sackcloth"
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
				2,
				""
			]
		]));
	}

});

