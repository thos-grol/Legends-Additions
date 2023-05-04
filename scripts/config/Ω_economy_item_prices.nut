//FEATURE_2: this.World.Assets.addMoney
	//overhaul contract pay
	//event pay/prices

//FEATURE_8: overhaul enemy equipment/builds

// 12 Pence (d) = 1 Shilling (s)
// 20 Shilling = 1 pound £

// Horse harness maker: 4 Pence / Day
// Mason: 6 Pence / Day
// Laborer: 3,5 Pence / Day

//levied spearmen 2 Pence / Day
//!!!! pay of soldiers includes food and looting

// Levied spearman: 2 Pence / Day
// Archer: 3 Pence / Day
// Squire: 12 d
// Knight bachelor: 24 p / Day
// Knight banneret: 48 p / Day

// 4 gallons of ale: 1d
// 1 hen: 5d
// Brass pot: 2-13s
// 1 cart-horse: Up to 32 Shillings

//bros will eat 2.0 (DailyFood) units per day
//food unit is 25 so it will last 12 meals
//base unit is d

::Z.Economy.Items <- {
//SUPPLIES
	"supplies.ammo_small" : 30,
	"supplies.ammo" : 60,
	"supplies.armor_parts_small" : 60,
	"supplies.medicine_small" : 60,
	"supplies.armor_parts" : 120,
	"supplies.medicine" : 120,

	//FOOD
	"supplies.ground_grains" : 5, //unit of 15 servings
	"supplies.rice" : 7, //unit of 20
	"supplies.bread" : 10, //unit of 20 loafs
	"supplies.legend_fresh_fruit" : 11, //unit of 15
	"supplies.roots_and_berries" : 11, //unit of 15
	"supplies.dates" : 22, //unit of 20
	"supplies.dried_fruits" : 32, //unit of 30

	//MEAT
	"supplies.strange_meat" : 15, //unit of 15
	"supplies.legend_fresh_meat" : 15, //unit of 15
	"supplies.dried_fish" : 40, //unit of 20
	"supplies.smoked_ham" : 60, //unit of 30
	"supplies.dried_lamb" : 90, //unit of 30
	
	//ALCOHOL
	"supplies.beer" : 9, //35 units
	"supplies.mead" : 13, //25 units
	"supplies.preserved_mead" : 17, //20 units
	"supplies.wine" : 27, //35 units

	//REMOVED
	"supplies.cured_venison" : 0,
	"supplies.goat_cheese" : 0, //FEATURE_1: Remove
	"supplies.legend_human_parts" : 0, //FEATURE_1: Remove skill
	"supplies.fermented_unhold_heart" : 0,
	"supplies.legend_yummy_sausages" : 0,
	"supplies.black_marsh_stew" : 0, //FEATURE_1: Remove from hexe drops

	"supplies.legend_porridge" : 0, //FEATURE_1: Remove from a lot of places
	"supplies.legend_pudding" : 0, //FEATURE_1: Remove
	"supplies.legend_pie" : 0, //FEATURE_1: Remove
	"supplies.cured_rations" : 0, //FEATURE_1: Remove
	"supplies.legend_cooking_spices" : 0,// FEATURE_1: Remove
	"supplies.pickled_mushrooms" : 0,// FEATURE_1: Remove

//TRADE
	
	"misc.peat_bricks" : 34,
	"misc.dies" : 59,
	
	"misc.amber_shards" : 87,
	"misc.spices" : 107,
	"misc.salt" : 114,
	"misc.incense" : 127,
	
	"misc.cloth_rolls" : 46,
	"misc.furs" : 100,
	"misc.silk" : 154,

	"misc.legend_raw_wood" : 18, //6 units
	"misc.quality_wood" : 60, //6 units

	"misc.iron_ingots" : 200, //5 13 pound ingots
	"misc.copper_ingots" : 300,
	"misc.tin_ingots" : 300,

	//FEATURE_7: make silver ingot item
	"misc.gold_ingots" : 6400, //FEATURE_7: redo item to be 1 ingot
	//FEATURE_7: add gemstones
	"misc.uncut_gems" : 840, //6 units of uncut emeralds
	"misc.gemstones" : 1400, //2 units of cut emeralds //FEATURE_1: Change to trade item
	
	//Removed
	"misc.legend_cooking_spices" : 0, //FEATURE_1: Remove

//TENTS
	"tent.scrap_tent" : 200,
	"tent.fletcher_tent" : 200,
	"tent.gather_tent" : 200,
	"tent.hunter_tent" : 200,
	"tent.scout_tent" : 200,
	"tent.healer_tent" : 200,
	"tent.repair_tent" : 200,
	"tent.craft_tent" : 200, //FEATURE_8: disable + disable crafting in party
	"tent.training_tent" : 500,
	"tent.enchant_tent" : 1000,

//SPAWNS
	"spawns.skeleton" : 0,
	"spawns.zombie" : 0,
	"spawns.donkey" : 0, //FEATURE_1: Remove
	"spawns.cart_01" : 260,
	"spawns.cart_02" : 400,

//LOOT //TODO: Loot prices and removal
	"misc.bone_figurines" : 180,
	"misc.webbed_valuables" : 180,
	"misc.goblin_carved_ivory_iconographs" : 200,
	"misc.growth_pearls" : 200,
	"misc.rainbow_scale" : 200,
	"misc.signet_ring" : 245,
	"misc.bead_necklace" : 250,
	"misc.sabertooth" : 250,
	"misc.goblin_minted_coins" : 300,
	"misc.soul_splinter" : 300,
	"misc.silverware" : 350,
	"misc.valuable_furs" : 350,
	"misc.goblin_rank_insignia" : 400,
	"misc.jade_broche" : 400,
	"misc.deformed_valuables" : 450,
	"misc.looted_valuables" : 450,
	"misc.silver_bowl" : 490,
	"misc.ancient_amber" : 500,
	"misc.glittering_rock" : 500,
	"misc.ornate_tome" : 595,
	"misc.legend_bear_fur" : 700,
	"misc.white_pearls" : 770,
	"misc.ancient_gold_coins" : 875,
	"misc.golden_chalice" : 980,
	
	"misc.lindwurm_hoard" : 0, //FEATURE_1: Remove
	"misc.jeweled_crown" : 0, //FEATURE_1: Remove

//MISC //TODO: Misc prices
	"misc.legend_scroll" : 0,
	"misc.manhunters_ledger" : 0,
	"misc.ancient_scroll" : 50,
	"misc.legend_mistletoe" : 50,
	"misc.legend_wolfsbane" : 50,
	"misc.legend_werehand" : 100,
	"misc.paint_remover" : 150,
	"misc.paint_black" : 160,
	"misc.ghoul_brain" : 200,
	"misc.ghoul_teeth" : 200,
	"misc.wardog_armor_upgrade" : 200,
	"misc.poison_gland" : 250,
	"misc.paint_red" : 270,
	"misc.serpent_skin" : 350,
	"misc.spider_silk" : 350,
	"misc.ghoul_horn" : 375,
	"misc.paint_orange_red" : 380,
	"misc.adrenaline_gland" : 400,
	"misc.happy_powder" : 400,
	"misc.wardog_heavy_armor_upgrade" : 400,
	"misc.glistening_scales" : 450,
	"misc.miracle_drug" : 450,
	"misc.acidic_saliva" : 500,
	"misc.hyena_fur" : 500,
	"misc.legend_banshee_essence" : 500,
	"misc.legend_demon_hound_bones" : 500,
	"misc.werewolf_pelt" : 500,
	"misc.paint_white_green_yellow" : 520,
	"misc.parched_skin" : 625,
	"misc.paint_white_blue" : 645,
	"misc.snake_oil" : 650,
	"misc.petrified_scream" : 750,
	"misc.potion_of_knowledge" : 750,
	"misc.third_eye" : 750,
	"misc.paint_set_shields" : 760,
	"misc.unhold_hide" : 1000,
	"misc.vampire_dust" : 1000,
	"misc.unhold_bones" : 1125,
	"misc.unhold_heart" : 1125,
	"misc.poisoned_apple" : 1250,
	"misc.frost_unhold_fur" : 1500,
	"misc.mysterious_herbs" : 1650,
	"misc.legend_skin_ghoul_skin" : 2000,
	"misc.lindwurm_blood" : 2000,
	"misc.sulfurous_rock" : 2000,
	"misc.witch_hair" : 2000,
	"misc.lindwurm_bones" : 2200,
	"misc.glowing_resin" : 2500,
	"misc.legend_redback_poison_gland" : 2500,
	"misc.legend_white_wolf_pelt" : 2500,
	"misc.potion_of_oblivion" : 2500,
	"misc.ancient_wood" : 2900,
	"misc.legend_demon_alp_skin" : 3000,
	"misc.lindwurm_scales" : 3000,
	"misc.heart_of_the_forest" : 3250,
	"misc.legend_rock_unhold_hide" : 3500,
	"misc.kraken_horn_plate" : 4000,
	"misc.kraken_tentacle" : 4000,
	"misc.legend_rock_unhold_bones" : 4000,
	"misc.legend_stollwurm_blood" : 4000,
	"misc.legend_witch_leader_hair" : 5000,
	"misc.legend_ancient_green_wood" : 5800,
	"misc.legend_stollwurm_scales" : 6000,
	"misc.legend_demon_third_eye" : 7500,

//SPECIAL //TODO: Special prices
	"misc.black_book" : 1000,
	"misc.broken_ritual_armor" : 1000,
	"misc.bodily_reward" : 2500,
	"misc.legendary_sword_blade" : 2500,
	"misc.legendary_sword_grip" : 2500,
	"misc.spiritual_reward" : 2500,
	"misc.golden_goose" : 3000,
	"misc.trade_jug" : 10000,

//RUNE_SIGILS //TODO: Rune prices
	"token.legend_vala_inscription" : 1200,

//TOOLS //TODO: Tools prices
	"tool.legend_broken_throwing_net" : 0, //FEATURE_5: Remove
	"tool.throwing_net" : 50, //FEATURE_5: refillable with tools
	"tool.reinforced_throwing_net" : 150, //FEATURE_5: refillable with tools
	"weapon.holy Water" : 100, //FEATURE_5: refillable with priest
	"weapon.acid_flask" : 400, //FEATURE_5: refillable with alchemist
	"weapon.smoke_bomb" : 400, //FEATURE_5: refillable with alchemist
	"weapon.daze_bomb" : 500, //FEATURE_5: refillable with alchemist
	"weapon.fire_bomb" : 600, //FEATURE_5: refillable with alchemist
	"accessory.berserker_mushrooms" : 100,
	"accessory.legend_apothecary_mushrooms" : 100,
	"accessory.poison" : 100,
	"accessory.antidote" : 150, //FEATURE_5: refillable with alchemist
	"accessory.spider_poison" : 150, //FEATURE_5: refillable with alchemist, rename to poison
	"accessory.iron_will_potion" : 300, //FEATURE_5: refillable with alchemist
	"accessory.lionheart_potion" : 300, //FEATURE_5: refillable with alchemist
	"accessory.night_vision_elixir" : 350, //FEATURE_5: refillable with alchemist
	"accessory.recovery_potion" : 350, //FEATURE_5: refillable with alchemist
	"accessory.therianthropy_potion" : 500, //TODO: remove
	"accessory.legend_heartwood_sap_flask" : 3500,
	"accessory.legend_skin_ghoul_blood_flask" : 3500,
	"accessory.legend_stollwurm_blood_flask" : 3500,
	"accessory.legend_hexen_ichor_potion" : 7000,

//AMMO //TODO: ammo prices
	"ammo.arrows" : 30,
	"ammo.bolts" : 30,
	"ammo.legend_darts" : 30,
	"ammo.powder" : 80, //FEATURE_5: refillable with alchemist

//ACCESSORY //TODO: ACCESSORY prices
	"accessory.oathtaker_skull_01" : 0,
	"accessory.oathtaker_skull_02" : 0,
	"accessory.bandage" : 25,
	"accessory.legend_pack_small" : 100,
	"accessory.sergeant_badge" : 250,
	"accessory.legend_pack_large" : 1000,
	"accessory.legend_catapult" : 10000,

	//TROPHY
	"accessory.ghoul_trophy" : 250,
	"accessory.alp_trophy" : 400,
	"accessory.goblin_trophy" : 500,
	"accessory.orc_trophy" : 500,
	"accessory.undead_trophy" : 500,
	"accessory.hexen_trophy" : 550,
	"accessory.legend_demon_banshee_trophy" : 1000,
	"accessory.legend_demonalp_trophy" : 2500,
	"accessory.legend_hexen_leader_trophy" : 2500,

	//PET
	"accessory.legend_cat_item" : 100,
	"accessory.legend_wolfsbane_necklace" : 100,
	"accessory.wardog" : 200,
	"accessory.warhound" : 250,
	"accessory.cat_potion" : 350,
	"accessory.armored_wardog" : 400,
	"accessory.armored_warhound" : 450,
	"accessory.heavily_armored_wardog" : 600,
	"accessory.warwolf" : 600,
	"accessory.heavily_armored_warhound" : 750,
	"accessory.falcon" : 800,
	"accessory.legend_warbear" : 2000,
	"accessory.legend_white_warwolf" : 6000,

	//LEGENDARY
	"accessory.cursed_crystal_skull" : 250,

	//SPECIAL
	"accessory.arena_collar" : 0,
	"accessory.legend_arena_collar" : 0,
	"accessory.slayer_necklace" : 100,
	"accessory.legend_oms_fate" : 1100,
	"accessory.legend_oms_rib" : 1350,
	"accessory.legend_oms_tome" : 1725,
	"accessory.legend_oms_paw" : 2345,
	"accessory.legend_oms_amphora" : 2450,

//WEAPONS //TODO: WEAPONS prices
	//SWORD
	//1H
	"weapon.sickle" : 45,
	"weapon.broken_ancient_sword" : 200,

	"weapon.shortsword" : 90,
	"weapon.goblin_notched_blade" : 350,
	"weapon.saif" : 350,
	"weapon.falchion" : 120,

	"weapon.ancient_sword" : 850,
	"weapon.goblin_falchion" : 900,
	"weapon.legend_gladius" : 950,
	"weapon.scimitar" : 1000,
	"weapon.legend_skin_flayer" : 1100,
	"weapon.arming_sword" : 1250,
	"weapon.legend_kopis" : 1250,
	"weapon.fencing_sword" : 1550,
	"weapon.named_goblin_falchion" : 2600,
	"weapon.shamshir" : 2900,
	"weapon.legend_estoc" : 3200,
	"weapon.noble_sword" : 3200,
	"weapon.legend_named_gladius" : 3200,
	"weapon.named_fencing_sword" : 4000,
	"weapon.named_shamshir" : 4000,
	"weapon.legend_named_estoc" : 4200,
	"weapon.named_sword" : 4200,
	"weapon.legend_named_sickle" : 4500,
	"weapon.lightbringer_sword" : 20000,
	//2H
	"weapon.rhomphaia" : 1300,
	"weapon.legend_man_mangler" : 1600,
	"weapon.warbrand" : 1700,
	"weapon.legend_longsword" : 2000,
	"weapon.named_longsword" : 2100,
	"weapon.longsword" : 2300,
	"weapon.legend_crusader_sword" : 2400,
	"weapon.greatsword" : 3200,
	"weapon.named_warbrand" : 4200,
	"weapon.legend_named_longsword" : 4600,
	"weapon.named_greatsword" : 4600,
	"weapon.named_royal_lance" : 4800,
	"weapon.legend_mage_swordstaff" : 7500,

	//AXE
	//2H
	"weapon.legend_hoe" : 55,
	"weapon.woodcutters_axe" : 450,
	"weapon.longaxe" : 1200,
	"weapon.orc_axe_2h" : 1500,
	"weapon.legend_infantry_axe" : 1950,
	"weapon.heavy_rusty_axe" : 2000,
	"weapon.bardiche" : 2200,
	"weapon.greataxe" : 2725,
	"weapon.legend_fan_axe" : 3000,
	"weapon.named_longaxe" : 3000,
	"weapon.named_heavy_rusty_axe" : 3400,
	"weapon.legend_named_infantry_axe" : 4600,
	"weapon.named_bardiche" : 4600,
	"weapon.named_greataxe" : 4600,
	"weapon.named_orc_axe_2h" : 5000,
	//1H
	"weapon.hatchet" : 210,
	"weapon.crude_axe" : 800,
	"weapon.legend_meat_hacker" : 900,
	"weapon.hand_axe" : 1000,
	"weapon.orc_axe" : 1100,
	"weapon.fighting_axe" : 2350,
	"weapon.named_orc_axe" : 2400,
	"weapon.named_axe" : 4000,

	//CLEAVER
	//1H
	"weapon.legend_cat_o_nine_tails" : 20,
	"weapon.legend_saw" : 45,
	"weapon.butchers_cleaver" : 110,
	"weapon.antler_cleaver" : 120,
	"weapon.falx" : 350,
	"weapon.thorned_whip" : 400,
	"weapon.battle_whip" : 450,
	"weapon.blunt_cleaver" : 600,
	"weapon.scramasax" : 700,
	"weapon.legend_bone_carver" : 900,
	"weapon.orc_cleaver" : 1100,
	"weapon.legend_named_butchers_cleaver" : 1100,
	"weapon.khopesh" : 1300,
	"weapon.legend_khopesh" : 1300,
	"weapon.named_battle_whip" : 2200,
	"weapon.named_orc_cleaver" : 2400,
	"weapon.military_cleaver" : 2500,
	"weapon.named_khopesh" : 3200,
	"weapon.named_cleaver" : 3800,
	//2H
	"weapon.legend_scythe" : 75,
	"weapon.legend_grisly_scythe" : 750,
	"weapon.rusty_warblade" : 1600,
	"weapon.legend_limb_lopper" : 1600,
	"weapon.crypt_cleaver" : 2000,
	"weapon.legend_great_khopesh" : 2000,
	"weapon.two_handed_saif" : 2400,
	"weapon.legend_voulge" : 2500,
	"weapon.two_handed_scimitar" : 2900,
	"weapon.legend_military_voulge" : 3200,
	"weapon.named_crypt_cleaver" : 3200,
	"weapon.named_rusty_warblade" : 3200,
	"weapon.named_two_handed_scimitar" : 3200,
	"weapon.legend_named_voulge" : 3500,
	"weapon.named_legend_great_khopesh" : 3500,

	//POLEARM
	//2H
	"weapon.legend_wooden_pitchfork" : 30,
	"weapon.pitchfork" : 150,
	"weapon.broken_bladed_pike" : 350,
	"weapon.bladed_pike" : 600,
	"weapon.hooked_blade" : 700,
	"weapon.warscythe" : 700,
	"weapon.spetum" : 750,
	"weapon.goblin_pike" : 800,
	"weapon.pike" : 900,
	"weapon.faction_banner" : 1000,
	"weapon.player_banner" : 1500,
	"weapon.swordlance" : 1600,
	"weapon.billhook" : 1875,
	"weapon.named_bladed_pikee" : 2200,
	"weapon.named_goblin_pike" : 2400,
	"weapon.legend_swordstaff" : 2750,
	"weapon.named_pike" : 2800,
	"weapon.named_spetum" : 2800,
	"weapon.named_warscythe" : 2800,
	"weapon.legend_halberd" : 2900,
	"weapon.named_billhook" : 3200,
	"weapon.named_swordlance" : 3200,
	"weapon.legend_named_halberd" : 3800,
	"weapon.legend_named_swordstaff" : 4800,

	//MACE
	//1H
	"weapon.wooden_stick" : 0, //TODO: Remove from shops
	"weapon.bludgeon" : 90,
	"weapon.claw_club" : 100,
	"weapon.nomad_mace" : 100,
	"weapon.orc_wooden_club" : 150,
	"weapon.orc_metal_club" : 300,
	"weapon.light_southern_mace" : 400,
	"weapon.morning_star" : 600,
	"weapon.goblin_staff" : 1000,
	"weapon.winged_mace" : 2100,
	"weapon.heavy_southern_mace" : 2100,
	"weapon.named_mace" : 4000,
	//2H
	"weapon.legend_shovel" : 50,
	"weapon.legend_two_handed_club" : 400,
	"weapon.two_handed_spiked_mace" : 900,
	"weapon.two_handed_mace" : 1000,
	"weapon.polemace" : 1500,
	"weapon.legend_bough" : 1600,
	"weapon.named_polemace" : 2600,
	"weapon.two_handed_flanged_mace" : 3000,
	"weapon.named_two_handed_spiked_mace" : 3000,
	"weapon.named_two_handed_mace" : 3400,
	"weapon.legend_named_shovel" : 4500,

	//SPEAR
	//1H
	"weapon.legend_wooden_spear" : 0, //TODO: Remove from shops
	"weapon.ancient_spear" : 150,
	"weapon.militia_spear" : 180,
	"weapon.legend_militia_glaive" : 350,
	"weapon.goblin_spear" : 500,
	"weapon.boar_spear" : 750,
	"weapon.firelance" : 750,
	"weapon.legend_glaive" : 1250,
	"weapon.fighting_spear" : 2100,
	"weapon.named_goblin_spear" : 2500,
	"weapon.legend_battle_glaive" : 3200,
	"weapon.named_spear" : 3200,
	"weapon.legend_named_glaive" : 6000,
	//2H
	"weapon.warfork" : 400,
	"weapon.goedendag" : 750,
	"weapon.legend_military_goedendag" : 2000,
	"weapon.legend_named_military_goedendag" : 5400,

	//DAGGER
	"weapon.legend_shiv" : 0, //TODO: Remove from shops
	"weapon.legend_wooden_stake" : 0, //TODO: Remove from shops
	"weapon.knife" : 30,
	"weapon.dagger" : 180,
	"shield.legend_parrying_dagger" : 500,
	"shield.legend_named_parrying_dagger" : 800,
	"weapon.rondel_dagger" : 400,
	"weapon.qatal_dagger" : 750,
	"weapon.legend_katar" : 1250,
	"weapon.named_dagger" : 1500,
	"weapon.named_qatal_dagger" : 3000,
	"weapon.legend_redback_dagger" : 3800,
	"weapon.obsidian_dagger" : 5000,

	//FLAIL
	//1H
	"weapon.wooden_flail" : 0, //TODO: Remove from shops
	"weapon.reinforced_wooden_flail" : 0, //TODO: Remove from shops
	"weapon.flail" : 1800,
	"weapon.three_headed_flail" : 2200,
	"weapon.named_flail" : 3400,
	"weapon.named_three_headed_flail" : 3400,
	//2H
	"weapon.legend_ranged_wooden_flail" : 40,
	"weapon.legend_chain" : 400,
	"weapon.two_handed_wooden_flail" : 500,
	"weapon.legend_reinforced_flail" : 1050,
	"weapon.orc_flail_2h" : 1300,
	"weapon.legend_pole_flail" : 2000,
	"weapon.named_orc_flail_2h" : 2100,
	"weapon.two_handed_flail" : 2800,
	"weapon.named_two_handed_flail" : 2800,
	"weapon.legend_named_flail" : 3000,

	//HAMMER
	//1H
	"weapon.legend_hammer" : 50,
	"weapon.pickaxe" : 120,
	"weapon.axehammer" : 800,
	"weapon.military_pick" : 900,
	"weapon.legend_skullsmasher" : 1200,
	"weapon.warhammer" : 2500,
	"weapon.named_warhammer" : 4200,
	"weapon.legend_named_blacksmith_hammer" : 5000,
	"weapon.legend_named_warhammer" : 5000,
	//2H
	"weapon.two_handed_wooden_hammer" : 500,
	"weapon.skull_hammer" : 1300,
	"weapon.polehammer" : 1600,
	"weapon.legend_skullbreaker" : 1600,
	"weapon.two_handed_hammer" : 3000,
	"weapon.named_polehammer" : 3200,
	"weapon.named_skullhammer" : 3200,
	"weapon.named_two_handed_hammer" : 4000,

	//STAFF
	//2H
	"weapon.legend_staff" : 50,
	"weapon.legend_tipstaff" : 100,
	"weapon.legend_mystic_staff" : 1000,
	"weapon.legend_staff_vala" : 1000,
	"weapon.legend_staff_gnarled" : 5000,

	//BOW
	"weapon.wonky_bow" : 0, //TODO: Remove from shops
	"weapon.short_bow" : 200,
	"weapon.goblin_bow" : 250,
	"weapon.composite_bow" : 400,
	"weapon.goblin_heavy_bow" : 500,
	"weapon.hunting_bow" : 600,
	"weapon.named_goblin_heavy_bow" : 2200,
	"weapon.war_bow" : 2900,
	"weapon.masterwork_bow" : 3500,
	"weapon.named_warbow" : 4600,

	//CROSSBOW //FEATURE_1: crossbows + bolts are restricted goods, can only rob from military/top tier bandits, reflect that in description of items
	"weapon.legend_blowgun" : 0,
	"weapon.light_crossbow" : 180,
	"weapon.crossbow" : 225,
	"weapon.heavy_crossbow" : 315,
	"weapon.goblin_crossbow" : 375, //FEATURE_1: description, superior goods
	"weapon.named_crossbow" : 473, //heavy crossbow variant, //FEATURE_1: named goblin crossbow
	
	//THROWING
	"weapon.orc_javelin" : 150,
	"weapon.javelin" : 200,
	"weapon.throwing_axe" : 200,
	"weapon.goblin_spiked_balls" : 200,
	"weapon.heavy_javelin" : 300,
	"weapon.heavy_throwing_axe" : 300,
	"weapon.throwing_spear" : 400,
	"weapon.named_javelin" : 1400,
	"weapon.named_throwing_axe" : 1400,

	//MUSICAL
	"weapon.lute" : 50,
	"weapon.legend_drum" : 100,
	"weapon.barbarian_drum" : 300,
	"weapon.named_lute" : 1000,

	//SLING
	//1H
	"weapon.legend_sling" : 150,
	//2H
	"weapon.legend_slingshot" : 100,
	"weapon.staff_sling" : 150,
	"weapon.nomad_sling" : 300,
	"weapon.legend_slingstaff" : 1000,

	//FIREARM
	//2H
	"weapon.handgonne" : 3000,
	"weapon.named_handgonne" : 5000,

//SHIELDS //TODO: SHIELDS prices
	"shield.buckler" : 45,
	"shield.wooden_shield_old" : 60,
	"shield.faction_wooden_shield" : 90,
	"shield.wooden_shield" : 100,
	"shield.worn_heater_shield" : 150,
	"shield.worn_kite_shield" : 150,
	"shield.faction_kite_shield" : 200,
	"shield.kite_shield" : 200,
	"shield.faction_heater_shield" : 250,
	"shield.heater_shield" : 250,
	"shield.legend_faction_tower_shield" : 1000,
	"shield.legend_tower_shield" : 1000,

	//ANCIENT
	"shield.auxiliary_shield" : 80,
	"shield.coffin_shield" : 100,
	"shield.legend_mummy_shield" : 200,
	"shield.tower_shield" : 200,
	"shield.legend_mummy_tower_shield" : 850,

	//BEASTS
	"shield.legend_greenwood_schrat" : 0,
	"shield.schrat" : 0,

	//GREENSKINS
	"shield.goblin_light_shield" : 45,
	"shield.orc_light_shield" : 50,
	"shield.goblin_heavy_shield" : 65,
	"shield.orc_heavy_shield" : 250,

	//LEGENDARY
	"shield.gilders_embrace" : 20000,

	//ORIENTAL
	"shield.southern_light_shield" : 100,
	"shield.metal_round_shield" : 250,

	//SPECIAL
	"shield.craftable_lindwurm" : 800,
	"shield.craftable_schrat" : 1000,
	"shield.craftable_kraken" : 1200,
	"shield.legend_craftable_greenwood_schrat" : 7000,

	//NAMED
	"shield.named_orc_heavy_shield" : 500,
	"shield.named_bandit_heater" : 600,
	"shield.named_undead_heater_shield" : 600,
	"shield.named_bandit_kite_shield" : 700,
	"shield.named_undead_kite_shield" : 700,
	"shield.named_dragon" : 800,
	"shield.named_red_white" : 800,
	"shield.named_rider_on_horse" : 1000,
	"shield.named_wing" : 1000,
	"shield.named_lindwurm" : 1300,
	"shield.named_full_metal_heater" : 1500,
	"shield.named_golden_round" : 1500,
	"shield.named_sipar_shield" : 1500,

//LEGEND_ARMOR //TODO: LEGEND_ARMOR prices

	//ARMOR
	"legend_armor.body.legend_rabble_fur" : 5,
	"legend_armor.body.legend_vala_dress" : 80,
	"legend_armor.body.legend_vala_cloak" : 120,
	"legend_armor.body.legend_seer_robes" : 200,
	"legend_armor.body.legend_armor_warlock_cloak" : 200,
	"legend_armor.body.cultist_leather_robe" : 240,
	"legend_armor.body.legend_ranger_armor" : 500,
	"legend_armor.body.legend_werewolf_hide" : 500,
	"legend.armor.body.gambeson_rare_color.cloth" : 850,
	"legend_armor.body.legend_armor_crusader" : 1000,
	"legend_armor_upgrade.legend_redback_cloak" : 7500,
	"legend_armor_upgrade.legend_hexe_leader_cloak" : 12000,

	//CLOTH
	"legend_armor.body.legend_sackcloth_tattered" : 0, //FEATURE_1: remove from shops
	"legend_armor.body.legend_sackcloth" : 0, //FEATURE_1: remove from shops

	"legend_armor.body.legend_ancient_cloth" : 24,
	"legend_armor.body.legend_ancient_cloth_restored" : 24,
	"legend_armor.body.legend_peasant_dress" : 24,
	"legend_armor.body.legend_robes" : 24,
	"legend_armor.body.legend_robes_nun" : 24,
	"legend_armor.body.legend_sackcloth_patched" : 24,
	"legend_armor.body.legend_tunic" : 24,
	"legend_armor.body.legend_southern_tunic" : 24, //FEATURE_1: set to 25 armor
	"legend_armor.body.legend_tunic_collar_deep" : 24,
	"legend_armor.body.legend_tunic_collar_thin" : 24,
	"legend_armor.body.legend_tunic_wrap" : 24,
	"legend_armor.body.legend_southern_robe" : 24,
	"legend_armor.body.legend_robes_wizard" : 0, //FEATURE_1: disabled, looks ugly

	"legend_armor.body.legend_thick_tunic" : 36,
	"legend_armor.body.legend_dark_tunic" : 36,
	"legend_armor.body.legend_apron_butcher" : 36,
	
	"legend_armor.body.legend_apron" : 60,
	
	"legend_armor.body.legend_gladiator_harness" : 60,

	"legend_armor.body.legend_padded_surcoat" : 150,
	"legend_armor.body.legend_padded_surcoat_plain" : 150,

	"legend_armor.body.legend_southern_noble_surcoat" : 250, //FEATURE_1: buff 65 for 6
	"legend_armor.body.legend_gambeson" : 250,
	"legend_armor.body.legend_gambeson_plain" : 250,
	"legend_armor.body.legend_southern_gambeson" : 250, //65 for 8
	"legend_armor.body.legend_southern_split_gambeson" : 250,
	"legend_armor.body.legend_gambeson_wolf" : 250,
	"legend_armor.body.legend_gambeson_named" : 375,

	"legend_armor.body.legend_robes_magic" : 146, //fancy looking //FEATURE_10: magic rework
	"legend_armor.body.legend_tunic_noble" : 176, //40 for 2
	"legend_armor.body.legend_tunic_noble_named" : 264,

	//CHAIN
	"legend_armor.body.legend_southern_cloth" : 50,
	"legend_armor.body.legend_armor_rusty_mail_shirt" : 125,
	"legend_armor.body.legend_armor_reinforced_rotten_mail_shirt" : 200,
	"legend_armor.body.legend_armor_mail_shirt_simple" : 250,
	"legend_armor.body.legend_armor_ancient_mail" : 300,
	"legend_armor.body.legend_southern_padded_chest" : 325,
	"legend_armor.body.legend_armor_reinforced_worn_mail_shirt" : 350,
	"legend_armor.body.legend_armor_mail_shirt" : 375,
	"legend_armor.body.legend_armor_short_mail" : 500,
	"legend_armor.body.legend_armor_ancient_double_mail" : 750,
	"legend_armor.body.legend_armor_basic_mail" : 800,
	"legend_armor.body.legend_armor_reinforced_mail_shirt" : 1000,
	"legend_armor.body.legend_armor_hauberk_sleevless" : 1250,
	"legend_armor.body.legend_armor_reinforced_worn_mail" : 1250,
	"legend_armor.body.legend_southern_mail" : 1400,
	"legend_armor.body.legend_armor_hauberk" : 1750,
	"legend_armor.body.legend_armor_reinforced_mail" : 1750,
	"legend_armor.body.legend_armor_hauberk_full" : 2500,
	"legend_armor.body.legend_armor_hauberk_full_named" : 5000,

	//PLATE
	"legend_armor.body.legend_thick_furs_armor" : 15,
	"legend_armor.body.legend_armor_leather_jacket_simple" : 30, //FEATURE_1: Remove
	"legend_armor.body.legend_armor_leather_jacket" : 75,
	"legend_armor.body.legend_animal_hide_armor" : 100,
	"legend_armor.body.legend_southern_leather_jacket" : 110,
	
	
	"legend_armor.body.legend_armor_plate_ancient_gladiator" : 100,
	"legend_armor.body.legend_armor_leather_padded" : 175,
	"legend_armor.body.legend_reinforced_animal_hide_armor" : 175,
	"legend_armor.body.legend_southern_leather_plates" : 200,
	"legend_armor.body.legend_armor_cult_armor" : 250,
	"legend_armor.body.legend_armor_leather_lamellar" : 250,
	"legend_armor.body.legend_scrap_metal_armor" : 250,
	"legend_armor.body.legend_southern_strips" : 275,
	"legend_armor.body.legend_armor_plate_ancient_mail" : 300,
	"legend_armor.body.legend_southern_arm_guards" : 300,
	"legend_armor.body.legend_southern_scale" : 300,
	"legend_armor.body.legend_armor_leather_lamellar_reinforced" : 350,
	"legend_armor.body.legend_hide_and_bone_armor" : 350,
	"legend_armor.body.legend_southern_padded" : 400,
	"legend_armor.body.legend_armor_plate_ancient_scale_harness" : 500,
	"legend_armor.body.legend_armor_plate_ancient_scale_harness_restored" : 500,
	"legend_armor.body.legend_armor_leather_scale" : 600,
	"legend_armor.body.legend_armor_scale_coat_rotten" : 600,
	"legend_armor.body.legend_armor_leather_riveted_light" : 700,
	"legend_armor.body.legend_rugged_scale_armor" : 700,
	"legend_armor.body.legend_armor_leather_brigandine" : 750,
	"legend_armor.body.legend_armor_leather_jacket_named" : 750,
	"legend_armor.body.legend_armor_leather_studded_jacket_named" : 750,
	"legend_armor.body.legend_armor_plate_ancient_chest" : 750,
	"legend_armor.body.legend_southern_plate_full" : 750,
	"legend_armor.body.legend_armor_leather_riveted" : 900,
	"legend_armor.body.legend_armor_plate_ancient_scale" : 1000,
	"legend_armor.body.legend_heavy_iron_armor" : 1000,
	"legend_armor.body.legend_armor_leather_brigandine_hardened" : 1250,
	"legend_armor.body.legend_armor_plate_chest_rotten" : 1250,
	"legend_armor.body.legend_armor_leather_noble" : 1500,
	"legend_armor.body.legend_armor_plate_ancient_chest_restored" : 1500,
	"legend_armor.body.legend_armor_plate_ancient_harness" : 1500,
	"legend_armor.body.legend_southern_leather_scale" : 1500,
	"legend_armor.body.legend_southern_plate" : 1500,
	"legend_armor.body.legend_thick_plated_barbarian_armor" : 1500,
	"legend_armor.body.legend_armor_leather_lamellar_harness_heavy" : 1750,
	"legend_armor.body.legend_armor_scale_shirt" : 1750,
	"legend_armor.body.legend_armor_plate_ancient_scale_coat" : 2000,
	"legend_armor.body.legend_armor_plate_chest" : 2250,
	"legend_armor.body.legend_armor_scale" : 2250,
	"legend_armor.body.legend_armor_leather_brigandine_named" : 2500,
	"legend_armor.body.legend_armor_leather_lamellar_harness_reinforced" : 2500,
	"legend_armor.body.legend_armor_scale_coat" : 2500,
	"legend_armor.body.legend_armor_leather_brigandine_hardened_full" : 3000,
	"legend_armor.body.legend_armor_plate_ancient_scale_coat_restored" : 3000,
	"legend_armor.body.legend_armor_plate_cuirass" : 3500,
	"legend_armor.body.legend_armor_plate_full" : 4500,
	"legend_armor.body.legend_armor_leather_lamellar_heavy" : 4750,
	"legend_armor.body.legend_armor_plate_full_greaves" : 5000,
	"legend_armor.body.legend_armor_plate_krastenbrust" : 5000,
	"legend_armor.body.legend_armor_plate_milanese" : 5000,
	"legend_armor.body.legend_armor_plate_triangle" : 5000,
	"legend_armor.body.legend_armor_scale_coat_named" : 5000,
	"legend_armor.body.legend_southern_named_golden_plates" : 5600,
	"legend_armor.body.legend_armor_leather_lamellar_heavy_named" : 7500,
	"legend_armor.body.legend_southern_named_plates" : 9000,
	"legend_armor.body.legend_armor_plate_full_greaves_named" : 10000,
	"legend_armor.body.legend_armor_plate_full_greaves_painted" : 10000,

	//NAMED
	"legend_armor.body.black_leather" : 2000,
	"legend_armor.body.blue_studded_mail" : 4000,
	"legend_armor.body.named_plated_fur_armor" : 4000,
	"legend_armor.body.named_noble_mail_armor" : 5500,
	"legend_armor.body.named_skull_and_chain_armor" : 5500,
	"legend_armor.named_tabard" : 6000,
	"legend_armor.body.heraldic_mail" : 7000,
	"legend_armor.body.golden_scale" : 8000,
	"legend_armor.body.named_bronze_armor" : 9000,
	"legend_armor.cloak_rich" : 10000,
	"legend_armor.body.named_sellswords_armor" : 10000,
	"legend_armor.body.named_golden_lamellar_armor" : 11000,
	"legend_armor.body.brown_coat_of_plates" : 14000,
	"legend_armor.cloak_emperor" : 15000,
	"legend_armor.body.green_coat_of_plates" : 15000,

	//LEGENDARY
	"legend_armor.body.legend_named_warlock_cloak" : 5000,
	"legend_armor.body.lindwurm_armor" : 7500,
	"legend_armor.body.legend_mountain_armor" : 10000,
	"legend_armor.body.legend_mountain_armor_named" : 10000,
	"legend_armor.body.legend_skin_armor" : 10000,
	"legend_armor.body.ijirok_armor" : 12000,
	"legend_armor.body.armor_of_davkul" : 20000,
	"legend_armor.body.emperors_armor" : 20000,

	//CLOAK
	"legend_armor.body.legend_shoulder_cloth" : 50,
	"legend_armor.body.legend_armor_cloak_common" : 100,
	"legend_armor.body.legend_southern_scarf" : 100,
	"legend_armor.body.legend_dark_wooly_cloak" : 120,
	"legend_armor.body.legend_sash" : 150,
	"legend_armor.body.legend_southern_scarf_wrap" : 150,
	"legend_armor.body.legend_animal_pelt" : 250,
	"legend_armor.body.legend_noble_shawl" : 250,
	"legend_armor.body.legend_armor_cloak_crusader" : 500,
	"legend_armor.body.legend_armor_cloak_heavy" : 500,
	"legend_armor.body.serpent_skin" : 800,
	"legend_armor.body.unhold_fur" : 1000,
	"legend_armor.body.lindwurm_scales" : 1800,
	"legend_armor.body.legend_armor_cloak_noble" : 3000,
	"legend_armor.body.legend_redback_cloak" : 6000,
	"legend_armor.body.legend_hexe_leader_cloak" : 7500,
	"legend_armor.body.legend_stollwurm_scales" : 9000,

	//ARMOR_UPGRADES
	"legend_armor_upgrade.negative_moulderedd" : -250,
	"legend_armor_upgrade.negative_falling_apart" : -200,
	"legend_armor_upgrade.negative_weathered" : -150,
	"legend_armor_upgrade.negative_shabby" : -100,
	"legend_armor_upgrade.barbarian_horn" : 250,
	"legend_armor_upgrade.leather_neckguard" : 250,
	"legend_armor_upgrade.leather_shoulderguards" : 250,
	"armor_upgrade.light_gladiator_upgrade" : 400,
	"legend_armor_upgrade.mail_patch" : 500,
	"legend_armor_upgrade.direwolf_pelt" : 600,
	"legend_armor_upgrade.double_mail" : 600,
	"armor_upgrade.hyena_fur" : 600,
	"legend_armor_upgrade.serpent_skin" : 600,
	"legend_armor_upgrade.joint_cover" : 750,
	"armor_upgrade.heavy_gladiator_upgrade" : 800,
	"legend_armor_upgrade.metal_pauldrons" : 800,
	"legend_armor_upgrade.metal_plating" : 800,
	"legend_armor_upgrade.bone_platings" : 850,
	"legend_armor_upgrade.unhold_fur" : 1000,
	"legend_armor_upgrade.protective_runes" : 1100,
	"legend_armor_upgrade.additional_padding" : 1200,
	"legend_armor_upgrade.heraldic_plates" : 1800,
	"legend_armor_upgrade.lindwurm_scales" : 1800,
	"legend_armor_upgrade.light_padding_replacement" : 2000,
	"legend_armor_upgrade.horn_plate" : 4000,
	"legend_armor_upgrade.legend_stollwurm_scales" : 6000,
	"legend_armor_upgrade.legend_white_wolf_pelt" : 6000,

	//RUNES
	"legend_armor_upgrade.legend_rune_endurance" : 1200,
	"legend_armor_upgrade.legend_rune_resilience" : 1200,
	"legend_armor_upgrade.legend_rune_safety" : 1200,

//LEGEND_HELMETS //TODO: LEGEND_HELMETS prices

	//HOOD
	"armor.head.legend_helmet_goblin_scarf" : 5,
	"armor.head.legend_helmet_mummy_bandage" : 5,
	"armor.head.legend_helmet_cloth_cap" : 10,
	"armor.head.legend_helmet_cloth_scarf" : 10,
	"armor.head.legend_helmet_cloth_bandana" : 20,
	"armor.head.legend_helmet_southern_headband_coin" : 20,
	"armor.head.legend_helmet_southern_cap" : 30,
	"armor.head.legend_helmet_southern_cap_dark" : 30,

	"armor.head.legend_helmet_patched_hood" : 5,
	"armor.head.legend_helmet_simple_hood" : 8,

	"armor.head.legend_helmet_barb_leather_cap" : 55,
	"armor.head.legend_helmet_leather_cap" : 75,
	"armor.head.legend_helmet_rotten_chain_scarf" : 80,
	"armor.head.legend_helmet_padded_cap" : 90,
	"armor.head.legend_helmet_southern_open_hood" : 90,
	"armor.head.legend_helmet_southern_turban_light_hood" : 90,

	"armor.head.legend_helmet_leather_hood" : 16,
	"armor.head.legend_helmet_padded_hood" : 115,

	"armor.head.legend_helmet_barb_chain_scarf" : 125,
	"armor.head.legend_helmet_aventail" : 150,
	"armor.head.legend_helmet_chain_scarf" : 150,
	"armor.head.legend_helmet_rusty_chain_hood" : 150,
	"armor.head.legend_helmet_southern_open_chain_hood" : 200,
	"armor.head.legend_helmet_barb_open_chain" : 225,
	"armor.head.legend_helmet_open_chain_hood" : 225,
	"armor.head.legend_helmet_southern_chain_hood" : 260,
	"armor.head.legend_helmet_chain_hood" : 300,
	"armor.head.legend_helmet_southern_niqaab" : 300,
	"armor.head.legend_helmet_chain_hood_full" : 450,
	"armor.head.legend_helmet_bronze_chain" : 600,
	"armor.head.legend_helmet_enclave_bevor" : 750,

	//HELM
	"armor.head.legend_helmet_southern_leather_helm" : 60,
	"armor.head.legend_helmet_southern_studded_leather_helm" : 125,
	"armor.head.legend_helmet_barb_metal_cap" : 150,
	"armor.head.legend_helmet_norman_helm" : 150,
	"armor.head.legend_helmet_southern_cap_smooth" : 150,
	"armor.head.legend_helmet_southern_cap_spiked" : 150,
	"armor.head.legend_helmet_ancient_conic_helm" : 200,
	"armor.head.legend_helmet_ancient_crested" : 200,
	"armor.head.legend_helmet_ancient_dome" : 200,
	"armor.head.legend_helmet_ancient_kettle" : 200,
	"armor.head.legend_helmet_horsetail" : 200,
	"armor.head.legend_helmet_viking_helm" : 200,
	"armor.head.legend_helmet_flat_top_helm_low" : 225,
	"armor.head.legend_helmet_kettle_helm_low" : 250,
	"armor.head.legend_helmet_flat_top_helm" : 325,
	"armor.head.legend_helmet_ancient_dome_tailed" : 350,
	"armor.head.legend_helmet_ancient_face_plate" : 350,
	"armor.head.legend_helmet_ancient_legionaire" : 350,
	"armor.head.legend_helmet_ancient_side_hawk" : 350,
	"armor.head.legend_helmet_ancient_tailed_conic_helm" : 350,
	"armor.head.legend_helmet_orc_strapped_helm" : 400,
	"armor.head.legend_helmet_rotten_flat_top_face_mask" : 400,
	"armor.head.legend_helmet_italo_norman_helm" : 425,
	"armor.head.legend_helmet_nordic_helm_low" : 460,
	"armor.head.legend_helmet_ancient_face_helm" : 500,
	"armor.head.legend_helmet_crude_metal_helm" : 500,
	"armor.head.legend_helmet_kettle_helm_med" : 500,
	"armor.head.legend_helmet_flat_top_helm_polished" : 550,
	"armor.head.legend_helmet_ancient_beard_mask" : 600,
	"armor.head.legend_helmet_ancient_lion_mask" : 600,
	"armor.head.legend_helmet_ancient_mask" : 600,
	"armor.head.legend_helmet_crude_cylinder_helm" : 600,
	"armor.head.legend_helmet_enclave_skullcap" : 600,
	"armor.head.legend_helmet_orc_behemoth_helmet" : 600,
	"armor.head.legend_helmet_conic_helm" : 700,
	"armor.head.legend_helmet_scale_helm" : 725,
	"armor.head.legend_helmet_kettle_helm" : 750,
	"armor.head.legend_helmet_rotten_great_helm" : 750,
	"armor.head.legend_helmet_rondel_helm" : 775,
	"armor.head.legend_helmet_legend_ancient_legionaire_restored" : 800,
	"armor.head.legend_helmet_sallet" : 800,
	"armor.head.legend_helmet_kettle_helm_high" : 850,
	"armor.head.legend_helmet_flat_top_face_plate" : 900,
	"armor.head.legend_helmet_bronze_helm" : 1000,
	"armor.head.legend_helmet_deep_sallet" : 1000,
	"armor.head.legend_helmet_nordic_helm" : 1000,
	"armor.head.legend_helmet_orc_double_helm" : 1000,
	"armor.head.legend_helmet_southern_conic_helm" : 1000,
	"armor.head.legend_helmet_southern_helmet_nasal" : 1000,
	"armor.head.legend_helmet_dentist_helmet" : 1200,
	"armor.head.legend_helmet_heavy_plate_helm" : 1200,
	"armor.head.legend_helmet_legend_ancient_gladiator" : 1200,
	"armor.head.legend_helmet_orc_scale_helm" : 1200,
	"armor.head.legend_helmet_barbute" : 1250,
	"armor.head.legend_helmet_basinet" : 1250,
	"armor.head.legend_helmet_enclave_kettle" : 1250,
	"armor.head.legend_helmet_enclave_armet" : 1400,
	"armor.head.legend_helmet_orc_elite_double_helm" : 1500,
	"armor.head.legend_helmet_southern_peaked_nasal_helm" : 1500,
	"armor.head.legend_helmet_wallace_sallet" : 1500,
	"armor.head.legend_helmet_carthaginian" : 1600,
	"armor.head.legend_helmet_legend_armet" : 1750,
	"armor.head.legend_helmet_nordic_helm_high" : 1750,
	"armor.head.legend_helmet_heavy_spiked_helm" : 1800,
	"armor.head.legend_helmet_italo_norman_helm_named" : 2000,
	"armor.head.legend_helmet_southern_named_conic" : 2000,
	"armor.head.legend_helmet_southern_peaked_helm" : 2000,
	"armor.head.legend_helmet_legend_frogmouth" : 2250,
	"armor.head.legend_helmet_legend_frogmouth_close" : 2250,
	"armor.head.legend_helmet_bascinet_named" : 2500,
	"armor.head.legend_helmet_great_helm" : 2500,
	"armor.head.legend_helmet_southern_gladiator_helm_crested" : 2500,
	"armor.head.legend_helmet_southern_gladiator_helm_masked" : 2500,
	"armor.head.legend_helmet_southern_gladiator_helm_split" : 2500,
	"armor.head.legend_helmet_wallace_sallet_named" : 2500,
	"armor.head.legend_helmet_enclave_great_helm" : 2650,
	"armor.head.legend_helmet_barbute_named" : 2750,
	"armor.head.legend_helmet_enclave_great_bascinet" : 2800,
	"armor.head.legend_helmet_enclave_venitian_bascinet" : 3000,
	"armor.head.legend_helmet_orc_great_helm" : 3000,
	"armor.head.legend_helmet_tailed_conic" : 3000,
	"armor.head.legend_helmet_deep_sallet_named" : 3200,
	"armor.head.legend_helmet_crude_skull_helm" : 3500,
	"armor.head.legend_helmet_heavy_plate_helm_named" : 3500,
	"armor.head.legend_helmet_kettle_helm_named" : 3500,
	"armor.head.legend_helmet_legend_armet_01_named" : 4000,
	"armor.head.legend_helmet_stag_helm" : 5000,
	"armor.head.legend_helmet_swan_helm" : 5000,
	"armor.head.legend_helmet_barb_ritual_helm" : 6000,
	"armor.head.legend_helmet_skin_helm" : 20000,

	//HELMETS
	"armor.head.legend_faction_helmet" : 200,

	//TOP
	"armor.head.legend_helmet_goblin_leaves" : 0,
	"armor.head.legend_helmet_hood_cloth_round" : 5,
	"armor.head.legend_helmet_hood_cloth_square" : 5,
	"armor.head.legend_helmet_hood_cloth_wide" : 5,
	"armor.head.legend_helmet_cloth_long_hood" : 30,
	"armor.head.legend_helmet_headband_nose" : 30,
	"armor.head.legend_helmet_headband_side" : 30,
	"armor.head.legend_helmet_goblin_leather_mask" : 50,
	"armor.head.legend_helmet_cult_hood" : 60,
	"armor.head.legend_helmet_nose_plate" : 60,
	"armor.head.legend_helmet_goblin_gillie" : 80,
	"armor.head.legend_helmet_goblin_leaf_helm" : 100,
	"armor.head.legend_helmet_southern_veil" : 100,
	"armor.head.legend_helmet_southern_veil_coin" : 100,
	"armor.head.legend_helmet_vampire_crown" : 100,
	"armor.head.legend_helmet_goblin_leather_helm" : 105,
	"armor.head.legend_helmet_eyemask" : 125,
	"armor.head.legend_helmet_goblin_chain_helm" : 125,
	"armor.head.legend_helmet_goblin_spiked_helm" : 125,
	"armor.head.legend_helmet_faceplate_short" : 140,
	"armor.head.legend_helmet_facemask" : 150,
	"armor.head.legend_helmet_orc_leather_mask" : 150,
	"armor.head.legend_helmet_wallace_sallet_visor" : 150,
	"armor.head.legend_helmet_faceplate_long" : 180,
	"armor.head.legend_helmet_ancient_crown" : 200,
	"armor.head.legend_helmet_mummy_beard" : 200,
	"armor.head.legend_helmet_orc_horn_mask" : 200,
	"armor.head.legend_helmet_fencer_hat" : 225,
	"armor.head.legend_helmet_unhold_head_chain" : 240,
	"armor.head.legend_helmet_chain_attachment" : 250,
	"armor.head.legend_helmet_enclave_armet_visor" : 300,
	"armor.head.legend_helmet_faceplate_curved" : 300,
	"armor.head.legend_helmet_faceplate_flat" : 300,
	"armor.head.legend_helmet_faceplate_full_breaths" : 300,
	"armor.head.legend_helmet_faceplate_sharp" : 300,
	"armor.head.legend_helmet_leather_hood_barb" : 300,
	"armor.head.legend_helmet_enclave_great_jaw" : 350,
	"armor.head.legend_helmet_orc_metal_mask" : 400,
	"armor.head.legend_helmet_mummy_mask" : 450,
	"armor.head.legend_helmet_enclave_venitian_bascinet_visor" : 500,
	"armor.head.legend_helmet_faceplate_snub_nose" : 500,
	"armor.head.legend_helmet_faceplate_snub_slit" : 500,
	"armor.head.legend_helmet_faceplate_pointed" : 600,
	"armor.head.legend_helmet_faceplate_pointed_slit" : 600,
	"armor.head.legend_helmet_faceplate_winged" : 600,
	"armor.head.legend_helmet_southern_faceplate_bearded" : 700,
	"armor.head.legend_helmet_wallace_sallet_visor_named" : 700,
	"armor.head.legend_helmet_faceplate_full" : 800,
	"armor.head.legend_helmet_faceplate_raised" : 800,
	"armor.head.legend_helmet_unhold_head_spike" : 800,
	"armor.head.legend_helmet_enclave_great_bascinet_visor" : 900,
	"armor.head.legend_helmet_bascinet_visor_named" : 1000,
	"armor.head.legend_helmet_faceplate_full_gold" : 1000,
	"armor.head.legend_helmet_golden_mask" : 1500,
	"armor.head.legend_helmet_faceplate_gold" : 1600,
	"armor.head.legend_helmet_faceplate_full_01_named" : 2000,
	"armor.head.legend_helmet_warlock_skull" : 2000,
	"armor.head.legend_helmet_golden_helm" : 3000,

	//VANITY
	"armor.head.legend_helmet_ancient_priest_hat" : 100,
	"armor.head.legend_helmet_ancient_wig" : 100,
	"armor.head.legend_helmet_antler" : 100,
	"armor.head.legend_helmet_bear_head" : 100,
	"armor.head.legend_helmet_beret" : 100,
	"armor.head.legend_helmet_bull_horns" : 100,
	"armor.head.legend_helmet_crown" : 100,
	"armor.head.legend_helmet_faction_decayed_helmet" : 100,
	"armor.head.legend_helmet_faction_helmet" : 100,
	"armor.head.legend_helmet_faction_helmet_2" : 100,
	"armor.head.legend_helmet_feathered_hat" : 100,
	"armor.head.legend_helmet_feather_band" : 100,
	"armor.head.legend_helmet_fencerhat" : 100,
	"armor.head.legend_helmet_goat_horns" : 100,
	"armor.head.legend_helmet_goblin_bones" : 100,
	"armor.head.legend_helmet_headband" : 100,
	"armor.head.legend_helmet_horn_decorations" : 100,
	"armor.head.legend_helmet_impaled_head" : 100,
	"armor.head.legend_helmet_lion_pelt" : 100,
	"armor.head.legend_helmet_metal_bird" : 100,
	"armor.head.legend_helmet_mummy_crown" : 100,
	"armor.head.legend_helmet_mummy_crown_king" : 100,
	"armor.head.legend_helmet_mummy_headband" : 100,
	"armor.head.legend_helmet_mummy_headress" : 100,
	"armor.head.legend_helmet_noble_buckle" : 100,
	"armor.head.legend_helmet_noble_feather" : 100,
	"armor.head.legend_helmet_noble_floppy_hat" : 100,
	"armor.head.legend_helmet_noble_hat" : 100,
	"armor.head.legend_helmet_noble_hood" : 100,
	"armor.head.legend_helmet_noble_southern_crown" : 100,
	"armor.head.legend_helmet_noble_southern_hat" : 100,
	"armor.head.legend_helmet_nun_habit" : 100,
	"armor.head.legend_helmet_orc_bones" : 100,
	"armor.head.legend_helmet_orc_great_horns" : 100,
	"armor.head.legend_helmet_plait" : 100,
	"armor.head.legend_helmet_ponytail" : 100,
	"armor.head.legend_helmet_ram_horns" : 100,
	"armor.head.legend_helmet_royal_hood" : 100,
	"armor.head.legend_helmet_sack" : 100,
	"armor.head.legend_helmet_side_feather" : 100,
	"armor.head.legend_helmet_southern_cloth_headress" : 100,
	"armor.head.legend_helmet_southern_earings" : 100,
	"armor.head.legend_helmet_southern_feathered_turban" : 100,
	"armor.head.legend_helmet_southern_headband" : 100,
	"armor.head.legend_helmet_southern_headress_coin" : 100,
	"armor.head.legend_helmet_southern_helm_tailed" : 100,
	"armor.head.legend_helmet_southern_noble_turban" : 100,
	"armor.head.legend_helmet_southern_patterned_headband" : 100,
	"armor.head.legend_helmet_southern_patterned_headwrap" : 100,
	"armor.head.legend_helmet_southern_silk_headscarf" : 100,
	"armor.head.legend_helmet_southern_top_tail" : 100,
	"armor.head.legend_helmet_southern_turban_feather" : 100,
	"armor.head.legend_helmet_southern_turban_full" : 100,
	"armor.head.legend_helmet_southern_turban_light" : 100,
	"armor.head.legend_helmet_southern_turban_open" : 100,
	"armor.head.legend_helmet_straw_hat" : 100,
	"armor.head.legend_helmet_top_feather" : 100,
	"armor.head.legend_helmet_warlock_hood" : 100,
	"armor.head.legend_helmet_wizard_cowl" : 100,
	"armor.head.legend_helmet_wolf_helm" : 100,
	"armor.head.legend_helmet_wreath" : 100,
	"armor.head.legend_helmet_demon_alp_helm" : 200,
	"armor.head.legend_helmet_jester_hat" : 200,
	"armor.head.legend_helmet_lindwurm_helm" : 200,
	"armor.head.legend_helmet_nach_helm" : 200,
	"armor.head.legend_helmet_redback_helm" : 200,
	"armor.head.legend_helmet_white_wolf_helm" : 200,
	"armor.head.legend_helmet_witchhunter_helm" : 200,
	"armor.head.legend_helmet_hunter_cap" : 1200,
	"armor.head.legend_helmet_mountain_helm" : 2000,

	//VANITY_LOWER
	"armor.head.legend_helmet_back_crest" : 100,
	"armor.head.legend_helmet_back_feathers" : 100,
	"armor.head.legend_helmet_feather_crest" : 100,
	"armor.head.legend_helmet_goblin_tail" : 100,
	"armor.head.legend_helmet_knotted_tail" : 100,
	"armor.head.legend_helmet_orc_tail" : 100,
	"armor.head.legend_helmet_top_plume" : 100,
	"armor.head.legend_helmet_wings" : 100,

	//RUNES
	"legend_helmet_upgrade.legend_rune_bravery" : 1200,
	"legend_helmet_upgrade.legend_rune_clarity" : 1200,
	"legend_helmet_upgrade.legend_rune_luck" : 1200,
};