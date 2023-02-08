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

//TODO: Add tooltips to describe background bonuses.
// o.getBackgroundTooltip <- function()
// 	{
// 		local ret = [
// 			{
// 				id = 3,
// 				type = "hint",
// 				icon = "ui/icons/special.png",
// 				text = "Has a chance (depending on the monster) to concoct sequence potions from all monsters killed in battle"
// 			}
// 		];
// 		return ret;
// 	}