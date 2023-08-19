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
				chance += 40;
				break;

			case "background.killer_on_the_run":
			case "background.nomad":
			case "background.raider":
			case "background.thief":
				chance += 25;
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
			case "background.hunter":
			case "background.poacher":
				chance += 50;
				break;

			case "background.legend_assassin":
			case "background.assassin":
			case "background.assassin_southern":
			case "background.legend_commander_assassin":
			case "background.legend_commander_berserker":
			case "background.wildman":
			case "background.wildwoman":
			case "background.barbarian":
			case "background.witchhunter":
				chance += 30;
				break;

			case "background.nomad":
			case "background.raider":
				chance += 20;
				break;

		}
	}
	return chance;
}