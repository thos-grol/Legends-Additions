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

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.BackgroundDescription = "Any raider that survived so far will have some expertise in fighting." + " +10 subterfuge for relevant checks."  + " +5 tracking for relevant checks.";
	}
});