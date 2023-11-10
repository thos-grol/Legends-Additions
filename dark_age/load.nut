// ::include("mod_ptr/hooks/config/strings.nut");

// ::include("mod_ptr/config/perk_defs.nut")

// ::include("mod_ptr/hooks/config/z_perks_tree_defense.nut")
// ::include("mod_ptr/hooks/config/z_perks_tree_weapons.nut")
// ::include("mod_ptr/hooks/config/z_perks_tree_traits.nut")
// ::include("mod_ptr/hooks/config/z_perks_tree_class.nut")
// ::include("mod_ptr/hooks/config/z_perks_tree_magic.nut")

// ::include("mod_ptr/config/perks_tree_styles.nut")
// ::include("mod_ptr/config/perks_tree_profession.nut")
// ::include("mod_ptr/config/perks_tree_special.nut")

// ::include("mod_ptr/hooks/config/z_perks_tree_enemy.nut")

// foreach(file in ::IO.enumerateFiles("mod_ptr/config"))
// {
// 	::include(file);
// }

// ::Const.Perks.updatePerkGroupTooltips();

// ::include("mod_ptr/hooks/hooks_helper.nut")

// foreach (file in ::IO.enumerateFiles("legends_additions/config"))
// {
// 	::include(file);
// }

foreach (file in ::IO.enumerateFiles("dark_age/modules"))
{
	::include(file);
}
