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

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.BackgroundDescription = "A killer on the run may kill again, and he knows where to aim." + " +10 subterfuge for relevant checks.";
	}
});