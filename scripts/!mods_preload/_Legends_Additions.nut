if (!("LA" in this.getroottable())) ::LA <- {};
::LA.Version <- "2.0.0";
::LA.ModID <- "mod_LA";
::LA.Name <- "Legends Additions";

::mods_registerMod(::LA.ModID, ::LA.Version, ::LA.Name);

::mods_queue(::LA.ModID, ">mod_legends, mod_msu(>=1.2.0-rc.2), >mod_legends_PTR", function()
{
	::LA.Mod <- ::MSU.Class.Mod(::LA.ModID, ::LA.Version, ::LA.Name);

	::include("legends_additions/load.nut");
});