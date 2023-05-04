::mods_hookExactClass("scenarios/world/legends/deserters_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legend_random_3_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legend_random_party_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legend_random_solo_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_berserker_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_crusader_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_druid_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_inquisition_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_necro_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_noble_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_party_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_rangers_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_scaling_beggar_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_troupe_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/manhunters_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/paladins_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/random_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/southern_quickstart_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/trader_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/tutorial_scenario", function(o) { o.isValid = function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_debug_scenario", function(o) { o.isValid = function(){ return true; }});

//scenarios where is valid fn DNE
::mods_hookExactClass("scenarios/world/legends/early_access_scenario", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_risen_legion_scenario", function(o) { o.isValid <- function(){ return false; }});
::mods_hookExactClass("scenarios/world/legends/legends_assassin_scenario", function(o) { o.isValid <- function(){ return false; }});

