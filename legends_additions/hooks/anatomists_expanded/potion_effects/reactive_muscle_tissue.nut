//"Reactive Muscle Tissue";
//"This character\'s body reacts to physical trauma, secreting a calciferous substance that causes their muscles to reflexively sieze and contract at points of impact to minimize muscle damage.";
::mods_hookExactClass("skills/effects/fallen_hero_potion_effect", function(o) {
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
				text = "This character accumulates no Fatigue from enemy attacks, whether they hit or miss\n" + "[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
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
		_properties.Hitpoints += 10;
	}

});
