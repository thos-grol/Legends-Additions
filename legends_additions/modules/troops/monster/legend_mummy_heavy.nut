::Const.Tactical.Actor.LegendMummyHeavy = {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 40,
	RangedDefense = 20,
	Initiative = 70,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	Armor = [
		75,
		75
	]
};
::mods_hookExactClass("entity/tactical/enemies/legend_mummy_heavy", function(o) {
	o.onInit = function()
	{
		this.legend_mummy.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendMummyHeavy);
		b.Initiative -= 20;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 100)
		{
			b.IsSpecializedInPolearms = true;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_slaughter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r = this.Math.rand(0, 4);

		if (r == 0)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_fan_axe"));
		}
		else if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/crypt_cleaver"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/bladed_pike"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/legend_great_khopesh"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/ancient/rhomphaia"));
		}

		local armor = [
			[
				1,
				"ancient/legend_mummy_bandages"
			],
			[
				4,
				"ancient/legend_mummy_royal_plate"
			]
		];
		local item = this.Const.World.Common.pickArmor(armor);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[
				2,
				"ancient/ancient_wig"
			],
			[
				5,
				"ancient/legend_mummy_headband"
			],
			[
				1,
				"ancient/legend_mummy_crown_king"
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		local weapons = [
			[
				1,
				"named_billhook"
			],
			[
				1,
				"named_crypt_cleaver"
			],
			[
				1,
				"named_khopesh"
			],
			[
				1,
				"named_legend_great_khopesh"
			],
			[
				1,
				"named_rusty_warblade"
			]
		];
		local weaponAdd = this.Const.World.Common.pickItem(weapons, "scripts/items/weapons/named/");
		this.m.Items.equip(weaponAdd);
	}

});

