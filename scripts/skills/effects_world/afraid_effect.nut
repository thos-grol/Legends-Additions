this.afraid_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.afraid";
		this.m.Name = "Afraid";
		this.m.Description = "Recent events have left this character afraid for his life. Either he\'s right and will meet his end soon, or it\'ll  pass in time.";
		this.m.Icon = "skills/status_effect_52.png";
		this.m.IconMini = "status_effect_52_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
	}

	function isTreated()
	{
		return true;
	}

	function getTooltip()
	{
		return [
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
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Will"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Is content with being in reserve"
			}
		];
	}

	function onNewDay()
	{
		if (this.Math.rand(1, 100) <= 25)
		{
			this.removeSelf();
		}
	}

	function onUpdate( _properties )
	{
		_properties.BraveryMult *= 0.5;
		_properties.IsContentWithBeingInReserve = true;
	}

});

