//"Enhanced Eye Rods";
//"This character\'s eyes have mutated to respond faster and more drastically to low light environments. As a result, they have night vision nearly on par with their sight during the day.";
::mods_hookExactClass("skills/effects/alp_potion_effect", function(o) {
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
				text = "Not affected by nighttime penalties" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+2[/color] Vision"
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

	local onUpdate = o.onUpdate;
	o.onUpdate = function(_properties)
	{
		onUpdate(_properties);
		_properties.Vision += 2;
	}
});
