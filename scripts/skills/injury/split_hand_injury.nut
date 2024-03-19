this.split_hand_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.split_hand";
		this.m.Name = "Split Hand";
		this.m.Description = "A sharp cut split the hand right down the middle. Until healed, it can barely be used anymore.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_08";
		this.m.Icon = "ui/injury/injury_icon_08.png";
		this.m.IconMini = "injury_icon_08_mini";
		this.m.HealingTimeMin = 5;
		this.m.HealingTimeMax = 7;
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Attack"
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

		_properties.MeleeSkillMult *= 0.5;
	}

});

