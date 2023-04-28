::mods_hookExactClass("skills/backgrounds/legend_berserker_commander_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +30 tracking for relevant checks."
			}
		];
		return ret;
	}

	local create = o.create;
	o.create = function()
	{
		create();
        this.m.BackgroundDescription = "This character\'s history is a secret" + " +30 tracking for relevant checks.";
		this.m.Level = 9;
	}
});