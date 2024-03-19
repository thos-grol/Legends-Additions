this.deep_face_cut_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.deep_face_cut";
		this.m.Name = "Deep Face Cut";
		this.m.Description = "A jagged cut across the face is bleeding profusely over eyes, nose and mouth.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_10";
		this.m.Icon = "ui/injury/injury_icon_10.png";
		this.m.IconMini = "injury_icon_10_mini";
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Attack"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Defense"
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

		_properties.MeleeSkillMult *= 0.75;
		_properties.MeleeDefenseMult *= 0.75;
		_properties.Vision -= 2;
	}

});

