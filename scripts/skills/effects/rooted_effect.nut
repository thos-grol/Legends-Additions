this.rooted_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rooted";
		this.m.Name = "Trapped in Vines";
		this.m.Description = "Thick vines of unnatural growth hold this character in place and hamper their ability to defend themself. To break free, the vines will have to be cut down.";
		this.m.Icon = "skills/status_effect_55.png";
		this.m.IconMini = "status_effect_55_mini";
		this.m.Overlay = "status_effect_55";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
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
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Unable to move[/color]"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color] Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color] Agility"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= 0.65;
		_properties.InitiativeMult *= 0.65;
	}

});

