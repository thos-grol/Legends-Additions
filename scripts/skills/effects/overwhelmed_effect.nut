this.overwhelmed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Count = 1
	},
	function create()
	{
		this.m.ID = "effects.overwhelmed";
		this.m.Name = "Overwhelmed";
		this.m.Description = "This character has been overwhelmed with a flurry of attacks to defend against, leaving few openings to effectively attack for himself.";
		this.m.Icon = "skills/status_effect_74.png";
		this.m.IconMini = "status_effect_74_mini";
		this.m.Overlay = "status_effect_74";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		if (this.m.Count <= 1)
		{
			return this.m.Name;
		}
		else
		{
			return this.m.Name + " (x" + this.m.Count + ")";
		}
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 10 + "%[/color] Melee Skill"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.Count * 10 + "%[/color] Ranged Skill"
			}
		];
	}

	function onRefresh()
	{
		++this.m.Count;
		this.spawnIcon("status_effect_74", this.getContainer().getActor().getTile());
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkillMult = this.Math.maxf(0.0, _properties.MeleeSkillMult - 0.1 * this.m.Count);
		_properties.RangedSkillMult = this.Math.maxf(0.0, _properties.RangedSkillMult - 0.1 * this.m.Count);
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

	function onNewRound()
	{
		this.removeSelf();
	}

});

