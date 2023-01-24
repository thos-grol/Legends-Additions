if (!("LA" in this.getroottable())) ::LA <- {};
::LA.Version <- "1.0.0";
::LA.ModID <- "mod_LA";
::LA.Name <- "Legends Additions";

::mods_registerMod(::LA.ModID, ::LA.Version, ::LA.Name);

::mods_queue(::LA.ModID, ">mod_legends, mod_msu(>=1.2.0-rc.2), >mod_legends_PTR", function()
{	
	::LA.Mod <- ::MSU.Class.Mod(::LA.ModID, ::LA.Version, ::LA.Name);

	::include("legends_additions/load.nut");

	// ::LA.modLegendsPerkTreeCreationSystem();
	// delete ::LA.modLegendsPerkTreeCreationSystem;

	::LA.hook_humans();
	::LA.hook_monsters();
	
});

::Const.Contracts.Return_Item <- {};
::Const.Contracts.Return_Item.Pool <- [
	//rare items
	"strange_tome",

	//valuable items
	"scripts/items/weapons/named/legend_staff_ceremonial",
	"scripts/items/misc/strange_eye_item", //FEATURE_3: Overhaul cultist holding strange eye in events
	"heirloom_sword",
	"blacksmith_hammer",
	"scripts/items/misc/lindwurm_bones_item",
	
	//common items
	"butchers_cleaver",
	"sickle",
	"scripts/items/misc/unhold_bones_item",
	"lockbox"
];

::Const.Strings.StaffNames <- [
	"Deathdealer",
	"Mercy",
	"Slayer",
	"Oathkeeper",
	"Avenger",
	"Red Rivers",
	"Lightning",
	"Striker",
	"Windcatcher",
	"Swiftstrike"
];

::LA.get_subterfuge_chance <- function ()
{
	local chance = 0;
	local roster = this.World.getPlayerRoster().getAll();
	foreach( i, bro in roster )
	{
		if (i >= 25) break;
		switch (bro.getBackground().getID())
		{
			case "background.legend_assassin":
			case "background.assassin":
			case "background.assassin_southern":
			case "background.legend_commander_assassin":
				chance += 15;
				break;

			case "background.killer_on_the_run":
			case "background.nomad":
			case "background.nomad_ranged_background":
			case "background.raider":
			case "background.thief":
				chance += 10;
				break;

		} 
	}
	return chance;
}

::LA.get_tracking_chance <- function ()
{
	local chance = 0;
	local roster = this.World.getPlayerRoster().getAll();
	foreach( i, bro in roster )
	{
		if (i >= 25) break;
		switch (bro.getBackground().getID())
		{
			case "background.legend_commander_ranger":
			case "background.legend_ranger":
			case "background.beast_slayer":
			case "background.houndmaster":
			case "background.hunter":
			case "background.poacher":
				chance += 15;
				break;

			case "background.legend_assassin":
			case "background.assassin":
			case "background.assassin_southern":
			case "background.legend_commander_assassin":
			case "background.wildman":
			case "background.wildwoman":
			case "background.barbarian":
			case "background.witchhunter":
				chance += 10;
				break;

			case "background.nomad":
			case "background.nomad_ranged_background":
			case "background.raider":
				chance += 5;
				break;

		} 
	}
	return chance;
}