this.sprained_ankle_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.sprained_ankle";
		this.m.Name = "Sprained Ankle";
		this.m.Description = "A sprained ankle makes even the quickest man hobble across the battlefield.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_24";
		this.m.Icon = "ui/injury/injury_icon_24.png";
		this.m.IconMini = "injury_icon_24_mini";
		this.m.HealingTimeMin = 2;
		this.m.HealingTimeMax = 3;
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
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]1[/color] Additional Action Point per tile moved"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] Initiative"
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

		_properties.MovementAPCostAdditional += 1;
		_properties.InitiativeMult *= 0.8;
	}

});

