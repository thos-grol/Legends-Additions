this.dodge_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.dodge";
		this.m.Name = "Dodge";
		this.m.Description = "Quick reflexes allow this character to add part of their current initiative to melee and ranged defense.";
		this.m.Icon = "ui/perks/perk_01.png";
		this.m.IconMini = "perk_01_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsHidden = true;
	}

	function getTooltip()
	{
		local initiative = this.Math.max(0, this.Math.floor(this.getContainer().getActor().getInitiative() * 0.15));
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
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + initiative + "[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + initiative + "[/color] Ranged Defense"
			}
		];
	}

	function onAfterUpdate( _properties )
	{
		local initiative = this.Math.floor(this.getContainer().getActor().getInitiative() * 0.15);
		_properties.MeleeDefense += this.Math.max(0, initiative);
		_properties.RangedDefense += this.Math.max(0, initiative);
	}

});

