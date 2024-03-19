this.pierced_hand_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.pierced_hand";
		this.m.Name = "Pierced Hand";
		this.m.Description = "Having a hole in the hand may not stop a determined fighter, but it does make handling a weapon more difficult.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_41";
		this.m.Icon = "ui/injury/injury_icon_41.png";
		this.m.IconMini = "injury_icon_41_mini";
		this.m.HealingTimeMin = 3;
		this.m.HealingTimeMax = 4;
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] Attack"
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

		_properties.MeleeSkillMult *= 0.8;
	}

});

