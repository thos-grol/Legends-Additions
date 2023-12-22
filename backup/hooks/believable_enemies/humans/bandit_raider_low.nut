::mods_hookExactClass("entity/tactical/enemies/bandit_raider_low", function(o) {
	o.onInit = function()
	{
		this.bandit_raider.onInit();
		this.m.BaseProperties.MeleeSkill -= 10;
		this.m.BaseProperties.MeleeDefense -= 10;
		this.m.BaseProperties.RangedDefense -= 10;
		this.m.Skills.update();
	}

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
				"leather_lamellar"
			],
			[
				20,
				"patched_mail_shirt"
			]
		]);
		this.m.Items.equip(item);

		if (::Math.rand(1, 100) <= 75)
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

		if (::Math.rand(1, 100) <= 25) //2h weapons
		{
			this.m.build_num = ::Math.rand(0, 6);
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
					this.level_melee_skill(7, ::Math.rand(-6, 3) );
					this.level_melee_defense(7, ::Math.rand(-6, 3) );
					this.level_resolve(4, ::Math.rand(-6, 3) );
					this.level_health(3, ::Math.rand(-6, 3) );
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

					this.level_melee_skill(7, ::Math.rand(-6, 3) );
					this.level_melee_defense(4, 1);
					this.level_initiative(4, ::Math.rand(-6, 3) );
					this.level_health(6, ::Math.rand(-6, 3) );
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

					this.level_melee_skill(7, ::Math.rand(-6, 3) );
					this.level_melee_defense(4, 1);
					this.level_initiative(4, ::Math.rand(-6, 3) );
					this.level_health(6, ::Math.rand(-6, 3) );
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


					this.level_melee_skill(7, ::Math.rand(-6, 3) );
					this.level_melee_defense(7, ::Math.rand(-6, 3) );
					this.level_resolve(4, ::Math.rand(-6, 3) );
					this.level_health(3, ::Math.rand(-6, 3) );

					break;
			}
		}
		else //1h weapons
		{
			this.m.build_num = ::Math.rand(7, 12);

			if (this.m.build_num > 9)
			{
				if (::Math.rand(1, 100) <= 50)
				{
					if (::Math.rand(1, 100) <= 75) this.m.Items.equip(::new("scripts/items/shields/wooden_shield"));
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

					this.level_melee_defense(7, ::Math.rand(-3, 3) );
					this.level_resolve(7, ::Math.rand(-2, 3) );
					this.level_fatigue(3, ::Math.rand(-6, 3) );
					this.level_health(4, ::Math.rand(-6, 3) );

					break;
				case 8: //Spear
				case 10:
				case 11: //Thrower
					switch(::Math.rand(1, 3))
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

					if (::Math.rand(1, 100) <= 75) this.m.Items.equip(::new("scripts/items/weapons/militia_spear"));
					else this.m.Items.equip(::new("scripts/items/weapons/boar_spear"));

					this.m.Skills.removeByID("perk.legend_balance");
					this.m.Skills.add(::new("scripts/skills/perks/perk_colossus")); //1
					//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_skirmisher")); //2 -> 3
					this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_throwing")); //4
					this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_two_for_one")); //5
					if (!this.m.is_shield) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_a_better_grip")); //? -> 6
					this.m.Skills.add(::new("scripts/skills/perks/perk_close_combat_archer")); //7

					this.level_melee_skill(7, ::Math.rand(-6, 3) );
					this.level_melee_defense(7, ::Math.rand(-6, 3) );
					this.level_resolve(4, ::Math.rand(-6, 3) );
					this.level_health(3, ::Math.rand(-6, 3) );
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

		this.m.Skills.update();
	}
});
