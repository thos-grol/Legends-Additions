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
::mods_hookExactClass("events/events/come_across_ritual_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework come_across_ritual_event event
::mods_hookExactClass("events/events/cultist_finale_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework cultist finale event
::mods_hookExactClass("events/events/cultist_vs_old_gods_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/cultist_vs_uneducated_event", function(o) { o.onUpdateScore = function(){ return; }}); //FEATURE_5: rework cultist_vs_uneducated_event event
::mods_hookExactClass("events/events/drunkard_loses_stuff_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/melon_thief_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/player_is_rich_op_backgrounds_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/player_is_rich_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/player_is_sent_for_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/player_plays_dice_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/raid_farmstead_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/ratcatcher_crafts_net_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/wound_heals_event", function(o) { o.onUpdateScore = function(){ return; }});

//TODO: Disable dlc2 events
// ::mods_hookExactClass("events/events/dlc2/alp_nightmare1_event", function(o) { o.onUpdateScore = function(){ return; }});
// ::mods_hookExactClass("events/events/dlc2/alp_nightmare2_event", function(o) { o.onUpdateScore = function(){ return; }});

//TODO: Disable dlc4 events

//TODO: Disable dlc6 events

//TODO: Disable dlc8 events

//TODO: Disable crisis events

//TODO: Disable legends events
::mods_hookExactClass("events/events/legends/legend_cannibal_recruitment", function(o) { o.onUpdateScore = function(){ return; }});

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

//TODO: start copying over and modifying events that use addmoney, World.Assets.getMoney()

//TODO: rework events to affect low resolve bros only, otherwise, they will gain a hatred
::mods_hookExactClass("events/events/dlc2/fear_beasts_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/fear_greenskins_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/fear_undead_event", function(o) { o.onUpdateScore = function(){ return; }});
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
