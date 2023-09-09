this.legend_holding_the_line <- this.inherit("scripts/skills/effects/legend_commander_abstract_effect", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_holding_the_line";
		this.m.Name = "Holding the line";
		this.m.Description = "You WILL hold! An inspirational leader has encouraged this character to hold their ground.";
		this.m.Icon = "ui/perks/holdtheline_circle.png";
		this.m.IconMini = "mini_holdtheline_circle";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Receive only [color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] of any damage"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/locked_small.png",
				text = "Immune to being knocked back or grabbed"
			}
		]);
		return tooltip;
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedTotalMult *= 0.75;
		_properties.IsImmuneToKnockBackAndGrab = true;
	}

});

