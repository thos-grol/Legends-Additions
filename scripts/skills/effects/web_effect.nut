this.web_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.web";
		this.m.Name = "Trapped in Web";
		this.m.Description = "A large and sticky web holds this character in place and hampers their ability to defend themself and to put real force behind any blows. To break free, the web will have to be cut.";
		this.m.Icon = "skills/status_effect_80.png";
		this.m.IconMini = "status_effect_80_mini";
		this.m.Overlay = "status_effect_80";
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
				id = 13,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Twice as much damage received by a Webknecht\'s attack will ignore armor[/color]"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Damage"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Defense"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color] Agility"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsRooted = true;
		_properties.DamageTotalMult *= 0.5;
		_properties.MeleeDefenseMult *= 0.5;
		_properties.InitiativeMult *= 0.5;
		_properties.TargetAttractionMult *= 1.5;
	}

});

