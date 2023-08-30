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

//Disable dlc6 events
::mods_hookExactClass("events/events/dlc6/cultish_arrangement_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/desert_well_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/gunpowder_wagon_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/manhunters_origin_capture_prisoner_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/read_black_book_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/trade_black_book_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework event
::mods_hookExactClass("events/events/dlc6/traveler_south_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc6/sellsword_retires_event", function(o) { o.onUpdateScore = function(){ return; }});


//Disable dlc8 events
::mods_hookExactClass("events/events/dlc8/oathbreaker_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/tree_fort_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/volunteers_event", function(o) { o.onUpdateScore = function(){ return; }});

//Rework

//anatomist_helps_blighted_guy_1_event
//anatomist_helps_blighted_guy_2_event
//anatomist_vs_ailing_event
//anatomist_vs_asthmatic_event
//anatomist_vs_clubfooted_event
//anatomist_vs_iron_lungs_event
//gladiator_origin_vs_anatomist_event
//mutated_gladiator_annoys_others_event
//missing_kids_event
//killer_on_the_run_reminisces_event
//something_in_barn_event
//lindwurm_slayer_event
//strange_scribe_event

//TODO: Disable crisis events

//TODO: Disable legends events
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


//Remove Dogs
::mods_hookExactClass("events/events/dlc2/dog_in_swamp_event", function (o){ o.onUpdateScore = function() { return; }});
::mods_hookExactClass("events/events/dlc8/anatomist_vs_dog_event", function (o){ o.onUpdateScore = function() { return; }});

//Rework
//graverobber_finds_item_event
    //rework loot
    //has a chance to be cursed by ghost
    //change cooldown.
    //increase event score by the number of gravediggers in party
//graverobber_heist_event
//greedy_demands_raise_event
    //increase wage by 2
//historian_mysterious_text_event
//petrified_scream_event
//treant_vs_giants_event
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

//TODO: rework events to affect low resolve bros only, otherwise, they will gain a hatred
::mods_hookExactClass("events/events/dlc8/anatomist_reflects_on_webknechts_event", function(o) { o.onUpdateScore = function(){ return; }});

//TODO: read through scripts to see which one to change/remove

//Rework

//apprentice_learns_event
    //decrease cooldown to 1 week. Add flag to learning brother. Add limit to how many times that brother can trigger the event.
//cripple_pep_talk_event
//brawler_teaches_event
    //else if (bro.getLevel() < 3 && !bro.getBackground().isBackgroundType(this.Const.BackgroundType.Combat))
    //increase teachable bro level to 7
    //decrease cooldown to 1 week.
//combat_drill_event
    //decrease cooldown to 1 week. Add flag to learning brother. Add limit to how many times that brother can trigger the event.
//farmer_old_tricks_event
    //rework to 4 weeks event
    //rework to trigger only once per bro
//running_around_event
    //cd



//Rework stage2
//bad_curse_event ? make curse scarier?
//sacrificed_man_event
//shady_character_offers_map_event

//::mods_hookExactClass("events/events/dlc2/alp_nightmare1_event", function(o) { o.onUpdateScore = function(){ return; }});
// ::mods_hookExactClass("events/events/dlc2/alp_nightmare2_event", function(o) { o.onUpdateScore = function(){ return; }});
    //Rework, summon alp boss to fight.
