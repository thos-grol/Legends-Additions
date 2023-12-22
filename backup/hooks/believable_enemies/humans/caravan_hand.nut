//Lvl 5 Caravan Hand template
//4 perks
//similar builds to thugs, not very talented, but has some basic training
::Const.Tactical.Actor.CaravanHand <- {
	XP = 125,
	ActionPoints = 9,
	Hitpoints = 59,
	Bravery = 38,
	Stamina = 101,
	MeleeSkill = 54,
	RangedSkill = 37,
	MeleeDefense = 3,
	RangedDefense = 3,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/caravan_hand", function(o) {
	o.assignRandomEquipment = function()
	{
		//Tribal Perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_skillful_stacking"));

		//defensive perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));

		if (::Math.rand(1, 100) <= 75) this.m.Items.equip(::new("scripts/items/shields/wooden_shield"));

		local r = ::Math.rand(4, 9);
		if (r == 4)
		{
			this.m.Items.equip(::new("scripts/items/weapons/hatchet"));
			
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_dismemberment"));
			this.level_melee_skill(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_defense(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_health(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
		}
		else if (r == 5)
		{
			this.m.Items.equip(::new("scripts/items/weapons/bludgeon"));
			
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_push_it"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heavy_strikes"));
			this.level_fatigue(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_skill(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_defense(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
		}
		else if (r == 6)
		{
			this.m.Items.equip(::new("scripts/items/weapons/militia_spear"));
			this.m.Items.equip(::new("scripts/items/shields/wooden_shield"));
			
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pointy_end"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_through_the_gaps"));
			this.level_fatigue(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_skill(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_defense(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );

		}
		else if (r == 7)
		{
			this.m.Items.equip(::new("scripts/items/weapons/scramasax"));
			
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_swordlike"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_deep_cuts"));
			this.level_fatigue(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_skill(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_defense(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
		}
		else if (r == 8)
		{
			this.m.Items.equip(::new("scripts/items/weapons/shortsword"));
			
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_deep_cuts"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_fluid_weapon"));
			this.level_fatigue(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_skill(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_defense(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
		}
		else if (r == 9)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_militia_glaive"));
			
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_deep_cuts"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_fluid_weapon"));
			this.level_initiative(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_skill(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
			this.level_melee_defense(4, ::Math.rand(1, 4) > 3 ? 0 : 1 );
		}



		local item = ::Const.World.Common.pickArmor([
			[
				1,
				"leather_tunic",
				::Math.rand(6, 7)
			],
			[
				1,
				"padded_leather"
			],
			[
				1,
				"padded_surcoat"
			],
			[
				1,
				"leather_lamellar"
			]
		]);
		this.m.Items.equip(item);

		if (::Math.rand(1, 100) <= 33)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					1,
					"hood"
				],
				[
					1,
					"aketon_cap"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.CaravanHand);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_caravan");
		this.getSprite("dirt").Visible = true;
	}
});
