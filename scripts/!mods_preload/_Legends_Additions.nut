if (!("LA" in this.getroottable())) ::LA <- {};
::LA.Version <- "2.0.0";
::LA.ModID <- "mod_legends_dark_age";
::LA.Name <- "Legends Dark Age";

::mods_registerMod(::LA.ModID, ::LA.Version, ::LA.Name);

::mods_queue(::LA.ModID, ">mod_legends, mod_msu(>=1.2.6)", function()
{
	::LA.Mod <- ::MSU.Class.Mod(::LA.ModID, ::LA.Version, ::LA.Name);

	::include("dark_age/load.nut");
});