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

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.BackgroundDescription = "Rangers are expert trackers and marksman, used to hunting prey of any kind." + " +15 tracking for relevant checks.";
	}
});