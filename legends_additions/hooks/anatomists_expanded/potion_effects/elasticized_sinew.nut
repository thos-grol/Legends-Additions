//"Elasticized Sinew";
//"This character\'s muscles have mutated and respond differently to movement impulses. It is much less fatiguing to interrupt or stop mid-motion as a consequence, making it much easier to recover from errant or blocked attacks.";
::mods_hookExactClass("skills/effects/direwolf_potion_effect", function(o) {
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/morale.png",
				text = "Attacks that miss have [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] of their Fatigue cost refunded" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
			}
		];
		return ret;
	}

	o.onUpdate <- function(_properties)
	{
		_properties.Stamina += 10;
	}
});
