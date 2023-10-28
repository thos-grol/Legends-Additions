// BB has an inflation problem where by late game, your money becomes useless since you gained so much of it from
// contracts and selling massive amounts of loots and goods. How to combat inflation?
// 1. Slow down the rate at which money is printed.
// 	- Nerfing units to be poorer, be more economical and realistic.
// 	- Spamming selling an item type will cause it to decrease in value for a short period of time that decays...
// 	- Some loot, merchants will refuse to buy.
// 	- Remove most events that give free stuff
// 	- decreasing contract payouts.
// 2. Money sinks. With 1, money will still eventually pile up. You need a way to burn it:
// 	- fees to hire retinue and then paying a premium salary to keep them.
// 	- Guild hall with upgrades and material costs.
// 	- selling necessities or undroppable gear.
// 	- make services better/more necessary to encourage more spending
// 	- tie that currency to another currency ie. resources that are used in multiple ways
// 	- overhauled crafting system so players don't sell their items but use them elsewhere/break them down

//FEATURE_5: Barbarians stats are higher than average humans due to needing to survive

//FEATURE_8: overhaul enemy equipment/builds
//FEATURE_5: selling the same item type to stores will decrease the price you can sell it at for a duration...
//FEATURE_7: guild headquarters features:
	//bros in headquarters will charge extra salary accounting for food
	//item storage
	//bro storage
	//smithy
	//fletcher
	//caravan - sell your produced goods, buy goods. caravan will sell whatever goods have same id put into the item box
	//training - teachers and students, teachers poplate teaching list, can teach students things, bros put here will study
	//gatherer - send bros to places to gather materials, has upgrades etc.


// 12 Pence (d) = 1 Shilling (s)
// 20 Shilling = 1 pound £

// Horse harness maker: 4 Pence / Day
// Mason: 6 Pence / Day
// Laborer: 3,5 Pence / Day

//levied spearmen 2 Pence / Day
//!!!! pay of soldiers includes food and looting

// Levied spearman: 2 Pence / Day
// once bro reaches level 6 and level 11, their salary increases
//		lv 6 2 -> 4
//		lv 11 10 -> 8
// Archer: 3 Pence / Day
// Squire: 12 d
// Knight bachelor: 24 p / Day
// Knight banneret: 48 p / Day

// 4 gallons of ale: 1d
// 1 hen: 5d
// Brass pot: 2-13s
// 1 cart-horse: Up to 32 Shillings

