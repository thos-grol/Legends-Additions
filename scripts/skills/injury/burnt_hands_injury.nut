this.burnt_hands_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.burnt_hands";
		this.m.Name = "Burnt Hands";
		this.m.Description = "Burnt hands severly reduce the ability to make swift and precise motions. Also, it stings like hell.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_47";
		this.m.Icon = "ui/injury/injury_icon_47.png";
		this.m.IconMini = "injury_icon_47_mini";
		this.m.HealingTimeMin = 4;
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
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Attack"
			},
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

		_properties.MeleeSkillMult *= 0.75;
	}

});

