this.undead <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.undead";
		this.m.Name = "Undead";
		this.m.Description = "The undead fear nothing. And blows that would slay the living mostly have no effect on them.";
		this.m.Icon = "ui/perks/favoured_zombie_01.png";
		this.m.IsRemovedAfterBattle = false;
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
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
				id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Doubles hp."
			}
		];
	}

	o.onUpdate = function(_properties)
	{
		_properties.Hitpoints *= 2;
	}

});