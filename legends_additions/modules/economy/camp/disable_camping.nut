::mods_hookExactClass("entity/world/camp/buildings/commander_building", function(o) {
    o.onClicked = function(_campScreen){}
    o.getDescription = function()
	{
		local desc = "";
		desc = desc + "Camping is disabled because I don't have time to balance it. ";
        desc = desc + "\n\n";
		desc = desc + "Character customization still exists, and crafting has been entirely overhauled...";
		// desc = desc + "Inside the commanders, each brother can be assigned to a tent to perform the task. Need food? Assign a couple brothers to hunt. Need more ammo, assign to fletchers tent. ";
		// desc = desc + "In general, the currency of camping is time. It requires time to perform all the actions. The more brothers assigned to the task, the less time it\'ll take to perform it.";
		// desc = desc + "While all backgrounds can perform any task, some backgrounds are more suited to the task. Hunters will be better at hunting than the tailors.";
		// desc = desc + "\n\n";
		// desc = desc + "Company starts out only knowing how to do repairs and rest. Visiting settlements that perform the analogous task will unlock it in the camp. All camp activities can be upgraded ";
		// desc = desc + "by purchasing an upgraded tent variant from a settlement marketplace. Upgraded tents increase performance and many come with significant bonuses.";
		return desc;
	}
});
::mods_hookExactClass("entity/world/camp/buildings/rest_building", function(o) {o.isHidden <- function(){return true;}});
::mods_hookExactClass("entity/world/camp/buildings/workshop_building", function(o) {o.isHidden <- function(){return true;}});
::mods_hookExactClass("entity/world/camp/buildings/scout_building", function(o) {o.isHidden <- function(){return true;}});
::mods_hookExactClass("entity/world/camp/buildings/training_building", function(o) {o.isHidden <- function(){return true;}});
::mods_hookExactClass("entity/world/camp/buildings/fletcher_building", function(o) {o.isHidden <- function(){return true;}});
::mods_hookExactClass("entity/world/camp/buildings/gatherer_building", function(o) {o.isHidden <- function(){return true;}});
::mods_hookExactClass("entity/world/camp/buildings/hunter_building", function(o) {o.isHidden <- function(){return true;}});
::mods_hookExactClass("entity/world/camp/buildings/enchanter_building", function(o) {o.isHidden <- function(){return true;}});
::mods_hookExactClass("entity/world/camp/buildings/healer_building", function(o) {o.isHidden <- function(){return true;}});
::mods_hookExactClass("entity/world/camp/buildings/repair_building", function(o) {o.isHidden <- function(){return true;}});


//FIXME: DOCUMENT camping overhaul
//disabled camping system
	//bc not sure how to balance it with new economy plus camping sorta conflicts with retinue. Many of the camp functions have thus been added to retinue.
//repair and healing speed has been looked at
//healing & healing injuries slower without doctor. certain background can speed up healing
//certain background can speed up repair. blacksmith will speed up repair.

//FEATURE_9: scavenger hunt! - you can upgrade retinue members by acquiring certain items
//FEATURE_9: materials in inventory - blacksmith can craft weapons, put retinue as toggle. Craft metals/materials into molds - blackmsmith will process and roll items

// {
//     Food = 100,
//     Ammo = 75,
//     Medicine = 30,
//     ArmorParts = 50
// }

//changed the efficacy of armor parts and how repairing works. armor parts now provide twice the value to repair armor
//Repair system
//items equipped are repaired. can also mark items to repair in inventory with alt-right click