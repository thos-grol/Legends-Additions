//Bandit Leader
//Lvl 11 Player character template with stars
//10 perks
::Const.Tactical.Actor.BanditLeader <- {
	XP = 375,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 60,
	Stamina = 96,
	MeleeSkill = 65,
	RangedSkill = 40,
	MeleeDefense = 10,
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
	o.m.build_num <- 0;

	o.assignRandomEquipment = function()
	{
		this.addArmor();

		//Free Tribal Perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));

		//Bandit Leader Free Traits
		this.m.Skills.add(::new("scripts/skills/actives/rally_the_troops"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));

		//Defensive Perks
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));

		//TODO: Bandit Leader builds

		//Commander Variant
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_shields_up"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rally_the_troops"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_hold_the_line"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_push_forward"));

		// "weapons/noble_sword",
		// "weapons/fighting_axe",
		// "weapons/warhammer",
		// "weapons/legend_glaive",
		// "weapons/fighting_spear",
		// "weapons/winged_mace",
		// "weapons/arming_sword",
		// "weapons/military_cleaver",
		// "weapons/greatsword",
		// "weapons/greataxe",
		// "weapons/legend_swordstaff",
		// "weapons/legend_longsword",
		// "weapons/warbrand",
		// "weapons/legend_glaive"

		//"shields/wooden_shield",
		// "shields/heater_shield",
		// "shields/kite_shield"

		// "weapons/throwing_axe",
		// "weapons/javelin"

		if (this.Math.rand(1, 100) <= 25) //2h weapons
		{
			this.m.build_num = this.Math.rand(0, 6);
			switch(this.m.build_num)
			{
				case 0: //Infantry axe - 4ap chop, split man, and smashing shields (6ap)
				case 1:
					this.m.Items.equip(::new("scripts/items/weapons/woodcutters_axe"));

					this.m.Skills.add(::new("scripts/skills/perks/perk_legend_smashing_shields")); //1
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft")); //2
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_balance")); //3
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_axe")); //4
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2 -> 5
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_cull")); //7
					this.level_melee_skill(7, this.Math.rand(-6, 3) );
					this.level_melee_defense(7, this.Math.rand(-6, 3) );
					this.level_resolve(4, this.Math.rand(-6, 3) );
					this.level_health(3, this.Math.rand(-6, 3) );
					break;
				case 2: //polearm - Pike
				case 4:
					this.m.Items.equip(::new("scripts/items/weapons/pike"));

					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pointy_end")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_intimidate")); //3
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm")); //4
					this.m.Skills.add(::new("scripts/skills/perks/perk_rotation")); //3 -> 5
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_follow_up")); //7

					this.level_melee_skill(7, this.Math.rand(-6, 3) );
					this.level_melee_defense(4, 1);
					this.level_initiative(4, this.Math.rand(-6, 3) );
					this.level_health(6, this.Math.rand(-6, 3) );
					break;
				case 3: //polearm - Hooked Blade
				case 5:
					this.m.Items.equip(::new("scripts/items/weapons/hooked_blade"));

					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_coup_de_grace")); //2 -> 3
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_polearm")); //4
					this.m.Skills.add(::new("scripts/skills/perks/perk_rotation")); //3 -> 5
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_follow_up")); //7

					this.level_melee_skill(7, this.Math.rand(-6, 3) );
					this.level_melee_defense(4, 1);
					this.level_initiative(4, this.Math.rand(-6, 3) );
					this.level_health(6, this.Math.rand(-6, 3) );
					break;
				case 6: //2h Mace
					local weapons = [
						"weapons/legend_two_handed_club"
					];
					this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(weapons)));
					this.m.Skills.removeByID("perk.legend_balance");

					this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heavy_strikes")); //2 -> 3
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_mace")); //4
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_dismantle")); //5
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bone_breaker")); //7


					this.level_melee_skill(7, this.Math.rand(-6, 3) );
					this.level_melee_defense(7, this.Math.rand(-6, 3) );
					this.level_resolve(4, this.Math.rand(-6, 3) );
					this.level_health(3, this.Math.rand(-6, 3) );

					break;
			}
		}
		else //1h weapons
		{
			this.m.build_num = this.Math.rand(7, 12);

			if (this.m.build_num > 9)
			{
				if (this.Math.rand(1, 100) <= 50)
				{
					if (this.Math.rand(1, 100) <= 75) this.m.Items.equip(::new("scripts/items/shields/wooden_shield"));
					else this.m.Items.equip(::new("scripts/items/shields/kite_shield"));
					this.m.is_shield = true;
					this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert")); //3
				}
			}

			switch(this.m.build_num)
			{
				case 7: //Tank
					this.m.Items.equip(::new("scripts/items/weapons/militia_spear"));
					this.m.Items.equip(::new("scripts/items/shields/wooden_shield"));

					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.removeByID("perk.legend_lithe");
					this.m.Skills.add(::new("scripts/skills/perks/perk_nine_lives")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_shield_expert")); //3
					this.m.Skills.add(::new("scripts/skills/perks/perk_rotation")); //3 -> 4
					this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind")); //3 -> 5
					this.m.Skills.add(::new("scripts/skills/perks/perk_legend_mind_over_body")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_last_stand")); //7

					this.level_melee_defense(7, this.Math.rand(-3, 3) );
					this.level_resolve(7, this.Math.rand(-2, 3) );
					this.level_fatigue(3, this.Math.rand(-6, 3) );
					this.level_health(4, this.Math.rand(-6, 3) );

					break;
				case 8: //Spear
				case 10:
				case 11: //Thrower
					switch(this.Math.rand(1, 3))
					{
						case 1:
							this.m.Items.addToBag(::new("scripts/items/weapons/throwing_axe"));
							break;
						case 2:
							this.m.Items.addToBag(::new("scripts/items/weapons/javelin"));
							break;
						case 3:
							this.m.Items.addToBag(::new("scripts/items/weapons/throwing_spear"));
							break;
					}
					this.m.is_throwing = true;

					if (this.Math.rand(1, 100) <= 75) this.m.Items.equip(::new("scripts/items/weapons/militia_spear"));
					else this.m.Items.equip(::new("scripts/items/weapons/boar_spear"));

					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_skirmisher")); //2 -> 3
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing")); //4
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_two_for_one")); //5
					if (!this.m.is_shield) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_a_better_grip")); //? -> 6
					this.m.Skills.add(::new("scripts/skills/perks/perk_close_combat_archer")); //7

					this.level_melee_skill(7, this.Math.rand(-6, 3) );
					this.level_melee_defense(7, this.Math.rand(-6, 3) );
					this.level_resolve(4, this.Math.rand(-6, 3) );
					this.level_health(3, this.Math.rand(-6, 3) );
					break;
				case 12: //Handaxe
				case 9:
				case 8:
					this.m.Items.equip(::new("scripts/items/weapons/hand_axe"));
					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft")); //2
					if (!this.m.is_shield) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_dismemberment")); //3
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_axe")); //4
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2 -> 5
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_cull")); //7
					break;
			}
		}



		// local roll = this.Math.rand(1.0, 100.0);
		// if (roll <= 15.0)
		// {
		// 	if (roll <= 3.0) this.add_potion("ghoul", true);
		// 	else if (roll <= 6.0) this.add_potion("ghoul", false);
		// 	else if (roll <= 9.0) this.add_potion("orc", true);
		// 	else if (roll <= 12.0) this.add_potion("orc", false);
		// 	else this.add_potion("unhold", true);
		// }


		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel"));

		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_assured_conquest"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));

		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_hold_the_line"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_push_forward"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_primal_fear"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_exude_confidence"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_vengeful_spite"));

		// if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		// {
		// 	this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		// 	this.m.Skills.add(::new("scripts/skills/perks/perk_legend_clarity"));



		this.m.Skills.update();
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

	o.makeMiniboss = function()
	{
		this.m.XP *= 1.5;
		this.m.IsMiniboss = true;
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
