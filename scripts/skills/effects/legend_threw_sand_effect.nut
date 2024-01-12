this.legend_threw_sand_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.legend_threw_sand_effect";
		this.m.Name = "Threw pocket sand";
		this.m.Icon = "ui/perks/throw_sand_01.png";
		this.m.IconMini = "mini_throw_sand_circle";
		this.m.Overlay = "mini_throw_sand_circle";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function getDescription()
	{
		return "This character has thrown pocket sand and can\'t do so again this battle";
	}

});

