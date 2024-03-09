this.smashed_hand_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.smashed_hand";
		this.m.Name = "Smashed Hand";
		this.m.Description = "A hand smashed by blunt force makes it almost impossible to hold on to any kind of weapon.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_19";
		this.m.Icon = "ui/injury/injury_icon_19.png";
		this.m.IconMini = "injury_icon_19_mini";
		this.m.HealingTimeMin = 4;
		this.m.HealingTimeMax = 6;
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-40%[/color] Skill"
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

		_properties.MeleeSkillMult *= 0.6;
	}

});

