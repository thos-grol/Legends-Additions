this.intimidated_effect <- this.inherit("scripts/skills/skill", {
	m = {
		ResolveMalus = 0
	},
	function create()
	{
		this.m.ID = "effects.intimidated";
		this.m.Name = "Intimidated";
		this.m.Description = "This character has recently faced some very intimidating attacks.";
		this.m.Icon = "ui/perks/intimidate.png";
		this.m.IconMini = "intimidated_mini";
		this.m.Overlay = "intimidated";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getName()
	{
		return this.m.Name + " (– "+ this.m.ResolveMalus +" Will)";
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + this.m.ResolveMalus + "[/color] Will"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.Bravery -= this.m.ResolveMalus;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}
});
