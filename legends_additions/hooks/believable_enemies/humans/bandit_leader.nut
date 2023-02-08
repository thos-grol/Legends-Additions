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

	o.getBuildNumber <- function()
	{
		this.m.build_num = this.Math.rand(1, 100);

	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.m.IsMiniboss = true;
		this.getBuildNumber();

		this.m.XP *= 1.5;
		this.m.IsGeneratingKillName = false;
		this.getSprite("miniboss").setBrush("bust_miniboss");




		//TODO: champion logic - get build number and replace items with named items

		local shields = clone ::Const.Items.NamedShields;
		shields.extend([
			"shields/named/named_bandit_kite_shield",
			"shields/named/named_bandit_heater_shield"
		]);
		local r = this.Math.rand(1, 3);

		if (r == 2)
		{
			this.m.Items.equip(::new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (r == 1)
		{
			local namedWeaponArray = clone ::Const.Items.NamedMeleeWeapons;
			::MSU.Array.remove(namedWeaponArray, "weapons/named/named_dagger");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_parrying_dagger");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_shovel");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_sickle");
			this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(namedWeaponArray)));
		}
		else if (r == 2)
		{
			local named = ::Const.Items.NamedArmors;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickArmor(weightName));
		}
		else if (r == 3)
		{
			local named = ::Const.Items.NamedHelmets;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickHelmet(weightName));
		}

		return true;
	}

	o.assignRandomEquipment = function()
	{
		this.addArmor();

		//Free Tribal Perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));

		//Bandit Leader Free Traits
		this.m.Skills.add(::new("scripts/skills/actives/rally_the_troops"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_shields_up"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_rally_the_troops"));
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

		if (!this.m.IsMiniboss) this.getBuildNumber();


		// "weapons/greatsword"

		//TODO: Bandit Leader builds

		// "weapons/fighting_axe"
		// "weapons/warhammer"

		// "weapons/winged_mace"
		// "weapons/military_cleaver"

		// "weapons/throwing_axe"
		// "weapons/javelin"

		//"shields/wooden_shield"
		// "shields/heater_shield"
		// "shields/kite_shield"

		this.m.Skills.update();
	}

	o.build_swordstaff <- function()
	{
		this.m.Items.equip(::new("scripts/items/weapons/legend_swordstaff"));
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
		if (this.m.no_man_of_steel) this.m.Skills.add(::new("scripts/skills/perks/perk_double_strike")); //7

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

		local agent = actor.getAIAgent();
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
