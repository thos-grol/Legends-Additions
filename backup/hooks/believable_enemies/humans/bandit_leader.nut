//Bandit Leader
//Lvl 11 Player character template with 1-3 stars
//10 perks + 1 training perk + 1 trait
::Const.Tactical.Actor.BanditLeader <- {
	XP = 375,
	ActionPoints = 9,
	Hitpoints = 65,
	Bravery = 60,
	Stamina = 96,
	MeleeSkill = 65,
	RangedSkill = 40,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/enemies/bandit_leader", function(o)
{
	o.m.is_throwing <- false;
	o.m.is_shield <- false;
	o.m.no_man_of_steel <- false;

	o.m.build_num <- 0;
	o.m.is_miniboss <- false;
	o.m.named_item_type <- 0;

	o.getBuildNumber <- function()
	{
		this.m.build_num = this.Math.rand(1, 100) <= 35 ? this.Math.rand(1, 2) : this.Math.rand(3, 7);
		if (this.m.build_num > 2 && this.Math.rand(1, 100) <= 75) this.m.is_shield = true;
		if (this.m.build_num == 7) this.m.is_throwing = true;
	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.m.is_miniboss = true;
		this.getBuildNumber();

		this.m.XP *= 1.5;
		this.m.IsGeneratingKillName = false;
		this.getSprite("miniboss").setBrush("bust_miniboss");

		this.m.named_item_type = this.Math.rand(this.m.is_throwing ? 0 : 1, this.m.is_shield ? 3 : 2);
		switch(this.m.named_item_type)
		{
			case 0: //throwing weapons
				local throwing = [
					"weapons/named/named_javelin",
					"weapons/named/named_throwing_axe"
				];
				this.m.Items.addToBag(::new("scripts/items/" + ::MSU.Array.rand(throwing)));
				break;
			case 1: //weapon - logic is handled when adding equipment in builds
				break;
			case 2: //armor
				if (this.Math.rand(0,1) == 0)
				{
					local named = ::Const.Items.NamedArmors;
					local weightName = ::Const.World.Common.convNameToList(named);
					this.m.Items.equip(::Const.World.Common.pickArmor(weightName));
				}
				else
				{
					local named = ::Const.Items.NamedHelmets;
					local weightName = ::Const.World.Common.convNameToList(named);
					this.m.Items.equip(::Const.World.Common.pickHelmet(weightName));
				}
				break;
			case 3: //shields
				local shields = clone ::Const.Items.NamedShields;
				shields.extend([
					"shields/named/named_bandit_kite_shield",
					"shields/named/named_bandit_heater_shield"
				]);
				this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(shields)));
				break;
		}

		return true;
	}

	o.assignRandomEquipment = function()
	{
		this.addArmor();

		//Free Tribal Perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));

		//Bandit Leader Free Traits
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_shields_up"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_hold_the_line"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_push_forward"));

		//Defensive Perks 7
		this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
		this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow")); //2
		this.m.Skills.add(::new("scripts/skills/perks/perk_brawny")); //3
		this.m.Skills.add(::new("scripts/skills/perks/perk_steadfast")); //3 -> 4
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged")); //6
		if(this.Math.rand(1, 100) <= 25) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel")); //25% 7
		else this.m.no_man_of_steel = true;

		if (!this.m.is_miniboss) this.getBuildNumber(); //if build isnt already rolled, roll it

		if (this.m.is_shield) //if it is a rolled shield build
		{
			if (!this.m.is_miniboss || this.m.named_item_type != 3) //if it isnt a miniboss with item type 3
			{
				local shields = [
					"shields/heater_shield",
					"shields/kite_shield"
				];
				this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(shields)));
			}
			this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert")); //3
			this.m.Skills.add(::new("scripts/skills/perks/perk_str_line_breaker")); //?
		}

		switch(this.m.build_num)
		{
			case 1:
				this.build_swordstaff();
				break;
			case 2:
				this.build_greatsword();
				break;
			case 3:
				this.build_1haxe();
				break;
			case 4:
				this.build_1hcleaver();
				break;
			case 5:
				this.build_1hhammer();
				break;
			case 6:
				this.build_1hmace();
				break;
			case 7:
				this.build_thrower();
				break;
		}

		this.m.Skills.update();
	}

	o.build_swordstaff <- function() //1
	{
		if (this.m.is_miniboss && this.m.named_item_type == 1) this.m.Items.equip(::new("scripts/items/weapons/named/legend_named_swordstaff"));
		else this.m.Items.equip(::new("scripts/items/weapons/legend_swordstaff"));

		// Defensive Perks 6-7
		// this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow")); //2
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny")); //3
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steadfast")); //3 -> 4
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5
		// this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged")); //6
		// if(this.Math.rand(1, 100) <= 25) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel")); //25% 7

		//5-6 perks remaining:
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_two_for_one")); //5
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_a_better_grip")); //6
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_king_of_all_weapons")); //7
		if (this.m.no_man_of_steel) this.m.Skills.add(::new("scripts/skills/perks/perk_legend_clarity")); //6

		this.level_health(5, this.Math.rand(1, 3) );
		this.level_fatigue(5, this.Math.rand(1, 3) );
		this.level_melee_skill(7, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(2, 3) );
		this.level_initiative(3, this.Math.rand(1, 3) );

		if (o.m.is_miniboss || this.Math.rand(1, 100) <= 25)
		{
			if (this.Math.rand(1, 2) == 1) this.add_potion("orc", false);
			else this.add_potion("spider", false);
		}
	}

	o.build_greatsword <- function() //2
	{
		if (this.m.is_miniboss && this.m.named_item_type == 1) this.m.Items.equip(::new("scripts/items/weapons/named/named_greatsword"));
		else this.m.Items.equip(::new("scripts/items/weapons/greatsword"));
		// Defensive Perks 6-7
		// this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow")); //2
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny")); //3
		this.m.Skills.removeByID("perk.brawny");
		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind")); //3
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steadfast")); //3 -> 4
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5
		// this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged")); //6
		// if(this.Math.rand(1, 100) <= 25) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel")); //25% 7

		//5-6 perks remaining:
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_fluid_weapon")); //3
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_mind_over_body")); //6
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_en_garde")); //7
		if (this.m.no_man_of_steel) this.m.Skills.add(::new("scripts/skills/perks/perk_bloody_harvest")); //7

		this.level_health(3, this.Math.rand(1, 3) );
		this.level_resolve(10, 3 );
		this.level_melee_skill(7, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(1, 3) );

		if (o.m.is_miniboss || this.Math.rand(1, 100) <= 25) this.add_potion("direwolf", false);
	}

	o.build_1haxe <- function() //3
	{
		if (this.m.is_miniboss && this.m.named_item_type == 1) this.m.Items.equip(::new("scripts/items/weapons/named/named_axe"));
		else this.m.Items.equip(::new("scripts/items/weapons/fighting_axe"));
		// Defensive Perks 6-7
		// this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow")); //2
		this.m.Skills.removeByID("perk.steel_brow");
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft")); //2
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny")); //3
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steadfast")); //3 -> 4
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5
		// this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged")); //6
		// if(this.Math.rand(1, 100) <= 25) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel")); //25% 7

		//5-6 perks remaining:
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_axe")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_cull")); //7
		if (!this.m.is_shield)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_dismemberment")); //3
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_clarity")); //6
		}
		if (this.m.no_man_of_steel) this.m.Skills.add(::new("scripts/skills/perks/perk_duelist")); //7

		this.level_health(5, this.Math.rand(1, 3) );
		this.level_fatigue(5, this.Math.rand(1, 3) );
		this.level_melee_skill(7, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(2, 3) );
		this.level_initiative(3, this.Math.rand(1, 3) );

		if (o.m.is_miniboss || this.Math.rand(1, 100) <= 25) this.add_potion("ghoul", false);
	}

	o.build_1hcleaver <- function() //4
	{
		if (this.m.is_miniboss && this.m.named_item_type == 1) this.m.Items.equip(::new("scripts/items/weapons/named/named_cleaver"));
		else this.m.Items.equip(::new("scripts/items/weapons/military_cleaver"));
		// Defensive Perks 6-7
		// this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow")); //2
		this.m.Skills.removeByID("perk.steel_brow");
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_sanguinary")); //2
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny")); //3
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steadfast")); //3 -> 4
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5
		// this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged")); //6
		// if(this.Math.rand(1, 100) <= 25) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel")); //25% 7

		//5-6 perks remaining:
		//duelist
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_cleaver")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_mauler")); //7
		if (!this.m.is_shield)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bloodbath"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_sanguinary"));
		}
		if (this.m.no_man_of_steel) this.m.Skills.add(::new("scripts/skills/perks/perk_duelist")); //7

		this.level_health(5, this.Math.rand(1, 3) );
		this.level_fatigue(5, this.Math.rand(1, 3) );
		this.level_melee_skill(7, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(2, 3) );
		this.level_initiative(3, this.Math.rand(1, 3) );

		if (o.m.is_miniboss || this.Math.rand(1, 100) <= 25) this.add_potion("ghoul", false);
	}

	o.build_1hhammer <- function() //5
	{
		if (this.m.is_miniboss && this.m.named_item_type == 1) this.m.Items.equip(::new("scripts/items/weapons/named/named_warhammer"));
		else this.m.Items.equip(::new("scripts/items/weapons/warhammer"));
		// Defensive Perks 6-7
		// this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow")); //2
		this.m.Skills.removeByID("perk.steel_brow");
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft")); //2
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny")); //3
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steadfast")); //3 -> 4
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5
		// this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged")); //6
		// if(this.Math.rand(1, 100) <= 25) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel")); //25% 7

		//5-6 perks remaining:
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_hammer")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_dent_armor")); //7
		if (!this.m.is_shield)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_dismantle")); //3
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_deep_impact")); //6
		}
		if (this.m.no_man_of_steel) this.m.Skills.add(::new("scripts/skills/perks/perk_double_strike")); //7

		this.level_health(5, this.Math.rand(1, 3) );
		this.level_fatigue(5, this.Math.rand(1, 3) );
		this.level_melee_skill(7, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(2, 3) );
		this.level_initiative(3, this.Math.rand(1, 3) );

		if (o.m.is_miniboss || this.Math.rand(1, 100) <= 25) this.add_potion("ghoul", false);
	}

	o.build_1hmace <- function() //6
	{
		if (this.m.is_miniboss && this.m.named_item_type == 1) this.m.Items.equip(::new("scripts/items/weapons/named/named_mace"));
		else this.m.Items.equip(::new("scripts/items/weapons/winged_mace"));
		// Defensive Perks 6-7
		// this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow")); //2
		this.m.Skills.removeByID("perk.steel_brow");
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft")); //2
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny")); //3
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steadfast")); //3 -> 4
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5
		// this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged")); //6
		// if(this.Math.rand(1, 100) <= 25) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel")); //25% 7

		//5-6 perks remaining:
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_mace")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bone_breaker")); //7
		if (!this.m.is_shield)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_clarity")); //1
			this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm")); //2
		}
		if (this.m.no_man_of_steel) this.m.Skills.add(::new("scripts/skills/perks/perk_duelist")); //7

		this.level_health(2, this.Math.rand(1, 3) );
		this.level_fatigue(2, this.Math.rand(1, 3) );
		this.level_melee_skill(7, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(2, 3) );
		this.level_initiative(9, 3 );

		if (o.m.is_miniboss || this.Math.rand(1, 100) <= 25) this.add_potion("ghoul", false);
	}

	o.build_thrower <- function() //7
	{
		if (!this.m.is_miniboss || this.m.named_item_type != 0)
		{
			local throwing = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];
			this.m.Items.addToBag(::new("scripts/items/" + ::MSU.Array.rand(throwing)));
		}

		this.m.Items.equip(::new("scripts/items/weapons/fighting_axe"));
		// Defensive Perks 6-7
		// this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steel_brow")); //2
		this.m.Skills.removeByID("perk.steel_brow");
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft")); //2
		// this.m.Skills.add(::new("scripts/skills/perks/perk_brawny")); //3
		// this.m.Skills.add(::new("scripts/skills/perks/perk_steadfast")); //3 -> 4
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5
		// this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged")); //6
		// if(this.Math.rand(1, 100) <= 25) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel")); //25% 7

		//5-6 perks remaining:
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_clarity")); //6
		this.m.Skills.add(::new("scripts/skills/perks/perk_close_combat_archer")); //7

		this.m.Skills.removeByID("perk.str_line_breaker");
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_muscularity")); //7

		this.m.Skills.removeByID("perk.ptr_man_of_steel");
		this.m.Skills.removeByID("perk.underdog");
		this.m.Skills.removeByID("perk.steadfast");
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_hybridization")); //3
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_weapon_master")); //7

		if (!this.m.is_shield)
		{
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_cull")); //7
		}

		this.level_health(10, 3 );
		this.level_fatigue(3, this.Math.rand(1, 3) );
		this.level_ranged_skill(7, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(2, 3) );

		if (o.m.is_miniboss || this.Math.rand(1, 100) <= 25) this.add_potion("orc", false);

		local agent = actor.getAIAgent();
		agent.m.Properties.BehaviorMult[::Const.AI.Behavior.ID.EngageMelee] = 0.5;
		agent.finalizeBehaviors();
	}


	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditLeader);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);

		local agent = this.actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.Protect) != null)
		{
			agent.removeBehavior(::Const.AI.Behavior.ID.Protect);
			agent.finalizeBehaviors();
		}
	}

	o.addArmor <- function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local armor = [
				[
					1,
					"coat_of_plates"
				],
				[
					1,
					"coat_of_scales"
				],
				[
					1,
					"heavy_lamellar_armor"
				],
				[
					1,
					"footman_armor"
				],
				[
					1,
					"brown_hedgeknight_armor"
				],
				[
					1,
					"northern_mercenary_armor_02"
				],
				[
					1,
					"lamellar_harness"
				],
				[
					1,
					"reinforced_mail_hauberk"
				],
				[
					1,
					"leather_scale_armor"
				],
				[
					1,
					"light_scale_armor"
				]
			];
			local helmet = [
				[
					1,
					"closed_mail_coif"
				],
				[
					1,
					"padded_kettle_hat"
				],
				[
					1,
					"kettle_hat_with_closed_mail"
				],
				[
					1,
					"kettle_hat_with_mail"
				],
				[
					1,
					"padded_flat_top_helmet"
				],
				[
					1,
					"nasal_helmet_with_mail"
				],
				[
					1,
					"flat_top_with_mail"
				],
				[
					1,
					"padded_nasal_helmet"
				],
				[
					1,
					"bascinet_with_mail"
				]
			];
			local outfits = [
				[
					1,
					"red_bandit_leader_outfit_00"
				]
			];

			foreach( item in ::Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item);
			}

			return;
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Body) == null)
		{
			local armor = [
				[
					1,
					"reinforced_mail_hauberk"
				],
				[
					1,
					"worn_mail_shirt"
				],
				[
					1,
					"patched_mail_shirt"
				]
			];

			if (::Const.DLC.Unhold)
			{
				armor.extend([
					[
						1,
						"footman_armor"
					],
					[
						1,
						"leather_scale_armor"
					],
					[
						1,
						"light_scale_armor"
					],
					[
						1,
						"red_bandit_leader_armor"
					]
				]);
			}

			this.m.Items.equip(::Const.World.Common.pickArmor(armor));
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Head) == null)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					1,
					"closed_mail_coif"
				],
				[
					1,
					"padded_kettle_hat"
				],
				[
					1,
					"kettle_hat_with_closed_mail"
				],
				[
					1,
					"kettle_hat_with_mail"
				],
				[
					1,
					"padded_flat_top_helmet"
				],
				[
					1,
					"nasal_helmet_with_mail"
				],
				[
					1,
					"flat_top_with_mail"
				],
				[
					1,
					"padded_nasal_helmet"
				],
				[
					1,
					"bascinet_with_mail"
				],
				[
					1,
					"red_bandit_leader_helmet"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}
});