// mail was commonplace among infantrymen in the 12th century.
// Most infantrymen would wear either mail or lamellar armour or coats-of-plates (“Visby armour”). Cuir-bouilli would also be used, especially as limb protection. Also padded armour (gambesons, haquetons and jerkins) were commonplace
::Const.World.Assets.BaseSellPrice = 0.62;
::Z.Economy.Items <- {
//SUPPLIES
	"supplies.ammo_small" : 30,
	"supplies.ammo" : 60,
	"supplies.armor_parts_small" : 60,
	"supplies.medicine_small" : 60,
	"supplies.armor_parts" : 120,
	"supplies.medicine" : 120,

	//AMMO
	"ammo.arrows" : 30, //TODO: a lot of arrows/bolts/powder share same id, use manual hooks for prices
	"ammo.bolts" : 0,
	"ammo.powder" : 0, //TODO: refillable with alchemist

	//FOOD
	"supplies.ground_grains" : 5, 		//unit of 15 servings
	"supplies.rice" : 7, 				//unit of 20
	"supplies.bread" : 10, 				//unit of 20 loafs
	"supplies.legend_fresh_fruit" : 11, //unit of 15
	"supplies.roots_and_berries" : 11, 	//unit of 15
	"supplies.dates" : 22, 				//unit of 20
	"supplies.dried_fruits" : 32, 		//unit of 30

	//MEAT
	"supplies.strange_meat" : 25, 		//unit of 15
	"supplies.legend_fresh_meat" : 25, 	//unit of 15
	"supplies.dried_fish" : 40, 		//unit of 20
	"supplies.smoked_ham" : 60, 		//unit of 30
	"supplies.dried_lamb" : 60, 		//unit of 30

	//ALCOHOL
	"supplies.beer" : 9, 				//35 units
	"supplies.preserved_mead" : 11, 	//20 units
	"supplies.mead" : 13, 				//25 units
	"supplies.wine" : 27, 				//35 units

	//REMOVED
	"supplies.cured_venison" : 0,
	"supplies.goat_cheese" : 0,
	"supplies.legend_human_parts" : 0, //FEATURE_5: Remove
	"supplies.fermented_unhold_heart" : 0,
	"supplies.legend_yummy_sausages" : 0,
	"supplies.black_marsh_stew" : 0,
	"supplies.legend_porridge" : 0, //FEATURE_5: Remove
	"supplies.legend_pudding" : 0, //FEATURE_5: Remove
	"supplies.legend_pie" : 0, //FEATURE_5: Remove
	"supplies.cured_rations" : 0, //FEATURE_5: Remove
	"supplies.legend_cooking_spices" : 0,//FEATURE_5: Remove
	"supplies.pickled_mushrooms" : 0,//FEATURE_5: Remove

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
	"misc.gemstones" : 700, //1 units of cut emeralds //TODO: Change to trade item

	//Removed
	"misc.legend_cooking_spices" : 0, //FEATURE_5: Remove

//TENTS
	"tent.hunter_tent" : 200,
	"tent.fletcher_tent" : 200,
	"tent.scout_tent" : 200,

	"tent.scrap_tent" : 300,
	"tent.gather_tent" : 300,
	"tent.healer_tent" : 300,
	"tent.repair_tent" : 300,
	"tent.craft_tent" : 300, //FEATURE_8: disable + disable crafting in party

	"tent.training_tent" : 500,
	"tent.enchant_tent" : 1000,

//SPAWNS
	"spawns.skeleton" : 0,
	"spawns.zombie" : 0,
	"spawns.donkey" : 0,
	"spawns.cart_01" : 260,
	"spawns.cart_02" : 400,

//LOOT //FEATURE_8: LOOT sort by tiers and price
	"misc.signet_ring" : 960, //FEATURE_8: Rename to Silver Sapphire Ring, change drops from the richest/treasure hordes , change to accessory/bag slot item
	"misc.ancient_scroll" : 400,
	"misc.legend_scroll" : 400,
	"misc.ornate_tome" : 800, //FEATURE_8: Magic rework, contains knowledge, decipherable, generate more tome images, price based on book tiers
	"misc.white_pearls" : 300, //FEATURE_8: 15 units, rework into item with ammount, trade goods, found in port cities/loot

	//Monster drops //FEATURE_8: Loot prices and removal
	"misc.growth_pearls" : 100, //FEATURE_8: 5 units, rework into item with ammount
	"misc.soul_splinter" : 1200, //FEATURE_8: black soul gem, rare alp drop. used for necromancy
	"misc.ancient_amber" : 800, //FEATURE_8: rare scrat drop. contains life energy
	"misc.adrenaline_gland" : 100,
	"misc.spider_silk" : 100,

	"misc.ghoul_horn" : 0,
	"misc.ghoul_teeth" : 0,
	"misc.ghoul_brain" : 0,

	"misc.poison_gland" : 0,
	"misc.parched_skin" : 0,
	"misc.petrified_scream" : 0,
	"misc.third_eye" : 0,
	"misc.frost_unhold_fur" : 0,
	"misc.werewolf_pelt" : 0,
	"misc.unhold_hide" : 0,
	"misc.vampire_dust" : 0,
	"misc.unhold_bones" : 0,
	"misc.unhold_heart" : 0,
	"misc.legend_skin_ghoul_skin" : 0,
	"misc.lindwurm_blood" : 0,
	"misc.sulfurous_rock" : 0,
	"misc.witch_hair" : 0,
	"misc.lindwurm_bones" : 0,
	"misc.glowing_resin" : 0,
	"misc.legend_redback_poison_gland" : 0,
	"misc.legend_white_wolf_pelt" : 0,
	"misc.ancient_wood" : 0,
	"misc.legend_demon_alp_skin" : 0,
	"misc.lindwurm_scales" : 0,
	"misc.heart_of_the_forest" : 0,
	"misc.legend_rock_unhold_hide" : 0,
	"misc.kraken_horn_plate" : 0,
	"misc.kraken_tentacle" : 0,
	"misc.legend_rock_unhold_bones" : 0,
	"misc.legend_stollwurm_blood" : 0,
	"misc.legend_witch_leader_hair" : 0,
	"misc.legend_ancient_green_wood" : 0,
	"misc.legend_stollwurm_scales" : 0,
	"misc.legend_demon_third_eye" : 0,

	"misc.legend_banshee_essence" : 0,
	"misc.legend_demon_hound_bones" : 0,

	//FEATURE_8: Remove certain monster drops
	"misc.snake_oil" : 0,
	"misc.rainbow_scale" : 0, //FEATURE_8: Remove item and snakes for now
	"misc.glistening_scales" : 0, //FEATURE_8: Remove
	"misc.serpent_skin" : 350, //FEATURE_8: Remove
	"misc.sabertooth" : 0, //FEATURE_8: Remove
	"misc.golden_chalice" : 0, //FEATURE_8: Remove
	"misc.ancient_gold_coins" : 0, //FIFEATURE_8XME: Remove
	"misc.jade_broche" : 0, //FEATURE_8: Remove
	"misc.silverware" : 0, //FEATURE_8: Remove
	"misc.silver_bowl" : 0, //FEATURE_8: Remove
	"misc.valuable_furs" : 0, //FEATURE_8: Remove and replace with "misc.furs" : 100
	"misc.bone_figurines" : 0, //FEATURE_8: Remove
	"misc.bead_necklace" : 0, //FEATURE_8: Remove
	"misc.looted_valuables" : 0, //FEATURE_8: Remove
	"misc.goblin_carved_ivory_iconographs" : 0, //FEATURE_8: Remove
	"misc.goblin_minted_coins" : 0, //FEATURE_8: Remove
	"misc.goblin_rank_insignia" : 0, //FEATURE_8: Remove
	"misc.webbed_valuables" : 0, //FEATURE_8: Remove
	"misc.deformed_valuables" : 0, //FEATURE_8: Remove
	"misc.legend_bear_fur" : 0, //FEATURE_8: Remove and remove bears
	"misc.lindwurm_hoard" : 0, //FEATURE_8: Remove
	"misc.jeweled_crown" : 0, //FEATURE_8: Remove
	"misc.glittering_rock" : 0, //FEATURE_8: Remove
	"misc.hyena_fur" : 0, //FEATURE_8: Remove and remove hyenas
	"misc.acidic_saliva" : 0, //FEATURE_8: Remove and remove hyenas

	"misc.manhunters_ledger" : 0,
	"misc.legend_werehand" : 0,
	"misc.paint_remover" : 0,
	"misc.paint_black" : 0,
	"misc.paint_red" : 0,
	"misc.paint_orange_red" : 0,
	"misc.poisoned_apple" : 0,
	"misc.paint_set_shields" : 0,
	"misc.paint_white_blue" : 0,
	"misc.paint_white_green_yellow" : 0,

	"misc.mysterious_herbs" : 0,
	"misc.legend_mistletoe" : 30,
	"misc.legend_wolfsbane" : 50,


//SPECIAL //FEATURE_8: Special prices
	"misc.legendary_sword_blade" : 0,
	"misc.legendary_sword_grip" : 0,
	"misc.black_book" : 0,
	"misc.broken_ritual_armor" : 0,
	"misc.trade_jug" : 0,
	"misc.golden_goose" : 0, //FEATURE_8: Remove the golden goose for now

//RUNE_SIGILS //FEATURE_8: Rune prices
	"token.legend_vala_inscription" : 0,
	"legend_helmet_upgrade.legend_rune_bravery" : 0,
	"legend_helmet_upgrade.legend_rune_clarity" : 0,
	"legend_helmet_upgrade.legend_rune_luck" : 0,
	"legend_armor_upgrade.legend_rune_endurance" : 0,
	"legend_armor_upgrade.legend_rune_resilience" : 0,
	"legend_armor_upgrade.legend_rune_safety" : 0,

//TOOLS //TODO: Tools prices
	"tool.legend_broken_throwing_net" : 0,
	"accessory.therianthropy_potion" : 0,
	"tool.throwing_net" : 0,
	"tool.reinforced_throwing_net" : 0,
	"weapon.holy Water" : 0, //TODO: remove for now
	"weapon.acid_flask" : 400, //FEATURE_3: rework, refillable with alchemist retinue
	"weapon.smoke_bomb" : 400, //FEATURE_3: rework, refillable with alchemist retinue
	"weapon.daze_bomb" : 500, //FEATURE_3: rework, refillable with alchemist retinue
	"weapon.fire_bomb" : 600, //FEATURE_3: rework, refillable with alchemist retinue
	"accessory.berserker_mushrooms" : 100,
	"accessory.legend_apothecary_mushrooms" : 100,
	"accessory.poison" : 100,
	"accessory.antidote" : 150, //FEATURE_3: rework, refillable with alchemist retinue
	"accessory.spider_poison" : 150, //FEATURE_3: rework, refillable with alchemist retinue
	"accessory.iron_will_potion" : 300, //FEATURE_3: rework, refillable with alchemist retinue
	"accessory.lionheart_potion" : 300, //FEATURE_3: rework, refillable with alchemist retinue
	"accessory.night_vision_elixir" : 350, //FEATURE_3: rework, refillable with alchemist retinue
	"accessory.recovery_potion" : 350, //FEATURE_3: rework, refillable with alchemist retinue
	"accessory.legend_heartwood_sap_flask" : 3500,
	"accessory.legend_skin_ghoul_blood_flask" : 3500,
	"accessory.legend_stollwurm_blood_flask" : 3500,
	"accessory.legend_hexen_ichor_potion" : 7000,
	"misc.potion_of_oblivion" : 2500,
	"misc.potion_of_knowledge" : 750,
	"accessory.cat_potion" : 350, //FEATURE_3: rework, refillable with alchemist retinue
	//TODO: Toxicity system
	//Contraband
	"misc.happy_powder" : 400, //TODO: Drugs
	"misc.miracle_drug" : 450,

	"misc.bodily_reward" : 2500,
	"misc.spiritual_reward" : 2500,

//ACCESSORY
	"accessory.oathtaker_skull_01" : 0,
	"accessory.oathtaker_skull_02" : 0,
	"accessory.bandage" : 0,
	"accessory.legend_pack_small" : 0,
	"accessory.legend_pack_large" : 0,
	"accessory.legend_catapult" : 0,

	//GEAR
	"accessory.sergeant_badge" : 0,
	"accessory.ghoul_trophy" : 0, //FEATURE_8 Rework
	"accessory.alp_trophy" : 0, //FEATURE_8 Rework
	"accessory.goblin_trophy" : 0, //FEATURE_8 Rework
	"accessory.orc_trophy" : 0, //FEATURE_8 Rework
	"accessory.undead_trophy" : 0, //FEATURE_8 Rework
	"accessory.hexen_trophy" : 0, //FEATURE_8 Rework
	"accessory.legend_demon_banshee_trophy" : 0, //FEATURE_8 Rework
	"accessory.legend_demonalp_trophy" : 0, //FEATURE_8 Rework
	"accessory.legend_hexen_leader_trophy" : 0, //FEATURE_8 Rework
	"accessory.cursed_crystal_skull" : 0, //FEATURE_8 Rework
	"accessory.slayer_necklace" : 0, //FEATURE_8 Rework

	//PET
	"accessory.falcon" : 100,
	"accessory.legend_cat_item" : 0,
	"accessory.legend_wolfsbane_necklace" : 0,
	"accessory.wardog" : 0,
	"accessory.warhound" : 0,
	"accessory.armored_wardog" : 0,
	"accessory.armored_warhound" : 0,
	"accessory.heavily_armored_wardog" : 0,
	"accessory.warwolf" : 0,
	"accessory.heavily_armored_warhound" : 0,
	"accessory.legend_warbear" : 0,
	"accessory.legend_white_warwolf" : 0,
	"misc.wardog_heavy_armor_upgrade" : 0,
	"misc.wardog_armor_upgrade" : 0,

	//OTHER //TODO: rework event
	"accessory.legend_oms_fate" : 100,
	"accessory.legend_oms_rib" : 100,
	"accessory.legend_oms_tome" : 100,
	"accessory.legend_oms_paw" : 100,
	"accessory.legend_oms_amphora" : 100,
//WEAPONS
	//DAGGER
	"weapon.legend_shiv" : 0,                   		//( 10,  20) | AP: 0.20 | AE: 0.30
	"weapon.legend_redback_dagger" : 0,      			//( 26,  52) | AP: 0.36 | AE: 0.70
	"weapon.obsidian_dagger" : 0,            			//( 35,  50) | AP: 0.20 | AE: 1.15 //FEATURE_5: rework method of acquiring and fight

	"weapon.legend_wooden_stake" : 0,          			//( 10,  15) | AP: 0.30 | AE: 0.10
	"weapon.knife" : 6,                        			//( 15,  25) | AP: 0.20 | AE: 0.50
	"weapon.dagger" : 24,                      			//( 15,  35) | AP: 0.20 | AE: 0.60
	"weapon.rondel_dagger" : 75,               			//( 20,  40) | AP: 0.20 | AE: 0.70
	"shield.legend_parrying_dagger" : 65,
	"shield.legend_named_parrying_dagger" : 65,
	"weapon.goblin_notched_blade" : 55,        			//( 20,  30) | AP: 0.20 | AE: 0.60
	"weapon.named_dagger" : 113,               			//( 20,  40) | AP: 0.20 | AE: 0.70
	"weapon.qatal_dagger" : 75,                			//( 30,  45) | AP: 0.20 | AE: 0.70
	"weapon.named_qatal_dagger" : 113,         			//( 30,  45) | AP: 0.20 | AE: 0.70
	"weapon.legend_katar" : 120,               			//( 30,  45) | AP: 0.30 | AE: 1.25

	//SWORD
	//FEATURE_3: swords are rarer, usually only equipped by swordmasters/nobles/strong units
	//1H
	"weapon.broken_ancient_sword" : 0,        			//( 30,  35) | AP: 0.20 | AE: 0.75
	"weapon.legend_skin_flayer" : 0,         			//( 45,  60) | AP: 0.20 | AE: 0.90
	"weapon.legend_man_mangler" : 0,         			//( 60,  95) | AP: 0.35 | AE: 1.00
	"weapon.sickle" : 8,                       			//( 15,  20) | AP: -0.05 | AE: 0.50
	"weapon.legend_named_sickle" : 90,        			//( 40,  55) | AP: 0.20 | AE: 0.90
	//FEATURE_5: nerf named sickle, add auxillary flag for gathering

	"weapon.shortsword" : 90,                  			//( 30,  40) | AP: 0.20 | AE: 0.75
	"weapon.goblin_falchion" : 90,             			//( 35,  45) | AP: 0.20 | AE: 0.70
	"weapon.named_goblin_falchion" : 135,      			//( 35,  45) | AP: 0.20 | AE: 0.70

	"weapon.falchion" : 120,                    		//( 35,  45) | AP: 0.20 | AE: 0.70
	"weapon.saif" : 110,                        		//( 35,  40) | AP: 0.20 | AE: 0.65
	"weapon.legend_kopis" : 120,               			//( 35,  45) | AP: 0.25 | AE: 1.00
	"weapon.ancient_sword" : 120,               		//( 38,  43) | AP: 0.20 | AE: 0.80

	"weapon.arming_sword" : 150,               			//( 40,  45) | AP: 0.20 | AE: 0.80
	"weapon.scimitar" : 150,                   			//( 40,  45) | AP: 0.20 | AE: 0.70
	"weapon.legend_gladius" : 150,              		//( 43,  48) | AP: 0.20 | AE: 0.80
	"weapon.legend_named_gladius" : 225,       			//( 43,  48) | AP: 0.20 | AE: 0.80

	"weapon.noble_sword" : 188,                			//( 45,  50) | AP: 0.20 | AE: 0.85
	"weapon.named_sword" : 282,                			//( 45,  50) | AP: 0.20 | AE: 0.85
	"weapon.shamshir" : 188,                   			//( 45,  50) | AP: 0.20 | AE: 0.75
	"weapon.named_shamshir" : 282,             			//( 45,  50) | AP: 0.20 | AE: 0.75
	"weapon.fencing_sword" : 146,              			//( 35,  50) | AP: 0.20 | AE: 0.75
	"weapon.named_fencing_sword" : 219,        			//( 35,  50) | AP: 0.20 | AE: 0.75

	"weapon.lightbringer_sword" : 18000,        		//( 50,  55) | AP: 0.20 | AE: 0.90

	//2H
	"weapon.rhomphaia" : 146,                  			//( 45,  65) | AP: 0.20 | AE: 1.05
	"weapon.warbrand" : 166,                   			//( 50,  75) | AP: 0.20 | AE: 0.75
	"weapon.named_warbrand" : 249,             			//( 50,  75) | AP: 0.20 | AE: 0.75

	"weapon.legend_longsword" : 166,           			//( 50,  75) | AP: 0.25 | AE: 0.80
	"weapon.legend_named_longsword" : 249,     			//( 50,  75) | AP: 0.25 | AE: 0.80
	"weapon.legend_crusader_sword" : 208,      			//( 60,  75) | AP: 0.25 | AE: 0.80

	"weapon.legend_estoc" : 186,               			//( 45,  60) | AP: 0.20 | AE: 0.60
	"weapon.legend_named_estoc" : 279,         			//( 45,  60) | AP: 0.20 | AE: 0.60

	"weapon.longsword" : 194,                  			//( 65,  85) | AP: 0.25 | AE: 1.00
	"weapon.named_longsword" : 291,            			//( 65,  85) | AP: 0.25 | AE: 1.00
	"weapon.greatsword" : 266,                 			//( 85, 100) | AP: 0.25 | AE: 1.00
	"weapon.named_greatsword" : 399,           			//( 85, 100) | AP: 0.25 | AE: 1.00

	//AXE
	"weapon.legend_meat_hacker" : 0,          			//( 30,  55) | AP: 0.30 | AE: 1.20
	"weapon.orc_axe" : 0,                    			//( 35,  65) | AP: 0.30 | AE: 1.30

	//1H
	"weapon.hatchet" : 12,                     			//( 25,  40) | AP: 0.30 | AE: 1.10
	"weapon.crude_axe" : 0,                   			//( 30,  40) | AP: 0.30 | AE: 1.20
	"weapon.hand_axe" : 72,                   			//( 30,  45) | AP: 0.30 | AE: 1.20
	"weapon.fighting_axe" : 150,               			//( 35,  55) | AP: 0.30 | AE: 1.30
	"weapon.named_axe" : 225,                  			//( 35,  55) | AP: 0.30 | AE: 1.30
	"weapon.named_orc_axe" : 225,              			//( 35,  65) | AP: 0.30 | AE: 1.30
	//2H
	"weapon.legend_hoe" : 3,                   			//( 15,  20) | AP: 0.30 | AE: 0.60
	"weapon.woodcutters_axe" : 12,             			//( 35,  70) | AP: 0.40 | AE: 1.25

	"weapon.legend_infantry_axe" : 112,        			//( 50,  70) | AP: 0.35 | AE: 1.25
	"weapon.legend_named_infantry_axe" : 168,  			//( 50,  70) | AP: 0.35 | AE: 1.25

	"weapon.longaxe" : 112,                    			//( 70,  95) | AP: 0.30 | AE: 1.10
	"weapon.named_longaxe" : 168,              			//( 70,  95) | AP: 0.30 | AE: 1.10
	"weapon.legend_fan_axe" : 151,             			//( 60,  95) | AP: 0.40 | AE: 1.10

	"weapon.bardiche" : 151,                   			//( 75,  95) | AP: 0.40 | AE: 1.30
	"weapon.named_bardiche" : 227,             			//( 75,  95) | AP: 0.40 | AE: 1.30

	"weapon.heavy_rusty_axe" : 0,            			//( 75,  90) | AP: 0.40 | AE: 1.50
	"weapon.named_heavy_rusty_axe" : 210,      			//( 75,  90) | AP: 0.40 | AE: 1.50
	"weapon.greataxe" : 203,                   			//( 80, 100) | AP: 0.40 | AE: 1.50
	"weapon.named_greataxe" : 304,             			//( 80, 100) | AP: 0.40 | AE: 1.50
	"weapon.orc_axe_2h" : 274,                 			//( 90, 120) | AP: 0.40 | AE: 1.60
	"weapon.named_orc_axe_2h" : 411,           			//( 90, 120) | AP: 0.40 | AE: 1.60

	//CLEAVER
	"weapon.orc_cleaver" : 0,                			//( 40,  70) | AP: 0.25 | AE: 1.10
	"weapon.legend_saw" : 0,                   			//( 15,  20) | AP: 0.25 | AE: 0.40
	"weapon.legend_cat_o_nine_tails" : 0,      			//( 10,  15) | AP: 0.10 | AE: 0.15
	"weapon.legend_bone_carver" : 0,          			//( 30,  60) | AP: 0.25 | AE: 1.00
	"weapon.thorned_whip" : 0,                			//( 15,  25) | AP: 0.10 | AE: 0.30
	"weapon.battle_whip" : 0,                 			//( 15,  30) | AP: 0.10 | AE: 0.25
	"weapon.named_battle_whip" : 0,          			//( 15,  30) | AP: 0.10 | AE: 0.25
	"weapon.antler_cleaver" : 0,              			//( 20,  30) | AP: 0.25 | AE: 0.75
	"weapon.legend_limb_lopper" : 0,         			//( 70,  90) | AP: 0.25 | AE: 1.30
	"weapon.legend_scythe" : 0,                			//( 15,  30) | AP: 0.25 | AE: 0.25
	"weapon.legend_grisly_scythe" : 0,        			//( 25,  35) | AP: 0.25 | AE: 0.50

	//1H
	"weapon.butchers_cleaver" : 10,            			//( 20,  35) | AP: 0.25 | AE: 0.75
	"weapon.legend_named_butchers_cleaver" : 110,		//( 35,  50) | AP: 0.25 | AE: 0.75
	"weapon.falx" : 52,                        			//( 25,  35) | AP: 0.25 | AE: 0.80
	"weapon.blunt_cleaver" : 0,               			//( 30,  40) | AP: 0.25 | AE: 0.80
	"weapon.scramasax" : 64,                   			//( 30,  45) | AP: 0.25 | AE: 0.80

	"weapon.military_cleaver" : 150,           			//( 40,  60) | AP: 0.25 | AE: 0.90
	"weapon.named_cleaver" : 225,              			//( 40,  60) | AP: 0.25 | AE: 0.90
	"weapon.named_orc_cleaver" : 225,          			//( 40,  70) | AP: 0.25 | AE: 1.10
	"weapon.khopesh" : 136,                    			//( 35,  55) | AP: 0.25 | AE: 1.20
	"weapon.named_khopesh" : 204,              			//( 35,  55) | AP: 0.25 | AE: 1.20
	"weapon.legend_khopesh" : 136,             			//( 40,  55) | AP: 0.25 | AE: 1.10

	//2H
	"weapon.two_handed_saif" : 136,            			//( 50,  70) | AP: 0.25 | AE: 0.90
	"weapon.two_handed_scimitar" : 151,        			//( 65,  85) | AP: 0.25 | AE: 1.10
	"weapon.named_two_handed_scimitar" : 227,  			//( 65,  85) | AP: 0.25 | AE: 1.10

	"weapon.legend_voulge" : 136,              			//( 60,  85) | AP: 0.25 | AE: 0.80
	"weapon.legend_military_voulge" : 166,     			//( 80, 100) | AP: 0.25 | AE: 0.90
	"weapon.legend_named_voulge" : 249,        			//( 80, 100) | AP: 0.25 | AE: 0.90

	"weapon.rusty_warblade" : 0,             			//( 60,  80) | AP: 0.25 | AE: 1.10
	"weapon.named_rusty_warblade" : 204,       			//( 60,  80) | AP: 0.25 | AE: 1.10
	"weapon.crypt_cleaver" : 166,              			//( 60,  80) | AP: 0.25 | AE: 1.20
	"weapon.named_crypt_cleaver" : 249,        			//( 60,  80) | AP: 0.25 | AE: 1.20
	"weapon.legend_great_khopesh" : 189,       			//( 75,  95) | AP: 0.25 | AE: 1.20
	"weapon.named_legend_great_khopesh" : 284, 			//( 75,  95) | AP: 0.25 | AE: 1.20

	//SPEAR
	"weapon.legend_wooden_spear" : 0,          			//( 15,  25) | AP: 0.25 | AE: 0.45

	//1H
	"weapon.militia_spear" : 52,               			//( 25,  30) | AP: 0.25 | AE: 0.90
	"weapon.ancient_spear" : 26,               			//( 20,  35) | AP: 0.25 | AE: 1.00

	"weapon.boar_spear" : 66,                  			//( 30,  35) | AP: 0.25 | AE: 0.95
	"weapon.firelance" : 86,                   			//( 30,  35) | AP: 0.25 | AE: 1.10

	"weapon.fighting_spear" : 150,             			//( 35,  40) | AP: 0.25 | AE: 1.00
	"weapon.named_spear" : 225,                			//( 35,  40) | AP: 0.25 | AE: 1.00

	"weapon.legend_militia_glaive" : 65,       			//( 30,  40) | AP: 0.25 | AE: 0.90
	"weapon.goblin_spear" : 55,                			//( 30,  40) | AP: 0.25 | AE: 0.70
	"weapon.named_goblin_spear" : 130,         			//( 30,  40) | AP: 0.25 | AE: 0.70

	"weapon.legend_glaive" : 120,              			//( 40,  45) | AP: 0.25 | AE: 0.95
	"weapon.legend_battle_glaive" : 150,       			//( 45,  50) | AP: 0.25 | AE: 1.00
	"weapon.legend_named_glaive" : 225,        			//( 45,  50) | AP: 0.25 | AE: 1.00

	//2H
	"weapon.goedendag" : 86,                   			//( 45,  75) | AP: 0.25 | AE: 1.10
	"weapon.legend_military_goedendag" : 129,  			//( 70, 100) | AP: 0.40 | AE: 1.25
	"weapon.legend_named_military_goedendag" : 194,		//( 80, 110) | AP: 0.40 | AE: 1.25

	//POLEARM
	"weapon.legend_wooden_pitchfork" : 0,      			//( 15,  35) | AP: 0.30 | AE: 0.20
	"weapon.pitchfork" : 6,                   			//( 30,  50) | AP: 0.30 | AE: 0.75
	"weapon.broken_bladed_pike" : 24,          			//( 35,  55) | AP: 0.30 | AE: 0.80
	"weapon.hooked_blade" : 24,                			//( 40,  70) | AP: 0.30 | AE: 1.10

	"weapon.goblin_pike" : 130,                 		//( 50,  70) | AP: 0.25 | AE: 0.90
	"weapon.named_goblin_pike" : 195,          			//( 50,  70) | AP: 0.25 | AE: 0.90
	"weapon.bladed_pike" : 140,                 		//( 55,  80) | AP: 0.30 | AE: 1.25
	"weapon.named_bladed_pikee" : 210,         			//( 55,  80) | AP: 0.30 | AE: 1.25
	"weapon.pike" : 150,                        		//( 60,  80) | AP: 0.30 | AE: 1.00
	"weapon.named_pike" : 225,                 			//( 60,  80) | AP: 0.30 | AE: 1.00
	"weapon.billhook" : 160,                   			//( 55,  85) | AP: 0.30 | AE: 1.40
	"weapon.named_billhook" : 240,             			//( 55,  85) | AP: 0.30 | AE: 1.40
	"weapon.swordlance" : 160,                 			//( 60,  80) | AP: 0.30 | AE: 0.90
	"weapon.named_swordlance" : 240,           			//( 60,  80) | AP: 0.30 | AE: 0.90
	"weapon.warscythe" : 160,                   		//( 55,  80) | AP: 0.30 | AE: 1.05
	"weapon.named_warscythe" : 240,            			//( 55,  80) | AP: 0.30 | AE: 1.05
	"weapon.legend_halberd" : 160,             			//( 60,  80) | AP: 0.30 | AE: 1.50
	"weapon.legend_named_halberd" : 240,       			//( 60,  80) | AP: 0.30 | AE: 1.50

	"weapon.warfork" : 64,                     			//( 40,  60) | AP: 0.25 | AE: 1.00
	"weapon.spetum" : 140,                      		//( 55,  75) | AP: 0.25 | AE: 1.00
	"weapon.named_spetum" : 210,               			//( 55,  75) | AP: 0.25 | AE: 1.00
	"weapon.legend_swordstaff" : 160,          			//( 50,  70) | AP: 0.25 | AE: 1.00
	"weapon.legend_named_swordstaff" : 240,    			//( 50,  70) | AP: 0.25 | AE: 1.00
	"weapon.legend_mage_swordstaff" : 420,     			//( 55,  75) | AP: 0.25 | AE: 1.00
	"weapon.named_royal_lance" : 300,          			//( 55,  70) | AP: 0.35 | AE: 1.00

	//FLAIL
	//1H
	"weapon.wooden_flail" : 0,                 			//( 10,  25) | AP: 0.30 | AE: 0.50

	"weapon.reinforced_wooden_flail" : 9,     			//( 20,  45) | AP: 0.30 | AE: 0.80
	"weapon.flail" : 48,                      			//( 25,  55) | AP: 0.30 | AE: 1.00
	"weapon.named_flail" : 72,                			//( 25,  55) | AP: 0.30 | AE: 1.00
	"weapon.three_headed_flail" : 100,         			//( 30,  75) | AP: 0.30 | AE: 1.00
	"weapon.named_three_headed_flail" : 150,   			//( 30,  75) | AP: 0.30 | AE: 1.00

	//2H
	"weapon.legend_ranged_wooden_flail" : 18,   		//( 20,  50) | AP: 0.30 | AE: 0.50
	"weapon.legend_pole_flail" : 140,          			//( 40,  70) | AP: 0.30 | AE: 1.00
	"weapon.legend_named_flail" : 210,         			//( 50,  80) | AP: 0.30 | AE: 1.00

	"weapon.two_handed_wooden_flail" : 48,     			//( 30,  60) | AP: 0.30 | AE: 0.80
	"weapon.legend_reinforced_flail" : 72,    			//( 35,  70) | AP: 0.30 | AE: 0.95
	"weapon.two_handed_flail" : 140,           			//( 45,  90) | AP: 0.30 | AE: 1.15
	"weapon.named_two_handed_flail" : 210,     			//( 45,  90) | AP: 0.30 | AE: 1.15

	"weapon.legend_chain" : 20,                			//( 15,  45) | AP: 0.20 | AE: 0.30
	"weapon.orc_flail_2h" : 50,               			//( 50, 100) | AP: 0.30 | AE: 1.25
	"weapon.named_orc_flail_2h" : 75,         			//( 50, 100) | AP: 0.30 | AE: 1.25


	//MACE
	"weapon.wooden_stick" : 0,                 			//( 15,  25) | AP: 0.40 | AE: 0.50
	"weapon.claw_club" : 0,                   			//( 20,  30) | AP: 0.40 | AE: 0.75
	"weapon.orc_wooden_club" : 0,             			//( 25,  40) | AP: 0.40 | AE: 0.75
	"weapon.orc_metal_club" : 0,              			//( 30,  50) | AP: 0.40 | AE: 0.90
	"weapon.legend_bough" : 0,               		//( 80, 110) | AP: 0.50 | AE: 1.35

	//1H
	"weapon.bludgeon" : 24,                     		//( 20,  35) | AP: 0.40 | AE: 0.75
	"weapon.nomad_mace" : 24,                  			//( 25,  35) | AP: 0.40 | AE: 0.90

	"weapon.light_southern_mace" : 36,         			//( 30,  40) | AP: 0.40 | AE: 1.10
	"weapon.morning_star" : 36,                			//( 30,  45) | AP: 0.40 | AE: 1.00

	"weapon.winged_mace" : 90,                			//( 35,  55) | AP: 0.40 | AE: 1.10
	"weapon.heavy_southern_mace" : 90,        			//( 35,  50) | AP: 0.40 | AE: 1.20
	"weapon.named_mace" : 151,                 			//( 35,  55) | AP: 0.40 | AE: 1.10

	//2H
	"weapon.legend_shovel" : 8,                			//( 20,  30) | AP: 0.40 | AE: 0.45
	"weapon.legend_named_shovel" : 0,        			//( 40,  55) | AP: 0.20 | AE: 0.80

	"weapon.legend_two_handed_club" : 15,      			//( 35,  60) | AP: 0.50 | AE: 1.00
	"weapon.two_handed_mace" : 27,            			//( 50,  75) | AP: 0.50 | AE: 1.15
	"weapon.two_handed_spiked_mace" : 0,      			//( 50,  70) | AP: 0.50 | AE: 1.15
	"weapon.named_two_handed_spiked_mace" : 151,		//( 50,  70) | AP: 0.50 | AE: 1.15
	"weapon.two_handed_flanged_mace" : 130,    			//( 75,  95) | AP: 0.50 | AE: 1.25
	"weapon.named_two_handed_mace" : 195,      			//( 75,  95) | AP: 0.50 | AE: 1.25

	"weapon.polemace" : 115,                   			//( 60,  75) | AP: 0.40 | AE: 1.20
	"weapon.named_polemace" : 195,             			//( 60,  75) | AP: 0.40 | AE: 1.20



	//HAMMER
	"weapon.legend_skullsmasher" : 0,        			//( 35,  50) | AP: 0.50 | AE: 2.25
	"weapon.axehammer" : 0,                   			//( 20,  30) | AP: 0.50 | AE: 2.00
	"weapon.legend_named_warhammer" : 0,     			//( 30,  45) | AP: 0.50 | AE: 2.50
	"weapon.legend_skullbreaker" : 0,        			//( 70, 100) | AP: 0.50 | AE: 2.10

	//1H
	"weapon.legend_hammer" : 6,                			//( 15,  20) | AP: 0.50 | AE: 1.50
	"weapon.legend_named_blacksmith_hammer" : 200,		//( 20,  30) | AP: 0.50 | AE: 2.00
	"weapon.pickaxe" : 8,                     			//( 15,  30) | AP: 0.50 | AE: 1.50

	"weapon.military_pick" : 47,               			//( 20,  35) | AP: 0.50 | AE: 2.00
	"weapon.warhammer" : 78,                  			//( 30,  40) | AP: 0.50 | AE: 2.25
	"weapon.named_warhammer" : 151,            			//( 30,  40) | AP: 0.50 | AE: 2.25


	//2H
	"weapon.two_handed_wooden_hammer" : 24,    			//( 40,  70) | AP: 0.50 | AE: 1.50

	"weapon.skull_hammer" : 0,               			//( 45,  65) | AP: 0.50 | AE: 1.80
	"weapon.named_skullhammer" : 151,          			//( 50,  70) | AP: 0.50 | AE: 1.80

	"weapon.polehammer" : 90,                 			//( 50,  75) | AP: 0.50 | AE: 1.85
	"weapon.named_polehammer" : 151,           			//( 50,  75) | AP: 0.50 | AE: 1.85

	"weapon.two_handed_hammer" : 120,          			//( 60,  90) | AP: 0.50 | AE: 2.00
	"weapon.named_two_handed_hammer" : 180,    			//( 60,  90) | AP: 0.50 | AE: 2.00

	//BOW
	"weapon.wonky_bow" : 0,                   			//( 30,  50) | AP: 0.35 | AE: 0.50

	"weapon.goblin_bow" : 42,                  			//( 25,  40) | AP: 0.35 | AE: 0.55
	"weapon.short_bow" : 48,                   			//( 30,  50) | AP: 0.35 | AE: 0.50
	"weapon.goblin_heavy_bow" : 54,            			//( 30,  50) | AP: 0.35 | AE: 0.60
	"weapon.named_goblin_heavy_bow" : 151,     			//( 30,  50) | AP: 0.35 | AE: 0.60
	"weapon.composite_bow" : 54,               			//( 40,  55) | AP: 0.35 | AE: 0.70

	"weapon.hunting_bow" : 60,                 			//( 40,  60) | AP: 0.35 | AE: 0.55
	"weapon.war_bow" : 151,                    			//( 50,  70) | AP: 0.35 | AE: 0.60
	"weapon.named_warbow" : 227,               			//( 50,  70) | AP: 0.35 | AE: 0.60
	"weapon.masterwork_bow" : 227,             			//( 50,  75) | AP: 0.35 | AE: 0.65

	//SLING
	"weapon.legend_sling" : 0,                			//( 25,  35) | AP: 0.35 | AE: 0.50
	"weapon.legend_slingshot" : 0,            			//( 10,  25) | AP: 0.40 | AE: 0.10
	//2H
	"weapon.staff_sling" : 12,                 			//( 25,  40) | AP: 0.35 | AE: 0.50
	"weapon.nomad_sling" : 18,                 			//( 35,  50) | AP: 0.35 | AE: 0.60
	"weapon.legend_slingstaff" : 40,          			//( 35,  45) | AP: 0.75 | AE: 1.10

	//THROWING
	"weapon.orc_javelin" : 0,                 			//( 30,  40) | AP: 0.45 | AE: 0.70
	"weapon.javelin" : 0,                     			//( 30,  45) | AP: 0.45 | AE: 0.75
	"weapon.throwing_axe" : 0,                			//( 25,  40) | AP: 0.25 | AE: 1.30
	"weapon.goblin_spiked_balls" : 0,         			//( 20,  35) | AP: 0.40 | AE: 0.70
	"weapon.heavy_javelin" : 0,               			//( 35,  50) | AP: 0.45 | AE: 0.80
	"weapon.heavy_throwing_axe" : 0,          			//( 30,  50) | AP: 0.25 | AE: 1.35
	"weapon.throwing_spear" : 0,              			//( 45,  70) | AP: 0.45 | AE: 1.10
	"weapon.named_javelin" : 0,              			//( 30,  45) | AP: 0.45 | AE: 0.75
	"weapon.named_throwing_axe" : 0,         			//( 25,  40) | AP: 0.25 | AE: 1.30

	//CROSSBOW
	"weapon.legend_blowgun" : 0,               			//( 10,  25) | AP: 0.10 | AE: 0.20
	"weapon.light_crossbow" : 0,              			//( 30,  50) | AP: 0.50 | AE: 0.60
	"weapon.crossbow" : 0,                    			//( 40,  60) | AP: 0.50 | AE: 0.70
	"weapon.goblin_crossbow" : 0,            			//( 50,  70) | AP: 0.50 | AE: 0.75
	"weapon.heavy_crossbow" : 0,             			//( 50,  70) | AP: 0.50 | AE: 0.75
	"weapon.named_crossbow" : 0,             			//( 50,  70) | AP: 0.50 | AE: 0.75

	//FIREARM
	"weapon.handgonne" : 0,                  			//( 35,  75) | AP: 0.25 | AE: 0.90
	"weapon.named_handgonne" : 0,            			//( 35,  75) | AP: 0.25 | AE: 0.90

	//MUSICAL
	"weapon.lute" : 0,                         			//(  5,  20) | AP: 0.40 | AE: 0.10
	"weapon.named_lute" : 0,                 			//( 15,  25) | AP: 0.40 | AE: 1.10
	"weapon.legend_drum" : 0,                 			//(  5,  10) | AP: 0.50 | AE: 0.20
	"weapon.barbarian_drum" : 0,              			//( 15,  20) | AP: 0.00 | AE: 0.00

	//STAFF
	"weapon.legend_staff" : 0,                 			//( 20,  30) | AP: 0.40 | AE: 0.30
	"weapon.legend_tipstaff" : 0,             			//( 30,  40) | AP: 0.40 | AE: 0.30
	"weapon.legend_mystic_staff" : 0,        			//( 40,  50) | AP: 0.40 | AE: 0.30
	"weapon.legend_staff_vala" : 0,          			//( 20,  30) | AP: 0.40 | AE: 0.60
	"weapon.legend_staff_gnarled" : 0,       			//( 60,  80) | AP: 0.40 | AE: 0.30
	"weapon.goblin_staff" : 0,               			//( 25,  35) | AP: 0.40 | AE: 0.70

//SHIELDS
	"shield.legend_mummy_shield" : 0,         			//DEF: (  8M,   8R) | DUR: -6.00 | STA: 26.00
	"shield.auxiliary_shield" : 0,             			//DEF: ( 15M,  15R) | DUR: -10.00 | STA: 16.00
	"shield.coffin_shield" : 0,               			//DEF: ( 15M,  20R) | DUR: -12.00 | STA: 20.00
	"shield.legend_mummy_tower_shield" : 0,   			//DEF: ( 15M,  30R) | DUR: -30.00 | STA: 52.00
	"shield.goblin_light_shield" : 0,          			//DEF: ( 10M,  10R) | DUR: -4.00 | STA: 12.00
	"shield.orc_light_shield" : 0,             			//DEF: ( 15M,  20R) | DUR: -12.00 | STA: 16.00
	"shield.goblin_heavy_shield" : 0,          			//DEF: ( 10M,  10R) | DUR: -8.00 | STA: 16.00
	"shield.orc_heavy_shield" : 0,            			//DEF: ( 15M,  15R) | DUR: -22.00 | STA: 72.00
	"shield.named_orc_heavy_shield" : 0,      			//DEF: ( 15M,  15R) | DUR: -22.00 | STA: 80.00 //TODO: remove from named drops
	"shield.craftable_lindwurm" : 0,          			//DEF: ( 17M,  25R) | DUR: -14.00 | STA: 64.00
	"shield.craftable_schrat" : 0,           			//DEF: ( 20M,  17R) | DUR: -12.00 | STA: 60.00
	"shield.craftable_kraken" : 0,           			//DEF: ( 24M,  24R) | DUR: -15.00 | STA: 50.00
	"shield.legend_craftable_greenwood_schrat" : 0,		//DEF: ( 30M,  25R) | DUR: -14.00 | STA: 72.00

	"shield.wooden_shield_old" : 14,            		//DEF: ( 15M,  15R) | DUR: -10.00 | STA: 16.00

	"shield.buckler" : 20,                      		//DEF: (  5M,   5R) | DUR: -4.00 | STA: 16.00
	"shield.faction_wooden_shield" : 38,        		//DEF: ( 15M,  15R) | DUR: -10.00 | STA: 24.00
	"shield.wooden_shield" : 38,               			//DEF: ( 15M,  15R) | DUR: -10.00 | STA: 24.00
	"shield.southern_light_shield" : 38,       			//DEF: ( 15M,  20R) | DUR: -10.00 | STA: 18.00

	"shield.worn_kite_shield" : 66,            			//DEF: ( 15M,  20R) | DUR: -16.00 | STA: 40.00
	"shield.faction_kite_shield" : 72,         			//DEF: ( 15M,  25R) | DUR: -16.00 | STA: 48.00
	"shield.kite_shield" : 72,                 			//DEF: ( 15M,  25R) | DUR: -16.00 | STA: 48.00
	"shield.named_bandit_kite_shield" : 700,    		//DEF: ( 15M,  25R) | DUR: -16.00 | STA: 60.00
	"shield.named_undead_kite_shield" : 700,    		//DEF: ( 15M,  25R) | DUR: -13.00 | STA: 60.00
	"shield.named_dragon" : 800,                		//DEF: ( 15M,  25R) | DUR: -16.00 | STA: 60.00
	"shield.named_red_white" : 800,             		//DEF: ( 15M,  25R) | DUR: -16.00 | STA: 60.00
	"shield.named_lindwurm" : 0,             			//DEF: ( 17M,  25R) | DUR: -14.00 | STA: 64.00 unused

	"shield.worn_heater_shield" : 66,          			//DEF: ( 20M,  15R) | DUR: -14.00 | STA: 24.00
	"shield.faction_heater_shield" : 72,       			//DEF: ( 20M,  15R) | DUR: -14.00 | STA: 32.00
	"shield.heater_shield" : 72,               			//DEF: ( 20M,  15R) | DUR: -14.00 | STA: 32.00
	"shield.named_bandit_heater" : 600,         		//DEF: ( 20M,  15R) | DUR: -14.00 | STA: 40.00
	"shield.named_undead_heater_shield" : 600,  		//DEF: ( 20M,  15R) | DUR: -11.00 | STA: 40.00
	"shield.named_rider_on_horse" : 1000,       		//DEF: ( 20M,  15R) | DUR: -14.00 | STA: 40.00
	"shield.named_wing" : 1000,                 		//DEF: ( 20M,  15R) | DUR: -14.00 | STA: 40.00
	"shield.named_full_metal_heater" : 1500,    		//DEF: ( 20M,  15R) | DUR: -16.00 | STA: 75.00

	"shield.metal_round_shield" : 120,          		//DEF: ( 18M,  18R) | DUR: -18.00 | STA: 60.00
	"shield.named_golden_round" : 240,         			//DEF: ( 19M,  17R) | DUR: -18.00 | STA: 75.00
	"shield.named_sipar_shield" : 240,         			//DEF: ( 18M,  18R) | DUR: -18.00 | STA: 75.00

	"shield.tower_shield" : 96,                			//DEF: ( 20M,  20R) | DUR: -20.00 | STA: 24.00
	"shield.legend_faction_tower_shield" : 96,			//DEF: ( 25M,  25R) | DUR: -30.00 | STA: 96.00
	"shield.legend_tower_shield" : 96,        			//DEF: ( 30M,  15R) | DUR: -30.00 | STA: 96.00

	"shield.gilders_embrace" : 10000,           		//DEF: ( 25M,  25R) | DUR: -16.00 | STA: 786.00

//LEGEND_ARMOR
	"legend_armor.body.legend_rabble_fur" : 0,                           		//DUR: 5.00 | STA: 0.00
	"legend_armor.body.legend_vala_dress" : 0,                          		//DUR: 50.00 | STA: 0.00
	"legend_armor.body.legend_vala_cloak" : 0,                         			//DUR: 80.00 | STA: 0.00
	"legend_armor.body.legend_seer_robes" : 0,                         			//DUR: 80.00 | STA: 8.00
	"legend_armor.body.cultist_leather_robe" : 0,                      			//DUR: 88.00 | STA: -9.00
	"legend_armor.body.legend_ranger_armor" : 0,                       			//DUR: 110.00 | STA: -6.00
	"legend_armor.body.legend_werewolf_hide" : 0,                      			//DUR: 100.00 | STA: -9.00
	"legend_armor.body.legend_armor_crusader" : 0,                    			//DUR: 160.00 | STA: -10.00
	"legend_armor.body.legend_armor_warlock_cloak" : 0,                			//DUR: 100.00 | STA: 4.00
	"legend_armor.body.black_leather" : 0,                            			//DUR: 110.00 | STA: -11.00
	"legend_armor.body.blue_studded_mail" : 0,                        			//DUR: 150.00 | STA: -18.00
	"legend_armor.body.named_plated_fur_armor" : 0,                   			//DUR: 130.00 | STA: -14.00
	"legend_armor.body.named_noble_mail_armor" : 0,                   			//DUR: 160.00 | STA: -15.00
	"legend_armor.body.named_skull_and_chain_armor" : 0,              			//DUR: 190.00 | STA: -24.00
	"legend_armor.body.heraldic_mail" : 0,                            			//DUR: 210.00 | STA: -26.00
	"legend_armor.body.golden_scale" : 0,                             			//DUR: 230.00 | STA: -30.00
	"legend_armor.body.named_bronze_armor" : 0,                       			//DUR: 300.00 | STA: -38.00
	"legend_armor.body.named_sellswords_armor" : 0,                  			//DUR: 260.00 | STA: -32.00
	"legend_armor.body.named_golden_lamellar_armor" : 0,             			//DUR: 285.00 | STA: -40.00
	"legend_armor.body.brown_coat_of_plates" : 0,                    			//DUR: 300.00 | STA: -36.00
	"legend_armor.body.green_coat_of_plates" : 0,                    			//DUR: 320.00 | STA: -42.00
	"legend_armor.body.legend_named_warlock_cloak" : 0,               			//DUR: 180.00 | STA: 8.00
	"legend_armor.body.lindwurm_armor" : 0,                           			//DUR: 300.00 | STA: -36.00
	"legend_armor.body.legend_mountain_armor" : 0,                   			//DUR: 400.00 | STA: -33.00
	"legend_armor.body.legend_mountain_armor_named" : 0,             			//DUR: 320.00 | STA: -42.00
	"legend_armor.body.legend_skin_armor" : 0,                       			//DUR: 160.00 | STA: -16.00

	//CLOTH & LEATHER
	"legend_armor.body.legend_bandages" : 0,                             		//DUR: 5.00 | STA: 0.00
	"legend_armor.body.legend_sackcloth_tattered" : 0,                   		//DUR: 5.00 | STA: 0.00
	"legend_armor.body.legend_sackcloth" : 0,                           		//DUR: 10.00 | STA: 0.00
	"legend_armor.body.legend_sackcloth_patched" : 0,                   		//DUR: 15.00 | STA: -1.00
	"legend_armor.body.legend_robes_wizard" : 0,                        		//DUR: 30.00 | STA: -1.00

	"legend_armor.body.legend_southern_shoulder_cloth" : 1,                    	//DUR: 5.00  | STA:  0.00
	"legend_armor.body.legend_southern_wrap_right" : 1,                    		//DUR: 2.00  | STA:  0.00
	"legend_armor.body.legend_ancient_cloth" : 14,                       		//DUR: 30.00 | STA: -5.00
	"legend_armor.body.legend_religious_scarf" : 14,                       		//DUR: 10.00 | STA:  0.00
	"legend_armor.body.tabbed_hood" : 14,                       				//DUR: 10.00 | STA: -1.00
	"legend_armor.body.legend_ancient_cloth_restored" : 24,              		//DUR: 35.00 | STA: -4.00
	"legend_armor.body.legend_peasant_dress" : 24,                       		//DUR: 25.00 | STA: -2.00
	"legend_armor.body.legend_robes" : 24,                               		//DUR: 25.00 | STA: -2.00
	"legend_armor.body.legend_robes_nun" : 24,                           		//DUR: 22.00 | STA: -1.00
	"legend_armor.body.legend_tunic" : 24,                               		//DUR: 20.00 | STA: -1.00
	"legend_armor.body.legend_tunic_collar_deep" : 24,                   		//DUR: 20.00 | STA: -1.00
	"legend_armor.body.legend_tunic_collar_thin" : 24,                   		//DUR: 20.00 | STA: -1.00
	"legend_armor.body.legend_tunic_wrap" : 24,                          		//DUR: 20.00 | STA: -1.00
	"legend_armor.body.relic_hood" : 24,                       					//DUR: 25.00 | STA: -2.00
	"legend_armor.body.legend_southern_robe" : 24,                       		//DUR: 25.00 | STA: -1.00
	"legend_armor.body.legend_southern_tunic" : 24,                      		//DUR: 25.00 | STA: -1.00
	"legend_armor.company_tabard" : 36,                        					//DUR: 10.00 | STA:  0.00

	"legend_armor.body.legend_thick_tunic" : 36,                         		//DUR: 30.00 | STA: -3.00
	"legend_armor.body.legend_apron_butcher" : 10,                       		//DUR: 30.00 | STA: -3.00
	"legend_armor.body.fur_cloak" : 36,                               			//DUR: 35.00 | STA: -6.00
	"legend_armor.body.legend_apron" : 36,                               		//DUR: 35.00 | STA: -4.00
	"legend_armor.body.undertakers_apron" : 36,                               	//DUR: 35.00 | STA: -4.00
	"legend_armor.body.legend_dark_tunic" : 36,                          		//DUR: 35.00 | STA: -4.00

	"legend_armor.body.legend_gladiator_harness" : 48,                  		//DUR: 40.00 | STA: -4.00
	"legend_armor.body.wanderers_coat" : 48,                  					//DUR: 45.00 | STA: -4.00

	"legend_armor.body.legend_padded_surcoat" : 150,                     		//DUR: 55.00 | STA: -6.00
	"legend_armor.body.legend_padded_surcoat_plain" : 150,               		//DUR: 55.00 | STA: -6.00
	"legend_armor.body.legend_southern_noble_surcoat" : 206,             		//DUR: 55.00 | STA: -6.00

	"legend_armor.body.legend_knightly_robe" : 312,                           	//DUR: 60.00 | STA: -2.00
	"legend_armor.body.legend_gambeson" : 188,                           		//DUR: 65.00 | STA: -8.00
	"legend_armor.body.legend_gambeson_plain" : 188,                     		//DUR: 65.00 | STA: -8.00
	"legend_armor.body.legend_southern_gambeson" : 188,                  		//DUR: 65.00 | STA: -8.00
	"legend_armor.body.legend_southern_split_gambeson" : 188,            		//DUR: 65.00 | STA: -8.00
	"legend.armor.body.gambeson_rare_color.cloth" : 188,                 		//DUR: 65.00 | STA: -5.00
	"legend_armor.body.legend_gambeson_wolf" : 196,                      		//DUR: 70.00 | STA: -9.00
	"legend_armor.body.legend_gambeson_named" : 282,                    		//DUR: 70.00 | STA: -7.00
	"legend_armor.body.anatomist_robe" : 196,                    				//DUR: 70.00 | STA: -7.00

	"legend_armor.body.legend_tunic_noble" : 176,                        		//DUR: 40.00 | STA: -2.00
	"legend_armor.named_tabard" : 176,                        					//DUR: 10.00 | STA:  0.00
	"legend_armor.body.legend_tunic_noble_named" : 264,                 		//DUR: 40.00 | STA: -2.00
	"legend_armor.body.legend_robes_magic" : 146,                        		//DUR: 40.00 | STA: -1.00 //fancy looking //FEATURE_9: magic rework

		//I
		"legend_armor.body.legend_southern_padded_chest" : 36,              		//DUR: 45.00 | STA: -4.00

		//II
		"legend_armor.body.legend_thick_furs_armor" : 0,                    		//DUR: 10.00 | STA: -1.00
		"legend_armor.body.legend_armor_leather_jacket_simple" : 0,         		//DUR: 15.00 | STA: -2.00
		"legend_armor.body.legend_armor_leather_jacket" : 0,                		//DUR: 25.00 | STA: -3.00
		"legend_armor.body.legend_animal_hide_armor" : 0,                  			//DUR: 30.00 | STA: -4.00
		"legend_armor.body.legend_reinforced_animal_hide_armor" : 0,       			//DUR: 55.00 | STA: -9.00
		"legend_armor.body.legend_armor_cult_armor" : 0,                   			//DUR: 55.00 | STA: -7.00
		"legend_armor.body.legend_hide_and_bone_armor" : 0,                			//DUR: 80.00 | STA: -11.00

		"legend_armor.body.legend_southern_arm_guards" : 36,                		//DUR: 30.00 | STA: -2.00
		"legend_armor.body.legend_southern_cloth" : 36,                      		//DUR: 30.00 | STA: -2.00
		"legend_armor.body.legend_southern_leather_jacket" : 36,            		//DUR: 30.00 | STA: -3.00
		"legend_armor.body.legend_armor_leather_jacket_named" : 81,         		//DUR: 30.00 | STA: -3.00
		"legend_armor.body.legend_armor_leather_studded_jacket_named" : 81, 		//DUR: 30.00 | STA: -3.00
		"legend_armor.body.legend_armor_leather_padded" : 63,               		//DUR: 40.00 | STA: -5.00
		"legend_armor.body.legend_southern_strips" : 63,                    		//DUR: 40.00 | STA: -4.00

		"legend_armor.body.legend_southern_leather_plates" : 135,            		//DUR: 50.00 | STA: -5.00
		"legend_armor.body.legend_armor_leather_lamellar" : 135,             		//DUR: 50.00 | STA: -6.00
		"legend_armor.body.legend_armor_leather_lamellar_reinforced" : 145,  		//DUR: 55.00 | STA: -7.00

		"legend_armor.body.wild_scale" : 206,               						//DUR: 60.00 | STA: -6.00
		"legend_armor.body.legend_armor_leather_noble" : 206,               		//DUR: 65.00 | STA: -6.00
		"legend_armor.body.legend_southern_padded" : 188,                    		//DUR: 65.00 | STA: -7.00
		"legend_armor.body.legend_armor_leather_brigandine" : 235,           		//DUR: 65.00 | STA: -8.00
		"legend_armor.body.legend_armor_leather_brigandine_named" : 353,    		//DUR: 75.00 | STA: -6.00

		"legend_armor.body.legend_southern_scale" : 196,                     		//DUR: 70.00 | STA: -10.00
		"legend_armor.body.legend_armor_leather_scale" : 196,                		//DUR: 70.00 | STA: -9.00

		"legend_armor.body.legend_armor_leather_riveted_light" : 259,        		//DUR: 80.00 | STA: -11.00
		"legend_armor.body.legend_armor_leather_riveted" : 285,              		//DUR: 95.00 | STA: -13.00
		"legend_armor.body.legend_armor_leather_brigandine_hardened" : 310, 		//DUR: 110.00 | STA: -15.00



	//CHAIN
	"legend_armor.body.legend_armor_rusty_mail_shirt" : 0,             			//DUR: 20.00 | STA: -4.00
	"legend_armor.body.legend_armor_reinforced_rotten_mail_shirt" : 0, 			//DUR: 45.00 | STA: -7.00
	"legend_armor.body.legend_armor_mail_shirt_simple" : 0,            			//DUR: 25.00 | STA: -3.00
	"legend_armor.body.legend_armor_ancient_mail" : 0,                 			//DUR: 35.00 | STA: -6.00
	"legend_armor.body.legend_armor_mail_shirt" : 188,                   		//DUR: 50.00 | STA: -6.00
	"legend_armor.body.legend_armor_short_mail" : 213,                   		//DUR: 60.00 | STA: -8.00
	"legend_armor.body.legend_armor_hauberk_sleevless" : 228,           		//DUR: 65.00 | STA: -7.00
	"legend_armor.body.legend_armor_ancient_double_mail" : 0,          			//DUR: 80.00 | STA: -14.00
	"legend_armor.body.legend_armor_basic_mail" : 228,                   		//DUR: 85.00 | STA: -12.00
	"legend_armor.body.legend_armor_reinforced_mail_shirt" : 253,       		//DUR: 80.00 | STA: -10.00
	"legend_armor.body.legend_noble_scale" : 316,       						//DUR: 80.00 | STA: -10.00
	"legend_armor.body.legend_armor_reinforced_worn_mail_shirt" : 0,   			//DUR: 65.00 | STA: -11.00

	"legend_armor.body.legend_armor_reinforced_worn_mail" : 0,        			//DUR: 105.00 | STA: -17.00
	"legend_armor.body.legend_armor_hauberk" : 300,                     		//DUR: 95.00 | STA: -11.00
	"legend_armor.body.legend_southern_mail" : 325,                     		//DUR: 100.00 | STA: -13.00
	"legend_armor.body.legend_heavy_mail" : 325,								//DUR: 105.00 | STA: -14.00
	"legend_armor.body.legend_armor_reinforced_mail" : 350,             		//DUR: 110.00 | STA: -15.00
	"legend_armor.body.legend_armor_hauberk_full" : 360,                		//DUR: 115.00 | STA: -14.00
	"legend_armor.body.legend_armor_hauberk_full_named" : 540,          		//DUR: 120.00 | STA: -15.00

	//PLATE
	"legend_armor.body.legend_armor_plate_ancient_gladiator" : 0,      			//DUR: 35.00 | STA: -6.00
	"legend_armor.body.legend_armor_plate_ancient_mail" : 0,           			//DUR: 45.00 | STA: -7.00
	"legend_armor.body.legend_armor_plate_ancient_scale_harness" : 0,  			//DUR: 75.00 | STA: -12.00
	"legend_armor.body.legend_armor_plate_ancient_scale_harness_restored" : 0,	//DUR: 130.00 | STA: -15.00
	"legend_armor.body.legend_armor_plate_ancient_chest" : 0,          			//DUR: 105.00 | STA: -18.00
	"legend_armor.body.legend_armor_scale_coat_rotten" : 0,            			//DUR: 60.00 | STA: -9.00
	"legend_armor.body.legend_armor_plate_ancient_scale" : 0,         			//DUR: 105.00 | STA: -17.00
	"legend_armor.body.legend_scrap_metal_armor" : 0,                  			//DUR: 65.00 | STA: -10.00
	"legend_armor.body.legend_armor_plate_ancient_chest_restored" : 0,			//DUR: 110.00 | STA: -15.00
	"legend_armor.body.legend_armor_plate_ancient_harness" : 0,       			//DUR: 115.00 | STA: -19.00
	"legend_armor.body.legend_armor_plate_chest_rotten" : 0,          			//DUR: 100.00 | STA: -16.00

	"legend_armor.body.legend_southern_plate_full" : 253,                		//DUR: 75.00 | STA: -12.00
	"legend_armor.body.legend_armor_scale_shirt" : 228,                 		//DUR: 85.00 | STA: -10.00
	"legend_armor.body.legend_rugged_scale_armor" : 0,                 			//DUR: 95.00 | STA: -15.00
	"legend_armor.body.legend_armor_scale" : 324,                       		//DUR: 100.00 | STA: -12.00


	"legend_armor.body.legend_heavy_iron_armor" : 420,                  		//DUR: 120.00 | STA: -18.00
	"legend_armor.body.legend_armor_scale_coat" : 445,                  		//DUR: 120.00 | STA: -15.00
	"legend_armor.body.legend_armor_scale_coat_named" : 668,            		//DUR: 160.00 | STA: -22.00
	"legend_armor.body.legend_armor_plate_chest" : 445,                 		//DUR: 125.00 | STA: -17.00
	"legend_armor.body.legend_armor_leather_lamellar_harness_heavy" : 445,		//DUR: 130.00 | STA: -20.00
	"legend_armor.body.legend_armor_leather_brigandine_hardened_full" : 465,	//DUR: 140.00 | STA: -19.00
	"legend_armor.body.legend_armor_leather_lamellar_heavy_named" : 727,		//DUR: 140.00 | STA: -23.00
	"legend_armor.body.legend_armor_leather_lamellar_harness_reinforced" : 485,//DUR: 150.00 | STA: -23.00

	"legend_armor.body.legend_armor_plate_ancient_scale_coat" : 0,    			//DUR: 140.00 | STA: -24.00
	"legend_armor.body.legend_armor_plate_cuirass" : 510,               		//DUR: 150.00 | STA: -21.00
	"legend_armor.body.legend_southern_leather_scale" : 510,            		//DUR: 155.00 | STA: -26.00
	"legend_armor.body.legend_southern_plate" : 510,                    		//DUR: 155.00 | STA: -26.00
	"legend_armor.body.legend_thick_plated_barbarian_armor" : 0,      			//DUR: 155.00 | STA: -26.00

	"legend_armor.body.legend_armor_plate_full" : 535,                  		//DUR: 160.00 | STA: -22.00
	"legend_armor.body.legend_armor_leather_lamellar_heavy" : 535,      		//DUR: 165.00 | STA: -24.00
	"legend_armor.body.legend_armor_plate_ancient_scale_coat_restored" : 0,		//DUR: 170.00 | STA: -23.00
	"legend_armor.body.legend_armor_plate_full_greaves" : 535,          		//DUR: 170.00 | STA: -26.00
	"legend_armor.body.legend_armor_plate_krastenbrust" : 535,          		//DUR: 170.00 | STA: -26.00
	"legend_armor.body.legend_armor_plate_milanese" : 535,              		//DUR: 170.00 | STA: -26.00
	"legend_armor.body.legend_armor_plate_triangle" : 535,              		//DUR: 170.00 | STA: -26.00
	"legend_armor.body.legend_armor_plate_full_greaves_painted" : 535, 			//DUR: 170.00 | STA: -26.00
	"legend_armor.body.legend_armor_plate_full_greaves_named" : 803,   			//DUR: 170.00 | STA: -26.00

	"legend_armor.body.legend_southern_named_golden_plates" : 635,      		//DUR: 200.00 | STA: -36.00
	"legend_armor.body.legend_southern_named_plates" : 1000,             		//DUR: 210.00 | STA: -25.00

	"legend_armor.body.ijirok_armor" : 12000,                            		//DUR: 320.00 | STA: -32.00
	"legend_armor.body.armor_of_davkul" : 12000,                         		//DUR: 270.00 | STA: -18.00
	"legend_armor.body.emperors_armor" : 20000,                          		//DUR: 380.00 | STA: -30.00

	//III
	"legend_armor.body.legend_common_tabard" : 40,                             	//DUR: 10.00 | STA: 0.00
	"legend_armor.body.legend_southern_tabard" : 40,                             //DUR: 10.00 | STA: 0.00
	"legend_armor.named_tabard" : 264,                                  		//DUR: 10.00 | STA: 0.00

	//VI //FEATURE_5: only the redback silk cloak looks good, possible use it again in future
	"legend_armor.body.lindwurm_scales" : 0,                          			//DUR: 25.00 | STA: -2.00
	"legend_armor.body.legend_stollwurm_scales" : 0,                  			//DUR: 30.00 | STA: -4.00
	"legend_armor.body.serpent_skin" : 0,                              			//DUR: 25.00 | STA: -2.00
	"legend_armor.body.legend_shoulder_cloth" : 0,                      		//DUR: 5.00 | STA: 0.00
	"legend_armor.body.legend_armor_cloak_common" : 0,                 			//DUR: 10.00 | STA: -1.00
	"legend_armor.body.legend_southern_scarf" : 0,                     			//DUR: 5.00 | STA: 0.00
	"legend_armor.body.legend_dark_wooly_cloak" : 0,                   			//DUR: 15.00 | STA: -2.00
	"legend_armor.body.legend_sash" : 0,                               			//DUR: 3.00 | STA: 0.00
	"legend_armor.body.legend_southern_scarf_wrap" : 0,                			//DUR: 15.00 | STA: -1.00
	"legend_armor.body.legend_animal_pelt" : 0,                        			//DUR: 15.00 | STA: -2.00
	"legend_armor.body.legend_noble_shawl" : 0,                        			//DUR: 10.00 | STA: 0.00
	"legend_armor.body.legend_armor_cloak_crusader" : 0,               			//DUR: 35.00 | STA: -5.00
	"legend_armor.body.legend_armor_cloak_heavy" : 0,                  			//DUR: 30.00 | STA: -4.00
	"legend_armor.body.unhold_fur" : 0,                               			//DUR: 25.00 | STA: -2.00
	"legend_armor.body.legend_armor_cloak_noble" : 0,                 			//DUR: 25.00 | STA: -2.00
	"legend_armor.body.legend_redback_cloak" : 0,                     			//DUR: 10.00 | STA: -1.00
	"legend_armor.body.legend_hexe_leader_cloak" : 0,                 			//DUR: 25.00 | STA: -2.00
	"legend_armor_upgrade.legend_redback_cloak" : 0,                  			//DUR: 35.00 | STA: -3.00
	"legend_armor_upgrade.legend_hexe_leader_cloak" : 0,             			//DUR: 20.00 | STA: 0.00
	"legend_armor.cloak_rich" : 0,                                   			//DUR: 35.00 | STA: -2.00
	"legend_armor.cloak_emperor" : 0,                                			//DUR: 40.00 | STA: -3.00

	//V
	"armor_upgrade.hyena_fur" : 0,                                     			//DUR: 10.00 | STA: 0.00
	"legend_armor_upgrade.lindwurm_scales" : 0,                       			//DUR: 20.00 | STA: -1.00
	"legend_armor_upgrade.legend_stollwurm_scales" : 0,               			//DUR: 40.00 | STA: -2.00
	"legend_armor_upgrade.serpent_skin" : 0,                           			//DUR: 20.00 | STA: -3.00
	"legend_armor_upgrade.additional_padding" : 0,                    			//DUR: 1.00 | STA: -2.00 -35%
	"legend_armor_upgrade.unhold_fur" : 0,
	"legend_armor_upgrade.protective_runes" : 0,
	"legend_armor_upgrade.light_padding_replacement" : 0,             		//DUR: 10.00 | STA: 0.00
	"legend_armor_upgrade.bone_platings" : 0,

	"legend_armor_upgrade.legend_skull_chain" : 36,                 			//DUR: 10.00 | STA: -2.00 +20% chance to hit head
	"legend_armor_upgrade.legend_sacred_shield" : 36,                 			//DUR: 10.00 | STA: -1.00 +5% resolve
	"legend_armor_upgrade.legend_spiked_collar" : 36,                 			//DUR: 20.00 | STA: -3.00
	"legend_armor_upgrade.leather_shoulderguards" : 36,                 		//DUR: 30.00 | STA: -2.00
	"legend_armor_upgrade.barbarian_horn" : 45,                         		//DUR: 40.00 | STA: -3.00
	"armor_upgrade.light_gladiator_upgrade" : 56,                       		//DUR: 45.00 | STA: -2.00
	"legend_armor_upgrade.metal_pauldrons" : 78,                        		//DUR: 60.00 | STA: -6.00
	"legend_armor_upgrade.heraldic_plates" : 78,                       			//DUR: 60.00 | STA: -10.00 +10 resolve
	"armor_upgrade.heavy_gladiator_upgrade" : 98,                       		//DUR: 75.00 | STA: -6.00

	"legend_armor_upgrade.double_mail" : 54,                            		//DUR: 20.00 | STA: 0.00 -10%, +20% fat
	"legend_armor_upgrade.metal_plating" : 68,                          		//DUR: 10.00 | STA: 0.00 -15%, +25% fat
	"legend_armor_upgrade.mail_patch" : 168,                             		//DUR: 20.00 | STA: -3.00, Taunts
	"legend_armor_upgrade.leather_neckguard" : 85,                      		//DUR: 10.00 | STA: -2.00 -20%
	"legend_armor_upgrade.mail_patch" : 107,                             		//DUR: 20.00 | STA: -4.00 -25%
	"legend_armor_upgrade.joint_cover" : 134,                            		//DUR: 30.00 | STA: -6.00 -30%
	"legend_armor_upgrade.pauldron_named" : 168,                            	//DUR: 30.00 | STA: -4.00 -30%
	"legend_armor_upgrade.pauldron_swan" : 186,                            		//DUR: 40.00 | STA: -3.00 -30%
	"legend_armor_upgrade.horn_plate" : 252,                            		//DUR: 40.00 | STA: -6.00 -35%
	"legend_armor_upgrade.pauldron" : 201,                            			//DUR: 50.00 | STA: -8.00 -40%
	"legend_armor_upgrade.pauldron_heavy" : 201,                            	//DUR: 60.00 | STA: -8.00 -40%
	"legend_armor_upgrade.pauldron_stag" : 201,                            		//DUR: 60.00 | STA: -8.00 -40%
	"legend_armor_upgrade.pauldron_strong" : 232,                            	//DUR: 55.00 | STA: -6.00 -40%

	"legend_armor_upgrade.direwolf_pelt" : 250,                          		//DUR: 10.00 | STA: 0.00
	"legend_armor_upgrade.legend_white_wolf_pelt" : 500,                		//DUR: 30.00 | STA: -2.00

//LEGEND_HELMETS
	"armor.head.legend_helmet_goblin_scarf" : 0,                         		//DUR: 5.00 | STA: 0.00
	"armor.head.legend_helmet_mummy_bandage" : 0,                        		//DUR: 5.00 | STA: 0.00
	"armor.head.legend_helmet_rotten_chain_scarf" : 0,                  		//DUR: 50.00 | STA: -3.00
	"armor.head.legend_helmet_barb_chain_scarf" : 0,                   			//DUR: 55.00 | STA: -3.00
	"armor.head.legend_helmet_barb_leather_cap" : 0,                    		//DUR: 25.00 | STA: 0.00
	"armor.head.legend_helmet_barb_open_chain" : 0,                    			//DUR: 65.00 | STA: -3.00
	"armor.head.legend_helmet_rusty_chain_hood" : 0,                   			//DUR: 70.00 | STA: -4.00
	"armor.head.legend_helmet_barb_metal_cap" : 0,                     			//DUR: 40.00 | STA: -2.00
	"armor.head.legend_helmet_barb_ritual_helm" : 0,                  			//DUR: 190.00 | STA: -16.00
	"armor.head.legend_helmet_ancient_conic_helm" : 0,                 			//DUR: 60.00 | STA: -6.00
	"armor.head.legend_helmet_ancient_crested" : 0,                    			//DUR: 60.00 | STA: -6.00
	"armor.head.legend_helmet_ancient_dome" : 0,                       			//DUR: 60.00 | STA: -6.00
	"armor.head.legend_helmet_ancient_kettle" : 0,                     			//DUR: 60.00 | STA: -6.00
	"armor.head.legend_helmet_ancient_dome_tailed" : 0,                			//DUR: 95.00 | STA: -9.00
	"armor.head.legend_helmet_ancient_face_plate" : 0,                 			//DUR: 95.00 | STA: -9.00
	"armor.head.legend_helmet_ancient_legionaire" : 0,                 			//DUR: 95.00 | STA: -9.00
	"armor.head.legend_helmet_ancient_side_hawk" : 0,                  			//DUR: 95.00 | STA: -9.00
	"armor.head.legend_helmet_ancient_tailed_conic_helm" : 0,          			//DUR: 95.00 | STA: -9.00
	"armor.head.legend_helmet_ancient_face_helm" : 0,                  			//DUR: 120.00 | STA: -10.00
	"armor.head.legend_helmet_ancient_beard_mask" : 0,                 			//DUR: 130.00 | STA: -12.00
	"armor.head.legend_helmet_ancient_lion_mask" : 0,                  			//DUR: 130.00 | STA: -12.00
	"armor.head.legend_helmet_ancient_mask" : 0,                       			//DUR: 130.00 | STA: -12.00
	"armor.head.legend_helmet_legend_ancient_legionaire_restored" : 0, 			//DUR: 140.00 | STA: -9.00
	"armor.head.legend_helmet_legend_ancient_gladiator" : 0,          			//DUR: 150.00 | STA: -11.00
	"armor.head.legend_helmet_orc_great_helm" : 0,                    			//DUR: 280.00 | STA: -32.00
	"armor.head.legend_helmet_orc_strapped_helm" : 0,                  			//DUR: 160.00 | STA: -18.00
	"armor.head.legend_helmet_rotten_flat_top_face_mask" : 0,          			//DUR: 110.00 | STA: -8.00
	"armor.head.legend_helmet_orc_behemoth_helmet" : 0,                			//DUR: 180.00 | STA: -20.00
	"armor.head.legend_helmet_orc_double_helm" : 0,                   			//DUR: 190.00 | STA: -22.00
	"armor.head.legend_helmet_orc_scale_helm" : 0,                    			//DUR: 250.00 | STA: -30.00
	"armor.head.legend_helmet_orc_elite_double_helm" : 0,             			//DUR: 225.00 | STA: -25.00
	"armor.head.legend_helmet_crude_metal_helm" : 0,                   			//DUR: 110.00 | STA: -8.00
	"armor.head.legend_helmet_crude_cylinder_helm" : 0,                			//DUR: 155.00 | STA: -12.00
	"armor.head.legend_helmet_crude_skull_helm" : 0,                  			//DUR: 150.00 | STA: -9.00
	"armor.head.legend_helmet_rotten_great_helm" : 0,                  			//DUR: 150.00 | STA: -14.00
	"armor.head.legend_helmet_orc_metal_mask" : 0,


	//CLOTH & LEATHER
	"armor.head.legend_helmet_southern_headband_coin" : 5,              		//DUR: 5.00 | STA: 0.00
	"armor.head.legend_helmet_cloth_cap" : 0,                           		//DUR: 15.00 | STA: 0.00
	"armor.head.legend_helmet_cloth_scarf" : 0,                         		//DUR: 15.00 | STA: 0.00
	"armor.head.legend_helmet_cloth_bandana" : 0,                       		//DUR: 15.00 | STA: 0.00
	"armor.head.legend_helmet_southern_cap" : 0,                        		//DUR: 20.00 | STA: 0.00
	"armor.head.legend_helmet_southern_cap_dark" : 0,                   		//DUR: 20.00 | STA: 0.00
	"armor.head.legend_helmet_patched_hood" : 0,                        		//DUR: 25.00 | STA: -1.00

	"armor.head.legend_helmet_southern_leather_helm" : 28,               		//DUR: 15.00 | STA: -1.00
	"legend_armor.body.dukes_cloak" : 28,               						//DUR: 20.00 | STA: -2.00
	"legend_armor.body.decorative_hood" : 28,                         			//DUR: 30.00 | STA: -2.00
	"armor.head.legend_helmet_southern_studded_leather_helm" : 28,      		//DUR: 25.00 | STA: -1.00
	"armor.head.legend_helmet_full_mask" : 28,                        			//DUR: 25.00 | STA: -1.00

	"legend_armor.body.anatomist_hood" : 28,                         			//DUR: 30.00 | STA: -2.00
	"armor.head.legend_helmet_simple_hood" : 28,                         		//DUR: 30.00 | STA: -1.00
	"armor.head.legend_helmet_leather_cap" : 32,                         		//DUR: 35.00 | STA: -1.00
	"armor.head.legend_helmet_padded_cap" : 36,                          		//DUR: 40.00 | STA: -1.00
	"armor.head.legend_helmet_southern_open_hood" : 36,                  		//DUR: 40.00 | STA: -1.00
	"armor.head.legend_helmet_southern_turban_light_hood" : 36,          		//DUR: 40.00 | STA: -1.00
	"armor.head.legend_helmet_southern_niqaab" : 40,                    		//DUR: 45.00 | STA: -1.00
	"armor.head.legend_helmet_leather_hood" : 40,                       		//DUR: 45.00 | STA: -2.00
	"armor.head.legend_helmet_padded_hood" : 40,                        		//DUR: 50.00 | STA: -2.00
	"armor.head.legend_helmet_beak_hood" : 50,                        			//DUR: 65.00 | STA: -3.00


	//CHAIN
	"armor.head.legend_helmet_aventail" : 60,                           		//DUR: 60.00 | STA: -3.00
	"armor.head.legend_helmet_chain_scarf" : 60,                        		//DUR: 55.00 | STA: -3.00
	"armor.head.legend_helmet_southern_open_chain_hood" : 60,           		//DUR: 65.00 | STA: -3.00
	"armor.head.legend_helmet_open_chain_hood" : 60,                    		//DUR: 65.00 | STA: -3.00
	"armor.head.legend_helmet_southern_chain_hood" : 90,                		//DUR: 75.00 | STA: -4.00
	"armor.head.legend_helmet_chain_hood" : 90,                         		//DUR: 75.00 | STA: -4.00
	"armor.head.legend_faction_helmet" : 90,                            		//DUR: 80.00 | STA: -4.00 //chain hood
	"armor.head.legend_helmet_chain_hood_full" : 120,                    		//DUR: 85.00 | STA: -5.00
	"armor.head.legend_helmet_bronze_chain" : 120,                       		//DUR: 90.00 | STA: -6.00

	//Plate
	"armor.head.legend_helmet_southern_cap_smooth" : 92,                		//DUR: 40.00 | STA: -2.00
	"armor.head.legend_helmet_southern_cap_spiked" : 92,                		//DUR: 40.00 | STA: -2.00

	"armor.head.legend_helmet_norman_helm" : 115,                        		//DUR: 50.00 | STA: -3.00
	"armor.head.legend_helmet_sallet" : 115,                             		//DUR: 50.00 | STA: -2.00
	"armor.head.legend_helmet_viking_helm" : 115,                        		//DUR: 55.00 | STA: -3.00
	"armor.head.legend_helmet_sallet_named" : 172,                        		//DUR: 55.00 | STA: -2.00
	"armor.head.legend_helmet_horsetail" : 115,                          		//DUR: 60.00 | STA: -3.00
	"armor.head.legend_helmet_enclave_skullcap" : 115,                   		//DUR: 65.00 | STA: -4.00

	"armor.head.legend_helmet_flat_top_helm_low" : 144,                  		//DUR: 70.00 | STA: -4.00
	"armor.head.legend_helmet_dentist_helmet" : 144,                    		//DUR: 70.00 | STA: -3.00
	"armor.head.legend_helmet_kettle_helm_low" : 144,                    		//DUR: 75.00 | STA: -5.00
	"armor.head.legend_helmet_scale_helm" : 144,                         		//DUR: 75.00 | STA: -5.00
	"armor.head.legend_helmet_southern_conic_helm" : 144,               		//DUR: 75.00 | STA: -4.00
	"armor.head.legend_helmet_barbute" : 144,                           		//DUR: 75.00 | STA: -3.00
	"armor.head.legend_helmet_barbute_named" : 216,                     		//DUR: 85.00 | STA: -4.00
	"armor.head.legend_helmet_basinet" : 144,                           		//DUR: 80.00 | STA: -5.00
	"armor.head.legend_helmet_flat_top_helm" : 144,                      		//DUR: 85.00 | STA: -5.00
	"armor.head.legend_helmet_rondel_helm" : 144,                        		//DUR: 85.00 | STA: -6.00
	"armor.head.legend_helmet_southern_named_conic" : 144,              		//DUR: 85.00 | STA: -3.00
	"armor.head.legend_helmet_bascinet_named" : 216,                    		//DUR: 90.00 | STA: -4.00

	"armor.head.legend_helmet_italo_norman_helm" : 180,                  		//DUR: 90.00 | STA: -6.00
	"armor.head.legend_helmet_italo_norman_helm_named" : 270,           		//DUR: 110.00 | STA: -5.00
	"armor.head.legend_helmet_enclave_bevor" : 180,                      		//DUR: 95.00 | STA: -7.00
	"armor.head.legend_helmet_kettle_helm_med" : 180,                    		//DUR: 95.00 | STA: -7.00
	"armor.head.legend_helmet_giles_helm" : 180,             					//DUR: 100.00 | STA: -6.00
	"armor.head.legend_helmet_flat_top_helm_polished" : 180,             		//DUR: 100.00 | STA: -5.00
	"armor.head.legend_helmet_deep_sallet" : 180,                       		//DUR: 100.00 | STA: -5.00
	"armor.head.legend_helmet_deep_sallet_named" : 270,                 		//DUR: 105.00 | STA: -6.00
	"armor.head.legend_helmet_wallace_sallet" : 180,                    		//DUR: 105.00 | STA: -7.00
	"armor.head.legend_helmet_wallace_sallet_named" : 270,              		//DUR: 110.00 | STA: -6.00
	"armor.head.legend_helmet_carthaginian" : 180,                      		//DUR: 105.00 | STA: -5.00
	"armor.head.legend_helmet_skin_helm" : 180,                        			//DUR: 105.00 | STA: -5.00

	"armor.head.legend_helmet_nordic_helm_low" : 225,                    		//DUR: 110.00 | STA: -7.00
	"armor.head.legend_helmet_conic_helm" : 225,                         		//DUR: 110.00 | STA: -6.00
	"armor.head.legend_helmet_kettle_helm" : 225,                        		//DUR: 115.00 | STA: -8.00
	"armor.head.legend_helmet_bronze_helm" : 225,                       		//DUR: 115.00 | STA: -8.00
	"armor.head.legend_helmet_southern_peaked_helm" : 225,              		//DUR: 115.00 | STA: -8.00
	"armor.head.legend_helmet_flat_top_face_plate" : 225,                		//DUR: 120.00 | STA: -9.00
	"armor.head.legend_helmet_kettle_hat" : 225,                				//DUR: 120.00 | STA: -9.00
	"armor.head.legend_helmet_kettle_helm_high" : 225,                   		//DUR: 125.00 | STA: -9.00
	"armor.head.legend_helmet_kettle_helm_named" : 338,                 		//DUR: 130.00 | STA: -9.00
	"armor.head.legend_helmet_nordic_helm" : 225,                       		//DUR: 125.00 | STA: -8.00
	"armor.head.legend_helmet_southern_helmet_nasal" : 225,             		//DUR: 125.00 | STA: -7.00
	"armor.head.legend_helmet_southern_gladiator_helm_crested" : 225,   		//DUR: 130.00 | STA: -6.00
	"armor.head.legend_helmet_southern_gladiator_helm_masked" : 225,    		//DUR: 130.00 | STA: -6.00
	"armor.head.legend_helmet_southern_gladiator_helm_split" : 225,     		//DUR: 130.00 | STA: -6.00
	"armor.head.legend_helmet_nordic_helm_high" : 225,                  		//DUR: 135.00 | STA: -8.00

	"armor.head.legend_helmet_tailed_conic" : 281,                      		//DUR: 140.00 | STA: -8.00
	"armor.head.legend_helmet_enclave_armet" : 281,                     		//DUR: 140.00 | STA: -9.00
	"armor.head.legend_helmet_enclave_kettle" : 281,                    		//DUR: 145.00 | STA: -10.00
	"armor.head.legend_helmet_southern_peaked_nasal_helm" : 281,        		//DUR: 150.00 | STA: -11.00
	"armor.head.legend_helmet_legend_armet" : 281,                      		//DUR: 155.00 | STA: -11.00
	"armor.head.legend_helmet_legend_armet_01_named" : 421,             		//DUR: 170.00 | STA: -11.00
	"armor.head.legend_helmet_legend_frogmouth" : 281,                  		//DUR: 160.00 | STA: -10.00
	"armor.head.legend_helmet_legend_frogmouth_close" : 281,            		//DUR: 160.00 | STA: -10.00
	"armor.head.legend_helmet_heavy_spiked_helm" : 281,                 		//DUR: 165.00 | STA: -10.00

	"armor.head.legend_helmet_great_helm" : 351,                        		//DUR: 175.00 | STA: -12.00
	"armor.head.legend_helmet_heavy_plate_helm" : 351,                  		//DUR: 175.00 | STA: -15.00
	"armor.head.legend_helmet_heavy_plate_helm_named" : 527,            		//DUR: 185.00 | STA: -14.00
	"armor.head.legend_helmet_enclave_great_helm" : 351,                		//DUR: 180.00 | STA: -12.00
	"armor.head.legend_helmet_enclave_great_bascinet" : 351,            		//DUR: 180.00 | STA: -13.00
	"armor.head.legend_helmet_full_helm" : 351,            						//DUR: 180.00 | STA: -13.00
	"armor.head.legend_helmet_enclave_venitian_bascinet" : 351,         		//DUR: 185.00 | STA: -14.00
	"armor.head.legend_helmet_stag_helm" : 351,                         		//DUR: 200.00 | STA: -15.00
	"armor.head.legend_helmet_swan_helm" : 351,                         		//DUR: 200.00 | STA: -15.00


	//TOP
	"armor.head.legend_helmet_mummy_beard" : 0,                        			//DUR: 15.00 | STA: -1.00
	"armor.head.legend_helmet_goblin_leaves" : 0,                        		//DUR: 5.00 | STA: 0.00
	"armor.head.legend_helmet_hood_cloth_round" : 0,                     		//DUR: 5.00 | STA: 0.00
	"armor.head.legend_helmet_hood_cloth_square" : 0,                    		//DUR: 5.00 | STA: 0.00
	"armor.head.legend_helmet_hood_cloth_wide" : 0,                      		//DUR: 5.00 | STA: 0.00
	"armor.head.legend_helmet_cloth_long_hood" : 0,                     		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_headband_nose" : 0,                       		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_headband_side" : 0,                       		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_goblin_leather_mask" : 0,                 		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_cult_hood" : 0,                           		//DUR: 15.00 | STA: -1.00
	"armor.head.legend_helmet_nose_plate" : 0,                          		//DUR: 15.00 | STA: -1.00
	"armor.head.legend_helmet_goblin_gillie" : 0,                       		//DUR: 15.00 | STA: -1.00
	"armor.head.legend_helmet_goblin_leaf_helm" : 0,                   			//DUR: 25.00 | STA: -1.00
	"armor.head.legend_helmet_southern_veil" : 0,                      			//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_veil_coin" : 0,                 			//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_vampire_crown" : 0,                      			//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_goblin_leather_helm" : 0,                			//DUR: 25.00 | STA: -1.00
	"armor.head.legend_helmet_eyemask" : 0,                            			//DUR: 15.00 | STA: 0.00
	"armor.head.legend_helmet_goblin_chain_helm" : 0,                  			//DUR: 30.00 | STA: -3.00
	"armor.head.legend_helmet_goblin_spiked_helm" : 0,                 			//DUR: 35.00 | STA: -4.00
	"armor.head.legend_helmet_facemask" : 0,                           			//DUR: 20.00 | STA: -1.00
	"armor.head.legend_helmet_orc_leather_mask" : 0,                   			//DUR: 45.00 | STA: -6.00

	"armor.head.legend_helmet_faceplate_short" : 140,                    		//DUR: 30.00 | STA: -2.00
	"armor.head.legend_helmet_wallace_sallet_visor" : 150,               		//DUR: 20.00 | STA: -1.00
	"armor.head.legend_helmet_faceplate_long" : 180,                     		//DUR: 35.00 | STA: -3.00
	"armor.head.legend_helmet_ancient_crown" : 200,                      		//DUR: 20.00 | STA: -2.00
	"armor.head.legend_helmet_orc_horn_mask" : 200,                      		//DUR: 60.00 | STA: -8.00
	"armor.head.legend_helmet_fencer_hat" : 225,                         		//DUR: 15.00 | STA: 0.00
	"armor.head.legend_helmet_unhold_head_chain" : 240,                  		//DUR: 45.00 | STA: -7.00
	"armor.head.legend_helmet_chain_attachment" : 250,                   		//DUR: 25.00 | STA: -1.00
	"armor.head.legend_helmet_enclave_armet_visor" : 300,                		//DUR: 35.00 | STA: -2.00
	"armor.head.legend_helmet_faceplate_curved" : 300,                   		//DUR: 35.00 | STA: -2.00
	"armor.head.legend_helmet_faceplate_flat" : 300,                     		//DUR: 35.00 | STA: -2.00
	"armor.head.legend_helmet_faceplate_full_breaths" : 300,             		//DUR: 35.00 | STA: -2.00
	"armor.head.legend_helmet_faceplate_sharp" : 300,                    		//DUR: 35.00 | STA: -2.00
	"armor.head.legend_helmet_leather_hood_barb" : 300,                  		//DUR: 45.00 | STA: -4.00
	"armor.head.legend_helmet_enclave_great_jaw" : 350,                  		//DUR: 50.00 | STA: -5.00
	"armor.head.legend_helmet_orc_metal_mask" : 400,                     		//DUR: 75.00 | STA: -11.00
	"armor.head.legend_helmet_mummy_mask" : 450,                         		//DUR: 40.00 | STA: -3.00
	"armor.head.legend_helmet_enclave_venitian_bascinet_visor" : 500,    		//DUR: 45.00 | STA: -3.00
	"armor.head.legend_helmet_faceplate_snub_nose" : 500,                		//DUR: 45.00 | STA: -3.00
	"armor.head.legend_helmet_faceplate_snub_slit" : 500,                		//DUR: 45.00 | STA: -2.00
	"armor.head.legend_helmet_faceplate_pointed" : 600,                  		//DUR: 50.00 | STA: -4.00
	"armor.head.legend_helmet_faceplate_pointed_slit" : 600,             		//DUR: 50.00 | STA: -4.00
	"armor.head.legend_helmet_faceplate_winged" : 600,                   		//DUR: 45.00 | STA: -4.00
	"armor.head.legend_helmet_southern_faceplate_bearded" : 700,         		//DUR: 60.00 | STA: -5.00
	"armor.head.legend_helmet_wallace_sallet_visor_named" : 700,         		//DUR: 35.00 | STA: -1.00
	"armor.head.legend_helmet_faceplate_full" : 800,                     		//DUR: 60.00 | STA: -5.00
	"armor.head.legend_helmet_faceplate_raised" : 800,                   		//DUR: 50.00 | STA: -3.00
	"armor.head.legend_helmet_unhold_head_spike" : 800,                  		//DUR: 90.00 | STA: -13.00
	"armor.head.legend_helmet_enclave_great_bascinet_visor" : 900,       		//DUR: 65.00 | STA: -6.00
	"armor.head.legend_helmet_bascinet_visor_named" : 1000,              		//DUR: 50.00 | STA: -2.00
	"armor.head.legend_helmet_faceplate_full_gold" : 1000,               		//DUR: 65.00 | STA: -4.00
	"armor.head.legend_helmet_golden_mask" : 1500,                       		//DUR: 60.00 | STA: -4.00
	"armor.head.legend_helmet_faceplate_gold" : 1600,                    		//DUR: 65.00 | STA: -5.00
	"armor.head.legend_helmet_faceplate_full_01_named" : 2000,           		//DUR: 75.00 | STA: -6.00
	"armor.head.legend_helmet_warlock_skull" : 2000,                     		//DUR: 45.00 | STA: -2.00
	"armor.head.legend_helmet_golden_helm" : 3000,                       		//DUR: 90.00 | STA: -7.00

	//VANITY
	"armor.head.legend_helmet_undertakers_hat" : 0,							//DUR: 12.00 | STA: 0.00
	"armor.head.legend_helmet_thick_braid" : 0,								//DUR: 20.00 | STA: -1.00
	"armor.head.legend_helmet_thick_braid_rotten" : 0,						//DUR: 15.00 | STA: -1.00

	"armor.head.legend_helmet_physicians_hood" : 0,							//DUR:  5.00 | STA: 0.00
	"armor.head.legend_helmet_mask_beak" : 0,								//DUR: 20.00 | STA: -1.00

	"armor.head.legend_helmet_chaperon" : 0,								//DUR: 15.00 | STA: -1.00
	"armor.head.legend_helmet_felt_chaperon" : 0,							//DUR:  5.00 | STA: -1.00

	"armor.head.legend_helmet_helm_adornment" : 0,							//DUR: 20.00 | STA:  0.00
	"armor.head.legend_helmet_helm_adornment_rotten" : 0,					//DUR: 10.00 | STA:  0.00
	"armor.head.legend_helmet_undertakers_scarf" : 0,						//DUR:  5.00 | STA:  0.00

	"armor.head.legend_helmet_thick_braid_rotten" : 0,						//DUR: 15.00 | STA: -1.00
	"armor.head.legend_helmet_thick_braid_rotten" : 0,						//DUR: 15.00 | STA: -1.00
	"armor.head.legend_helmet_thick_braid_rotten" : 0,						//DUR: 15.00 | STA: -1.00

	"armor.head.legend_helmet_ancient_priest_hat" : 0,                 		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_ancient_wig" : 0,                        		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_antler" : 0,                             		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_bear_head" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_beret" : 0,                              		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_bull_horns" : 0,                         		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_crown" : 0,                              		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_faction_decayed_helmet" : 0,             		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_faction_helmet" : 0,                     		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_faction_helmet_2" : 0,                   		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_feathered_hat" : 0,                      		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_feather_band" : 0,                       		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_fencerhat" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_goat_horns" : 0,                         		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_goblin_bones" : 0,                       		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_headband" : 0,                           		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_horn_decorations" : 0,                   		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_impaled_head" : 0,                       		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_lion_pelt" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_metal_bird" : 0,                         		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_mummy_crown" : 0,                        		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_mummy_crown_king" : 0,                   		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_mummy_headband" : 0,                     		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_mummy_headress" : 0,                     		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_noble_buckle" : 0,                       		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_noble_feather" : 0,                      		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_noble_floppy_hat" : 0,                   		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_noble_hat" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_noble_hood" : 0,                         		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_noble_southern_crown" : 0,               		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_noble_southern_hat" : 0,                 		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_nun_habit" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_orc_bones" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_orc_great_horns" : 0,                    		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_plait" : 0,                              		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_ponytail" : 0,                           		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_ram_horns" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_royal_hood" : 0,                         		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_sack" : 0,                               		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_side_feather" : 0,                       		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_cloth_headress" : 0,            		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_earings" : 0,                   		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_feathered_turban" : 0,          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_headband" : 0,                  		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_headress_coin" : 0,             		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_helm_tailed" : 0,               		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_noble_turban" : 0,              		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_patterned_headband" : 0,        		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_patterned_headwrap" : 0,        		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_silk_headscarf" : 0,            		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_top_tail" : 0,                  		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_turban_feather" : 0,            		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_turban_full" : 0,               		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_turban_light" : 0,              		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_southern_turban_open" : 0,               		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_straw_hat" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_top_feather" : 0,                        		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_warlock_hood" : 0,                       		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_wizard_cowl" : 0,                        		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_wolf_helm" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_wreath" : 0,                             		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_demon_alp_helm" : 0,                     		//DUR: 10.00 | STA: -1.00
	"armor.head.legend_helmet_jester_hat" : 0,                         		//DUR: 10.00 | STA: -1.00
	"armor.head.legend_helmet_lindwurm_helm" : 0,                      		//DUR: 10.00 | STA: -1.00
	"armor.head.legend_helmet_nach_helm" : 0,                          		//DUR: 10.00 | STA: -1.00
	"armor.head.legend_helmet_redback_helm" : 0,                       		//DUR: 10.00 | STA: -1.00
	"armor.head.legend_helmet_white_wolf_helm" : 0,                    		//DUR: 10.00 | STA: -1.00
	"armor.head.legend_helmet_witchhunter_helm" : 0,                   		//DUR: 10.00 | STA: -1.00
	"armor.head.legend_helmet_hunter_cap" : 0,                        		//DUR: 10.00 | STA: -1.00
	"armor.head.legend_helmet_mountain_helm" : 0,                     		//DUR: 30.00 | STA: -2.00

	"armor.head.legend_helmet_back_crest" : 0,                         		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_back_feathers" : 0,                      		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_feather_crest" : 0,                      		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_goblin_tail" : 0,                        		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_knotted_tail" : 0,                       		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_orc_tail" : 0,                           		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_top_plume" : 0,                          		//DUR: 10.00 | STA: 0.00
	"armor.head.legend_helmet_wings" : 0,                              		//DUR: 10.00 | STA: 0.00
};