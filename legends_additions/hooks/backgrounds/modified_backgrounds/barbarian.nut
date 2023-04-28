::mods_hookExactClass("skills/backgrounds/barbarian_background", function(o)
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
});