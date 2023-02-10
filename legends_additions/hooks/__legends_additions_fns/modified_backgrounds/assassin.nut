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

	local create = o.create;
	o.create = function()
	{
		create();
        this.m.BackgroundDescription = "The same as any other mercenary, a skilled assassin can be hired for a good sum of crowns." + " +15 subterfuge for relevant checks."  + " +10 tracking for relevant checks.";

	}
});