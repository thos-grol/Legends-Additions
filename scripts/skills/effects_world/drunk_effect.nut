this.drunk_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "effects.drunk";
		this.m.Name = "Drunk";
		this.m.Description = "Hicks. This character is intoxicated with alcoholic liquor to the point of impairment of physical and mental faculties.";
		this.m.Icon = "skills/status_effect_61.png";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect | this.Const.SkillType.SemiInjury | this.Const.SkillType.DrugEffect;
		this.m.IsHealingMentioned = false;
		this.m.IsTreatable = false;
		this.m.IsContentWithReserve = false;
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
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color] Will"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Agility"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Attack"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color] Defense"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color] chance to be followed by a hangover"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		this.injury.onAdded();
		this.m.Container.removeByID("effects.hangover");
	}

	function onRemoved()
	{
		if (this.Math.rand(1, 100) <= 50)
		{
			this.getContainer().add(this.new("scripts/skills/effects_world/hangover_effect"));
		}
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		_properties.BraveryMult *= 1.25;
		_properties.MeleeSkillMult *= 0.75;
		_properties.MeleeDefenseMult *= 0.75;
		_properties.InitiativeMult *= 0.75;
	}

});

