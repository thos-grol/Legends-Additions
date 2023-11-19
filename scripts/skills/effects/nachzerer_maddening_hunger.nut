this.mark_of_decay <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 1
	},
	function create()
	{
		this.m.ID = "effects.nachzerer_maddening_hunger";
		this.m.Name = "Maddening Hunger";
		this.m.Icon = "skills/status_effect_10.png";
		this.m.IconMini = "status_effect_10_mini";
		this.m.Overlay = "status_effect_93";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsSerialized = true;
	}

	function addStacks( _amount )
	{
		this.m.Stacks = this.Math.min(3, this.m.Stacks + _amount);
	}

	function getDescription()
	{
		return "Maddening hunger drives this unit's attacks to be more accurate. This effect lasts until the unit swallows or feasts upon a corpse.";
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
				id = 11,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Melee Skill"
			},
			{
				id = 7,
				type = "hint",
				icon = "ui/icons/action_points.png",
				text = "Max stacks is 3"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 10 * this.m.Stacks;
	}

});

