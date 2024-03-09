this.crushed_windpipe_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.crushed_windpipe";
		this.m.Name = "Crushed Windpipe";
		this.m.Description = "A blow to the neck injured the windpipe, making it very hard and painful to draw breath, let alone to keep fighting.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_38";
		this.m.Icon = "ui/injury/injury_icon_38.png";
		this.m.IconMini = "injury_icon_38_mini";
		this.m.HealingTimeMin = 3;
		this.m.HealingTimeMax = 5;
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
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color] Fatigue Recovery per turn"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Max Fatigue"
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

		_properties.FatigueRecoveryRate -= 10;
		_properties.StaminaMult *= 0.5;
	}

});

