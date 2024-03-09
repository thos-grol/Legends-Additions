this.grazed_eye_socket_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.grazed_eye_socket";
		this.m.Name = "Grazed Eye Socket";
		this.m.Description = "A blow grazed and ripped the tissue close to the eye, causing it to fill with blood and swell shut.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_43";
		this.m.Icon = "ui/injury/injury_icon_43.png";
		this.m.IconMini = "injury_icon_43_mini";
		this.m.HealingTimeMin = 2;
		this.m.HealingTimeMax = 4;
	}

	function getTooltip()
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
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Ranged Hit Chance"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-2[/color] Vision"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);

		if (!_properties.IsAffectedByInjuries || this.m.IsFresh && !_properties.IsAffectedByFreshInjuries)
		{
			return;
		}

		_properties.Vision -= 2;
	}

});

