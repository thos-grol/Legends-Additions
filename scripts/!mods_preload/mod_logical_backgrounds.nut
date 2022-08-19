local gt = this.getroottable();
gt.logical_backgrounds <- {};

::mods_registerMod("mod_logical_backgrounds", 1.00, "Logical Backgrounds");
::mods_queue("mod_logical_backgrounds", "mod_legends, >mod_legends_PTR", function()
{
	::mods_hookExactClass("skills/backgrounds/character_background", function (o)
	{
		local Convert = ::mods_getMember(o, "Convert");
		o.Convert = function()
		{
			Convert();
			local actor = this.getContainer().getActor();
			actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_cult_hood"));
			actor.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_cult_armor"));
		}
	});

	::mods_hookExactClass("skills/backgrounds/slave_barbarian_background", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.Name = "Indebted Barbarian";
		}
	});

	::mods_hookExactClass("entity/tactical/player", function (o)
	{
		local onHired = ::mods_getMember(o, "onHired");
		o.onHired = function()
		{
			onHired();
			local background_name = this.getBackground().getNameOnly();
			
			//traits
			switch(background_name)
			{
				case "Apprentice":
				case "Caravan Hand":
				case "Daytaler":
				case "Washerwoman":
				case "Farmhand":
				case "Milkmaid":
				case "Milkman":
				case "Fisherman":
				case "Mason":
				case "Messenger":
				case "Mason":
				case "Miller":
				case "Baker":
				case "Shepherd":
				case "Shieldmaiden":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_fruits_of_labor"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_hale_and_hearty"));
					break;

				case "Beggar":
				case "Widow":
				case "Refugee":
				case "Cripple":
				case "Indebted":
				case "Indebted Barbarian":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_promised_potential"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_punching_bag"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_trauma_survivor"));
					break;
				
				case "Monk":
				case "Dervish":
				case "Nun":
				case "Crusader":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_true_believer"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_prayer_of_faith"));
					break;
				
				case "Thief":
				case "Pickpocket":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_alert"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_dodge"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_quick_hands"));
					break;
				case "Peddler":
				case "Trader":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_barter_convincing"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_legend_barter_trustworthy"));
					break;

				case "Troubadour":
				case "Minstrel":
				case "Qiyan":
				case "Juggler":
				case "Belly Dancer":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_always_an_entertainer"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_paint_a_smile"));
					break;

				case "Manhunter":
				case "Raider":
				case "Nomad":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_menacing"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_bully"));
					break;
				
				case "Brawler":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_vigorous_assault"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_unstoppable"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_steel_brow"));
					break;
				
				case "Adventurous Noble":
				case "Adventurous Lady":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_family_ties"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_family_pride"));
					break;

				case "Master Archer":
				case "Ranger":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_target_practice"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_ranged_supremacy"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_arrow_to_the_knee"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_mastery_bow"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_eyes_up"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_flaming_arrows"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_hip_shooter"));
					break;

				case "Orc Slayer":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_ork"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_smackdown"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_rattle"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_deep_impact"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_mastery_hammer"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_dismantle"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_internal_hemorrhage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_dent_armor"));
					break;

				case "Cultist":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_ninetails_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_cult_hood"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_ninetails_damage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_cult_armor"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_lacerate"));
					break;

				case "Militia":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_militia_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_militia_damage"));
					break;

				case "Deserter":
				case "Sellsword":
				case "Oathtaker":
            		this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_professional"));
					break;
				case "Gladiator":
				case "Crusader":
				case "Retired Soldier":
				case "Hedge Knight":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_pattern_recognition"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_professional"));
					break;

				case "Swordmaster":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_versatile_weapon"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_exploit_opening"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_fluid_weapon"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_mastery_sword"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_tempo"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_kata"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_en_garde"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_swordmaster"));
					break;


			}

			//profession skills
			switch(background_name)
			{
				case "Oathtaker":
				case "Retired Soldier":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_vigilant"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_underdog"));
					break;
				case "Militia":
				case "Deserter":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
					break;
				case "Assassin":
				case "Hashassin":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_knife_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_knife_damage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_hidden"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_assassinate"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_legend_twirl"));
					break;

				case "Poacher":
				case "Muladí":
				case "Hunter":
				case "Nomad":
				case "Ranger":
				case "Master Archer":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_shortbow_skill"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_shortbow_damage"));
					break;

				case "Butcher":
				case "Fishmonger":
				case "Cannibal":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_damage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_slaughter"));
					break;
				case "Blacksmith":
				case "Ironmonger":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_damage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_sundering_strikes"));
					break;
				
				case "Caravan Hand":
					this.getSkills().add(this.new("scripts/skills/perks/perk_bags_and_belts"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_efficient_packing"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_skillful_stacking"));
					break;
				case "Farmhand":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_skill"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
					break;
				case "Fisherman":
				case "Ratcatcher":
				case "Manhunter":
				case "Gladiator":
				case "Beast Slayer":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_net_repair"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_net_casting"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_mastery_nets"));
					break;
				case "Gravedigger":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_shovel_skill"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_shovel_damage"));
					break;
				case "Lumberjack":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_woodaxe_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_woodaxe_damage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_woodworking"));
					break;
				case "Miner":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_pickaxe_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_pickaxe_damage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_sundering_strikes"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_tunnel_vision"));
					break;

				case "Indebted Barbarian":
				case "Barbarian":
				case "Wildman":
				case "Wildwoman":
				case "Shieldmaiden":
					this.getSkills().add(this.new("scripts/skills/perks/perk_pathfinder"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_savage_strength"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_bestial_vigor"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_feral_rage"));
					break;

				case "Historian":
				case "Inventor":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_scholar"));
           			this.getSkills().add(this.new("scripts/skills/perks/perk_legend_scroll_ingredients"));
					break;

				case "Troubadour":
				case "Minstrel":
				case "Qiyan":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_lute_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_daze"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_lute_damage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_entice"));
					break;
				case "Belly Dancer":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_entice"));
					break;
				case "Juggler":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_hair_splitter"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_leap"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_rotation"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_twirl"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_footwork"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_backflip"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_tumble"));
					break;
				case "Anatomist":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_med_ingredients"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_mastery_bandage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_field_triage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_potion_brewer"));
					break;
				case "Alchemist":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_sickle_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_sickle_damage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_gatherer"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_herbcraft"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_potion_brewer"));
					break;
				case "Herbalist / Apothecaries":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_sickle_skill"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_specialist_sickle_damage"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_gatherer"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_herbcraft"));
					break;
				case "Witchhunter":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_take_aim"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_entrenched"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_power_shot"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_mastery_crossbow"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_hexen"));
					
					break;
			}

			//extra
			switch(background_name)
			{
				case "Messenger":
				case "Vagabond":
				case "Poacher":
				case "Hunter":
				case "Nomad":
				case "Ranger":
				case "Master Archer":
					this.getSkills().add(this.new("scripts/skills/perks/perk_lookout"));
					break;

				case "Houndmaster":
				case "Muladí":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_dogwhisperer"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_dogbreeder"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_doghandling"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_packleader"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_dogmaster"));
					break;

				case "Cannibal":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_meal_preperation"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_camp_cook"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_bandit"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_caravan"));
					break;

				case "Blacksmith":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_personal_armor"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_tools_drawers"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_tools_spares"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_field_repairs"));
					break;

				case "Indebted Barbarian":
				case "Barbarian":
				case "Raider":
				case "Nomad":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_caravan"));
					break;
				
				case "Inventor":
					this.getSkills().add(this.new("scripts/skills/perks/legend_inventor_anatomy"));
					break;

				case "Beast Slayer":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_big_game_hunter"));
					local r = this.Math.rand(1, 3);
					if (r == 1)
					{
						this.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_ghoul"));
					}
					else if (r == 2)
					{
						this.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_direwolf"));
					}
					else
					{
						this.getSkills().add(this.new("scripts/skills/perks/perk_legend_favoured_enemy_spider"));
					}
					break;
				
				case "Shieldmaiden":
					this.getSkills().add(this.new("scripts/skills/perks/perk_str_phalanx"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_str_cover_ally"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_shield_expert"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_str_line_breaker"));
					break;

				case "Vala":
					this.getSkills().add(this.new("scripts/skills/perks/legend_vala_warden"));
					this.getSkills().add(this.new("scripts/skills/perks/legend_vala_premonition"));
					this.getSkills().add(this.new("scripts/skills/perks/legend_vala_threads"));
					this.getSkills().add(this.new("scripts/skills/perks/legend_vala_spiritual_bond"));
					this.getSkills().add(this.new("scripts/skills/perks/legend_vala_inscribe_weapon"));
					this.getSkills().add(this.new("scripts/skills/perks/legend_vala_inscribe_helmet"));
					this.getSkills().add(this.new("scripts/skills/perks/legend_vala_inscribe_armor"));
					this.getSkills().add(this.new("scripts/skills/perks/legend_vala_inscribe_shield"));
					this.getSkills().add(this.new("scripts/skills/perks/legend_vala_inscription_mastery"));
					break;
			}

			//light armor
			switch(background_name)
			{
				case "Assassin":
				case "Hashassin":
				case "Ranger":
				case "Gladiator":
				case "Swordmaster":
					this.getSkills().add(this.new("scripts/skills/perks/perk_dodge"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_relentless"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_freedom_of_movement"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_nimble"));
					break
				case "Master Archer":
				case "Militia":
					this.getSkills().add(this.new("scripts/skills/perks/perk_dodge"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_nimble"));
					break
				case "Sellsword":
				case "Hedge Knight":
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_menacing"));
            		this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_bully"));
					break;
			}

			//med armor
			switch(background_name)
			{
				case "Retired Soldier":
				case "Gladiator":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_balance"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_perfect_fit"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_lithe"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_in_the_zone"));
					break;
				case "Sellsword":
				case "Raider":
				case "Nomad":
				case "Deserter":
				case "Militia":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_balance"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_lithe"));
					break;
				case "Ranger":
					this.getSkills().add(this.new("scripts/skills/perks/perk_legend_summon_falcon"));
					break;
			}

			//heavy armor
			switch(background_name)
			{
				case "Raider":
				case "Nomad":
				case "Shieldmaiden":
				case "Orc Slayer":
				case "Hedge Knight":
				case "Sellsword":
				case "Deserter":
				case "Oathtaker":
				case "Crusader":
				case "Retired Soldier":
					this.getSkills().add(this.new("scripts/skills/perks/perk_brawny"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_ptr_bulwark"));
					this.getSkills().add(this.new("scripts/skills/perks/perk_battle_forged"));
					break;
			}

		}
	});
});
