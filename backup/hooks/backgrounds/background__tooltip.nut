::mods_hookExactClass("skills/backgrounds/character_background", function (o)
{
	o.getBackgroundTooltip <- function() { return []; }

	o.getTooltip = function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getContainer() != null)
		{
			ret.extend(this.getBackgroundTooltip());
			ret.extend(this.getAttributesTooltip());
		}

		return ret;
	}

});