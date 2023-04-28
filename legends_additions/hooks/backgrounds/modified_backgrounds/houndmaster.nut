::mods_hookExactClass("skills/backgrounds/houndmaster_background", function(o)
{
	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Is good at tracking. +50 tracking for relevant checks."
			}
		];
		return ret;
	}

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.BackgroundDescription = "Houndmasters are used to handle dogs of war." + " +50 tracking for relevant checks.";
	}
});