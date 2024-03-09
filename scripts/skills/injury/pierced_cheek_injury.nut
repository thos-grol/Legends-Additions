this.pierced_cheek_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.pierced_cheek";
		this.m.Name = "Pierced Cheek";
		this.m.Description = "Contrary to what one might think, having an additional hole in the cheek does not help with breathing.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_45";
		this.m.Icon = "ui/injury/injury_icon_45.png";
		this.m.IconMini = "injury_icon_45_mini";
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 2;
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-3[/color] Fatigue Recovery per turn"
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

		_properties.FatigueRecoveryRate -= 3;
	}

});

