::mods_hookExactClass("skills/backgrounds/witchhunter_background", function(o)
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
        this.m.BackgroundDescription = "Witchhunters tend to have some martial experience, and their resolve often remains unbroken even in the face of unspeakable horror." + " +30 tracking for relevant checks.";
	}
});