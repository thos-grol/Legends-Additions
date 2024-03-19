this.legend_rain_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.legend_rain";
		this.m.Name = "Raining";
		this.m.Description = "The rain obscures vision and makes everything slippery";
		this.m.Icon = "skills/rain_circle.png";
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
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-1[/color] Vision"
		});
		ret.push({
			id = 12,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Ranged Hit Chance"
		});
		return ret;
	}

	function onUpdate( _properties )
	{
		if (_properties.IsAffectedByRain)
		{
			_properties.Vision -= 1;
		}
	}

});

