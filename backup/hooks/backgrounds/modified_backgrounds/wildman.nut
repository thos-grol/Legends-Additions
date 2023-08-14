::mods_hookExactClass("skills/backgrounds/wildman_background", function(o)
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
        this.m.BackgroundDescription = "Wildmen are used to the hard life of the wild where only the strong prevail. They are less used to the life of cities, where the astute and deceitful rule." + " +30 tracking for relevant checks.";
	}
});