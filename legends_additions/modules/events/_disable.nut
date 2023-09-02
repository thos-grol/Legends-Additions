//Disable general events
::mods_hookExactClass("events/events/adopt_wardog_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/butcher_vs_wardog_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/butcher_wardogs_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/dogfighting_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/dogs_dig_up_loot_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/houndmaster_tames_wolf_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/houndmaster_tames_white_wolf_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/wardogs_fight_each_other_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/aging_swordmaster_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/aging_swordmaster_paycut_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/aging_swordmaster_preview_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/all_naked_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/beat_up_old_man_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/bowyer_crafts_masterwork_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/childrens_crusade_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/come_across_ritual_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/cultist_finale_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/cultist_vs_old_gods_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/cultist_vs_uneducated_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/drunkard_loses_stuff_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/melon_thief_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/player_is_rich_op_backgrounds_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/player_is_rich_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/player_is_sent_for_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/player_plays_dice_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/raid_farmstead_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/ratcatcher_crafts_net_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/wound_heals_event", function(o) { o.onUpdateScore = function(){ return; }});

::mods_hookExactClass("events/events/peddler_deal_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/peddler_sells_rat_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/shady_character_offers_map_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/pimp_and_harlots_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/traveling_troupe_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/traveling_monk_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/inadvertently_save_merchant_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/troublemakers_bully_peasants_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/pimp_vs_harlot_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/peacenik_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/hidden_cache_forest_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/the_horseman_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/fell_down_well_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/surefooted_saves_damsel_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dead_merchant_forest_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event spooky


//Disable dlc2 events
::mods_hookExactClass("events/events/dlc2/addict_steals_potion_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/alp_captured_in_hole_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/collector_wants_trophy_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/gain_addiction_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/glutton_eats_apple_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/kid_blacksmith_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/lose_addiction_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/monk_crafts_holy_water_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/schrat_exposition_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/spooky_forest_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/unhold_exposition_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/webknecht_exposition_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/youngling_alp_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/treasure_in_rock_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/dog_in_swamp_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/dlc2/lucky_finds_something_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework
::mods_hookExactClass("events/events/dlc2/oracle_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework
::mods_hookExactClass("events/events/dlc2/petrified_scream_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework
::mods_hookExactClass("events/events/dlc2/treant_vs_giants_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework

//Disable dlc4 events
::mods_hookExactClass("events/events/dlc4/adopt_warhound_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc4/cultist_origin_armor_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc4/cultist_origin_finale_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc4/cultist_origin_flock_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc4/cultist_origin_hood_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc4/cultist_origin_sacrifice_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc4/cultist_origin_vs_old_gods_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc4/cultist_origin_vs_uneducated_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc4/traveler_north_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc4/wild_dog_sounds_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc4/drunk_nobleman_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc4/horse_race_event", function(o) { o.onUpdateScore = function(){ return; }});

//Disable dlc6 events
::mods_hookExactClass("events/events/dlc6/cultish_arrangement_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/desert_well_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/gunpowder_wagon_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/manhunters_origin_capture_prisoner_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/read_black_book_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/trade_black_book_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/traveler_south_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/sellsword_retires_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/gladiators_food_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/merchant_of_jugs_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/pirates_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/retired_gladiator_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/sellsword_vs_bees_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/cannon_execution_event", function(o) { o.onUpdateScore = function(){ return; }});


//Disable dlc8 events
::mods_hookExactClass("events/events/dlc8/oathbreaker_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/tree_fort_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/volunteers_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/black_market_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/missing_kids_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/captured_oathbringer_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/anatomist_reflects_on_webknechts_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/anatomist_vs_dog_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/dlc8/incense_trade_event", function (o){ o.onUpdateScore = function() { return; }}); //FEATURE_5: rework spooky

//Disable legends events
::mods_hookExactClass("events/events/legends/legend_alchemist_crafts_thing_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_blacksmith_craft_armor", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_blacksmith_crafts_crusadersword", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_blacksmith_fix_equipment", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_blacksmith_reforges_orc_cleaver_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_butcher_vs_donkey", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_cabal_puppet_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_cannibal_eats_part_of_brother", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_clothing_merchant_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_falconflies_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_inventor_prosthetic_ear", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_inventor_prosthetic_eye", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_inventor_prosthetic_finger", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_inventor_prosthetic_foot", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_inventor_prosthetic_forearm", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_inventor_prosthetic_hand", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_inventor_prosthetic_leg", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_inventor_prosthetic_nose", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_rat_bite_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_swordmaster_fav_enemy_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_trader_recruitment", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legend_traveling_bard_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legends_adopt_warbear_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legends_fletcher_crafts_masterwork_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legends_minstrel_and_juggler_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legends_minstrel_and_troubador_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/legends/legends_troubador_and_juggler_event", function(o) { o.onUpdateScore = function(){ return; }});



//TODO: Rework dlc8
//anatomist_helps_blighted_guy_1_event
//anatomist_helps_blighted_guy_2_event
//anatomist_vs_ailing_event
//anatomist_vs_asthmatic_event
//anatomist_vs_clubfooted_event
//anatomist_vs_iron_lungs_event
//gladiator_origin_vs_anatomist_event
//mutated_gladiator_annoys_others_event
//killer_on_the_run_reminisces_event
//something_in_barn_event
//lindwurm_slayer_event
//strange_scribe_event

//legend_cannibal_recruitment //rework cannibal to be more interesting.
    //legend_cannibal_corrupts_butcher
//legend_barbarian_vs_shieldmaiden rework higher levels
//legend_old_man_sells rework items and costs
//legend_vala_recruitment rework how you get vala

//c:\Users\andrew_do\AppData\Roaming\Adobe\0\env_legends\events\events\dlc2\corpses_in_forest_event.nut
//lucky_finds_something_event
//
//oracle_event

//TODO: start copying over and modifying events that use addmoney, World.Assets.getMoney()
//TODO: .onHired();
//TODO: getlevel()

//Rework

//Rework stage2
//bad_curse_event ? make curse scarier?
//sacrificed_man_event

//FEATURE_5, summon alp boss to fight.
//::mods_hookExactClass("events/events/dlc2/alp_nightmare1_event", function(o) { o.onUpdateScore = function(){ return; }});
//::mods_hookExactClass("events/events/dlc2/alp_nightmare2_event", function(o) { o.onUpdateScore = function(){ return; }});

