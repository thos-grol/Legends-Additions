//General
::mods_hookExactClass("events/events/player_is_rich_op_backgrounds_event", function(o) { o.onUpdateScore = function(){ return; }});

//Backgrounds
::mods_hookExactClass("events/events/legends/legend_cannibal_recruitment", function(o) { o.onUpdateScore = function(){ return; }});