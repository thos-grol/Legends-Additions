this.cut_leg_muscles_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.cut_leg_muscles";
		this.m.Name = "Cut Leg Muscles";
		this.m.Description = "A cut into the muscles of the leg makes any quick and sudden movements impossible.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_06";
		this.m.Icon = "ui/injury/injury_icon_06.png";
		this.m.IconMini = "injury_icon_06_mini";
		this.m.HealingTimeMin = 3;
		this.m.HealingTimeMax = 5;
		this.m.InfectionChance = 1.0;
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-40%[/color] Melee Defense"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-40%[/color] Initiative"
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

		_properties.MeleeDefenseMult *= 0.6;
		_properties.InitiativeMult *= 0.6;
	}

});

