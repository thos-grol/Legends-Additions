local gt = this.getroottable();
gt.AE <- {};

::mods_registerMod("mod_anatomists_expanded", 1.00, "Anatomists Expanded");
::mods_queue("mod_anatomists_expanded", "mod_legends, >mod_legends_PTR", function()
{
	gt.AE.hook_mutations();
	gt.AE.hook_items();
	gt.AE.hook_scenario();
	gt.AE.hook_effects();
	gt.AE.hook_drops();
	gt.AE.hook_enemies();
});
