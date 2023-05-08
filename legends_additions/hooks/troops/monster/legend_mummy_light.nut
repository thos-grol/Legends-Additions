::Const.Tactical.Actor.LegendMummyLight = {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 90,
	Bravery = 60,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 55,
	MeleeDefense = 10,
	RangedDefense = 5,
	Initiative = 65,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		20,
		20
	]
};
::mods_hookExactClass("entity/tactical/enemies/legend_mummy_light", function(o) {
	o.onInit = function()
	{
		this.legend_mummy.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyLight);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
	}

	o.assignRandomEquipment = function()
	{
		if (!this.m.IsRanged)
		{
			local r = this.Math.rand(0, 3);

			if (r == 0)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/broken_ancient_sword"));
			}
			else if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_spear"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/ancient_sword"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_khopesh"));
			}

			if (this.Math.rand(1, 100) <= 66)
			{
				this.m.Items.equip(this.new("scripts/items/shields/ancient/legend_mummy_shield"));
			}
		}
		else
		{
			local weapons = [
				[
					"weapons/short_bow",
					"ammo/quiver_of_arrows"
				]
			];
			local n = this.Math.rand(0, weapons.len() - 1);

			foreach( w in weapons[n] )
			{
				this.m.Items.equip(this.new("scripts/items/" + w));
			}

			this.m.Items.addToBag(this.new("scripts/items/weapons/ancient/legend_khopesh"));
		}

		local armor = [
			[
				2,
				"ancient/legend_mummy_bandages"
			],
			[
				3,
				""
			]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);
		item = this.Const.World.Common.pickHelmet([
			[
				1,
				"ancient/legend_mummy_bandages"
			],
			[
				4,
				""
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

