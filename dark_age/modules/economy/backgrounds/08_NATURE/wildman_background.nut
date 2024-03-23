::mods_hookExactClass("skills/backgrounds/wildman_background", function(o) {
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
			Traits = [
				::Const.Perks.SturdyTree
			],
			Enemy = [],
			Class = [
				::Const.Perks.FistsClassTree
			],
			Magic = []
		};

		this.m.IsGuaranteed = [
			"dumb_trait"
		];
	}

	o.onAddEquipment = function()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		r = ::Math.rand(1, 3);
		if (r == 1)
		{
			items.equip(::new("scripts/items/weapons/wooden_stick"));
		}
		else if (r == 2)
		{
			items.equip(::new("scripts/items/weapons/greenskins/orc_metal_club"));
		}
		else if (r == 3)
		{
			items.equip(::new("scripts/items/weapons/greenskins/orc_wooden_club"));
		}

		items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"leather_wraps"
			],
			[
				1,
				"legend_rabble_fur"
			]
		]));
	}

	o.onChangeAttributes <- function()
	{
		local c = {
			Hitpoints = [
				40,
				40
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
				20,
				20
			],
			Initiative = [
				0,
				0
			]
		};
		return c;
	}

	o.onUpdate = function( _properties )
	{
		this.character_background.onUpdate(_properties);
	}

});
