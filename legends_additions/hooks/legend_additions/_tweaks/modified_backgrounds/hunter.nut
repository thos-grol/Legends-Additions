::mods_hookExactClass("skills/backgrounds/hunter_background", function(o)
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
		this.m.BackgroundDescription = "Hunters are used to expertly hunt animals with bow and arrow, and traverse the woods on their own."+ " +50 tracking for relevant checks.";
	}
});