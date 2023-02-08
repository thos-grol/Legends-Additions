::mods_hookExactClass("entity/tactical/enemies/bandit_raider_wolf", function(o) {
	o.create = function()
	{
		this.bandit_raider.create();
		this.m.Name = "Bandit Wolf Raider";
	}

	o.onInit = function()
	{
		this.bandit_raider.onInit();
		if (this.Math.rand(1, 100) <= 45) this.add_potion("direwolf", false);

	}

	local assignRandomEquipment = o.assignRandomEquipment;
	o.assignRandomEquipment = function()
	{
		local item = ::Const.World.Common.pickArmor([
			[
				20,
				"ragged_surcoat"
			],
			[
				20,
				"padded_leather"
			],
			[
				20,
				"worn_mail_shirt"
			],
			[
				20,
				"patched_mail_shirt"
			],
			[
				20,
				"leather_lamellar"
			],
			[
				20,
				"basic_mail_shirt"
			]
		]);
		item.setUpgrade(::new("scripts/items/" + (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue() ? "legend_armor/armor_upgrades/legend_direwolf_pelt_upgrade" : "armor_upgrades/direwolf_pelt_upgrade")));
		this.m.Items.equip(item);

		if (this.Math.rand(1, 100) <= 75)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					1,
					"nasal_helmet"
				],
				[
					1,
					"dented_nasal_helmet"
				],
				[
					1,
					"rusty_mail_coif"
				],
				[
					1,
					"headscarf"
				],
				[
					1,
					"nasal_helmet_with_rusty_mail"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}

		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully")); //tribal perk

		//add medium armor perks
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_balance")); //3
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6

		if (this.Math.rand(1, 100) <= 25) //2h weapons
		{
			this.m.build_num = this.Math.rand(0, 6);
			switch(this.m.build_num)
			{
				case 0: //Infantry axe - 4ap chop, split man, and smashing shields (6ap)
					this.m.Items.equip(::new("scripts/items/weapons/legend_infantry_axe"));

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
				case 1: //long axe has 2 range attack, and split shield
					this.m.Items.equip(::new("scripts/items/weapons/longaxe"));

					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.add(::new("scripts/skills/perks/perk_legend_smashing_shields")); //1
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_leverage")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft")); //2 -> 3
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_axe")); //4
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2 -> 5
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_cull")); //7

					this.level_melee_skill(7, this.Math.rand(-6, 3) );
					this.level_melee_defense(7, this.Math.rand(-6, 3) );
					this.level_initiative(4, this.Math.rand(-6, 3) );
					this.level_health(3, this.Math.rand(-6, 3) );
					break;
				case 2: //polearm - Pike
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
				case 4: //Flail
					local weapons = [
						"weapons/two_handed_wooden_flail",
						"weapons/legend_ranged_flail",
						"weapons/legend_reinforced_flail"
					];
					this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(weapons)));

					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.add(::new("scripts/skills/perks/perk_legend_alert")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_small_target")); //3
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_flail")); //4
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_formidable_approach")); //3 -> 5
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_flail_spinner")); //7

					this.level_melee_skill(7, this.Math.rand(-6, 3) );
					this.level_melee_defense(7, this.Math.rand(-6, 3) );
					this.level_resolve(4, this.Math.rand(-6, 3) );
					this.level_health(3, this.Math.rand(-6, 3) );
					break;
				case 5: //Hammer
					this.m.Items.equip(::new("scripts/items/weapons/two_handed_wooden_hammer"));

					this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_balance")); //3
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_internal_hemorrhage")); //3->4
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_dismantle")); //5
					//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_dent_armor")); //7

					this.level_melee_skill(7, this.Math.rand(-6, 3) );
					this.level_melee_defense(7, this.Math.rand(-6, 3) );
					this.level_resolve(4, this.Math.rand(-6, 3) );
					this.level_health(3, this.Math.rand(-6, 3) );
					break;
				case 6: //2h Mace
					local weapons = [
						"weapons/legend_two_handed_club",
						"weapons/two_handed_mace"
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
					if (this.Math.rand(1, 100) <= 50) this.m.Items.equip(::new("scripts/items/shields/wooden_shield"));
					else this.m.Items.equip(::new("scripts/items/shields/legend_tower_shield"));

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
					this.m.Items.equip(::new("scripts/items/weapons/boar_spear"));

					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_through_the_gaps")); //3
					this.m.Skills.add(::new("scripts/skills/perks/perk_nine_lives")); //1 -> 4
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_two_for_one")); //5
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_a_better_grip")); //? -> 6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_king_of_all_weapons")); //7

					this.level_melee_skill(4, this.Math.rand(-6, 3) );
					this.level_melee_defense(7, this.Math.rand(-1, 3) );
					this.level_resolve(4, this.Math.rand(-1, 3) );
					this.level_health(6, this.Math.rand(-6, 3) );
					break;

				case 9: //Net and mace
					this.m.Items.equip(::new("scripts/items/weapons/morning_star"));
					if (this.Math.rand(1, 100) <= 75) this.m.Items.equip(::new("scripts/items/tools/throwing_net"));
					else this.m.Items.equip(::new("scripts/items/tools/reinforced_throwing_net"));

					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.removeByID("perk.legend_lithe");

					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_push_it")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_legend_net_repair")); //2 -> 3
					this.m.Skills.add(::new("scripts/skills/perks/perk_legend_mastery_nets")); //4
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_mace")); //4 -> 5
					this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm")); //6
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bone_breaker")); //7

					this.level_melee_skill(7, this.Math.rand(-6, 3) );
					this.level_melee_defense(7, this.Math.rand(-6, 3) );
					this.level_initiative(7, this.Math.rand(-1, 3) );

					break;
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

		this.m.Skills.update();
	}
});
