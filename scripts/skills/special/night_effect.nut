this.night_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.night";
		this.m.Name = "Nighttime";
		this.m.Description = "Did that shadow just move? The dim moon light makes it hard to see more than a few feet in front, reducing the view range and making the use of ranged weapons a bad proposition for anyone not able to see in the dark.";
		this.m.Icon = "skills/status_effect_35.png";
		this.m.IconMini = "status_effect_35_mini";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.Special;
		this.m.IsActive = false;
		this.m.IsSerialized = false;
		this.m.IsRemovedAfterBattle = true;
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
			}
		];
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/vision.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-2[/color] Vision"
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color] Ranged Hit Chance"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = !_properties.IsAffectedByNight;

		if (_properties.IsAffectedByNight && !this.getContainer().hasSkill("trait.night_owl"))
		{
			_properties.Vision -= 2;
		}

		if (_properties.IsAffectedByNight && this.getContainer().hasSkill("trait.night_owl"))
		{
			_properties.Vision -= 1;
		}
	}

});

