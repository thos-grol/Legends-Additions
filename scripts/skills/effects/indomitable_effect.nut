this.indomitable_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.indomitable";
		this.m.Name = "Indomitable";
		this.m.Icon = "ui/perks/perk_30.png";
		this.m.IconMini = "perk_30_mini";
		this.m.Overlay = "perk_30";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has gathered all their physical strength and willpower to become indomitable until their next turn.";
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
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Receives only [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] of any damage"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being stunned"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being knocked back or grabbed"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedTotalMult *= 0.5;
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
	}

	function onTurnStart()
	{
		local indomitable = _user.getSkills().getSkillByID("perk.indomitable");
		if (indomitable != null && indomitable.m.On) return;
		this.removeSelf();
	}

});

