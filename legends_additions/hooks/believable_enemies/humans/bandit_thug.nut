//Bandit Thug
//Lvl 5 peasant templates
//Avg Daytaler stats, 1 tribal perk + 4 perks
//1 defensive perk like poacher
//3 combat perks
::Const.Tactical.Actor.BanditThug <- {
	XP = 150,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 35,
	Stamina = 95,
	MeleeSkill = 56,
	RangedSkill = 40,
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

::mods_hookExactClass("entity/tactical/enemies/bandit_thug", function(o) {
	o.assignRandomEquipment = function()
	{
		//tribal trait
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));
		//defensive perk
		local flag = false;

		local r = this.Math.rand(1, 6);

		if (r == 1)
		{
			r = this.Math.rand(1, 4);
			if (r == 1)
			{
				this.m.Items.equip(::new("scripts/items/weapons/woodcutters_axe"));
				this.level_health(4, this.Math.rand(-6, 3) );
				this.level_melee_skill(4, this.Math.rand(-6, 3) );
				this.level_melee_defense(4, this.Math.rand(-6, 3) );
				this.m.Skills.add(::new("scripts/skills/perks/perk_colossus"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_legend_smashing_shields"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(::new("scripts/items/weapons/goedendag"));
				this.level_resolve(4, this.Math.rand(-6, 3) );
				this.level_melee_skill(4, this.Math.rand(-6, 3) );
				this.level_melee_defense(4, this.Math.rand(-6, 3) );
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pointy_end"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_through_the_gaps"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_small_target"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(::new("scripts/items/weapons/pitchfork"));
				this.level_melee_skill(4, this.Math.rand(-6, 3) );
				this.level_resolve(4, this.Math.rand(-6, 3) );
				this.level_initiative(4, this.Math.rand(-6, 3) );
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pointy_end"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_leverage"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_intimidate"));
			}
			else
			{
				this.m.Items.equip(::new("scripts/items/weapons/legend_ranged_wooden_flail"));
				this.level_melee_skill(4, this.Math.rand(-6, 3) );
				this.level_resolve(4, this.Math.rand(-6, 3) );
				this.level_initiative(4, this.Math.rand(-6, 3) );
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_from_all_sides"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_head_smasher"));
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_small_target"));

			}
		}
		else if (r == 2)
		{
			this.m.Items.equip(::new("scripts/items/weapons/hatchet"));
			this.level_fatigue(4, this.Math.rand(-6, 3) );
			this.level_melee_defense(4, this.Math.rand(-6, 3) );
			this.level_health(4, this.Math.rand(-6, 3) );
			this.m.Skills.add(::new("scripts/skills/perks/perk_colossus"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_dismemberment"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(::new("scripts/items/weapons/bludgeon"));
			this.level_fatigue(4, this.Math.rand(-6, 3) );
			this.level_melee_defense(4, this.Math.rand(-6, 3) );
			this.level_health(4, this.Math.rand(-6, 3) );
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_push_it"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heavy_strikes"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bear_down"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(::new("scripts/items/weapons/pickaxe"));
			this.level_melee_defense(4, this.Math.rand(-6, 3) );
			this.level_fatigue(4, this.Math.rand(-6, 3) );
			this.level_initiative(4, this.Math.rand(-6, 3) );
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_rattle"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_internal_hemorrhage"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(::new("scripts/items/weapons/butchers_cleaver"));
			this.level_melee_defense(4, this.Math.rand(-6, 3) );
			this.level_fatigue(4, this.Math.rand(-6, 3) );
			this.level_health(4, this.Math.rand(-6, 3) );
			this.m.Skills.add(::new("scripts/skills/perks/perk_colossus"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_deep_cuts"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_sanguinary"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(::new("scripts/items/weapons/dagger"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_light_weapon"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
			this.level_melee_skill(4, this.Math.rand(-6, 3) );
			this.level_melee_defense(4, this.Math.rand(-6, 3) );
			this.level_initiative(4, this.Math.rand(-6, 3) );
			flag = true
		}

		if (!flag)
		{
			if(this.Math.rand(1, 6) < 6) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
			else this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
		}

		if (this.Math.rand(1, 100) <= 40)
		{
			local r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.equip(::new("scripts/items/shields/wooden_shield"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(::new("scripts/items/shields/buckler_shield"));
			}
		}

		local item = ::Const.World.Common.pickArmor([
			[
				20,
				"blotched_gambeson"
			],
			[
				20,
				"ragged_surcoat"
			],
			[
				20,
				"padded_surcoat"
			],
			[
				20,
				"thick_tunic"
			],
			[
				20,
				"gambeson"
			]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}

		item = ::Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			],
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				"headscarf"
			],
			[
				1,
				"mouth_piece"
			],
			[
				1,
				"full_leather_cap"
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

	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditThug);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		this.setArmorSaturation(0.8);
		this.getSprite("shield_icon").setBrightness(0.9);
	}
});
