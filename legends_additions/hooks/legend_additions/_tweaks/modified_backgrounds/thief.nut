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

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.BackgroundDescription = "A good thief will have quick reflexes and the ability to evade any captors." + " +10 subterfuge for relevant checks.";
	}
});
