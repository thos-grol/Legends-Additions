//Disable
::mods_hookExactClass("events/events/dlc2/alp_nightmare1_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/alp_nightmare2_event", function(o) { o.onUpdateScore = function(){ return; }});

//FEATURE_5: rework events to affect low resolve bros only
::mods_hookExactClass("events/events/dlc2/fear_beasts_event", function(o) { o.onUpdateScore = function(){ return; }}); 
::mods_hookExactClass("events/events/dlc2/fear_greenskins_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc2/fear_undead_event", function(o) { o.onUpdateScore = function(){ return; }});
::mods_hookExactClass("events/events/dlc8/anatomist_reflects_on_webknechts_event", function(o) { o.onUpdateScore = function(){ return; }});

//FEATURE_5: story events might give something
