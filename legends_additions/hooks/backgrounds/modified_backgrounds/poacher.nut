::mods_hookExactClass("skills/backgrounds/poacher_background", function(o)
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
        this.m.BackgroundDescription = "Poachers tend to have some skill in using bow and arrow to hunt down rabbits and the like." + " +50 tracking for relevant checks.";
	}
});