::mods_hookExactClass("skills/backgrounds/beast_hunter_background", function(o)
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
		this.m.BackgroundDescription = "Beast Slayers are used to expertly hunt monstrous beasts at all ranges." + " +50 tracking for relevant checks.";
	}
});