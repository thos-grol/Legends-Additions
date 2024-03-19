this.hangover_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "effects.hangover";
		this.m.Name = "Hangover";
		this.m.Description = "Not so loud! This character suffers the consequences from recent excessive alcohol consumption.";
		this.m.Icon = "skills/status_effect_62.png";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect | this.Const.SkillType.SemiInjury;
		this.m.IsHealingMentioned = false;
		this.m.IsTreatable = false;
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 1;
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
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Will"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Agility"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Attack"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] Reflex"
			},
			
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		this.injury.onAdded();
		this.m.Container.removeByID("effects.drunk");
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		_properties.BraveryMult *= 0.9;
		_properties.MeleeSkillMult *= 0.9;
		_properties.MeleeDefenseMult *= 0.9;
		_properties.RangedDefenseMult *= 0.9;
		_properties.InitiativeMult *= 0.9;
	}

});

