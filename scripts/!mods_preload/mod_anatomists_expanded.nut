local gt = this.getroottable();
gt.anatomists_expanded <- {};

::mods_registerMod("mod_anatomists_expanded", 1.00, "Anatomists Expanded");
::mods_queue("mod_anatomists_expanded", "mod_legends, >mod_legends_PTR", function()
{
	gt.anatomists_expanded.hook_mutations();
	gt.anatomists_expanded.hook_scenario();
	gt.anatomists_expanded.hook_effects();
	gt.anatomists_expanded.hook_items();
	gt.anatomists_expanded.hook_loot();
	gt.anatomists_expanded.hook_enemies();
	
});
