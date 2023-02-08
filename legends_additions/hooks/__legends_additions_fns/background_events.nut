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
			case "background.raider":
				chance += 5;
				break;

		}
	}
	return chance;
}

::mods_hookExactClass("skills/backgrounds/legend_ranger_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +15 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/legend_ranger_commander_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +15 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/beast_hunter_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +15 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/houndmaster_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +15 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/hunter_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +15 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/poacher_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +15 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/wildman_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +10 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/wildwoman_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +10 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/barbarian_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +10 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/witchhunter_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +10 tracking for relevant checks."
			}
		];
		return ret;
	}
});


::mods_hookExactClass("skills/backgrounds/legend_assassin_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at subterfuge. +15 subterfuge for relevant checks."
			},
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +10 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/assassin_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at subterfuge. +15 subterfuge for relevant checks."
			},
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +10 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/assassin_southern_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at subterfuge. +15 subterfuge for relevant checks."
			},
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +10 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/legend_assassin_commander_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at subterfuge. +15 subterfuge for relevant checks."
			},
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +10 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/killer_on_the_run_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at subterfuge. +10 subterfuge for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/nomad_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at subterfuge. +10 subterfuge for relevant checks."
			},
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +5 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/raider_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at subterfuge. +10 subterfuge for relevant checks."
			},
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +5 tracking for relevant checks."
			}
		];
		return ret;
	}
});

::mods_hookExactClass("skills/backgrounds/thief_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at subterfuge. +10 subterfuge for relevant checks."
			}
		];
		return ret;
	}
});
