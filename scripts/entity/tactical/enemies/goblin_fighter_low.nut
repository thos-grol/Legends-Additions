this.goblin_fighter_low <- this.inherit("scripts/entity/tactical/enemies/goblin_fighter", {
	m = {},
	function create()
	{
		this.goblin_fighter.create();
		this.m.IsLow = true;
	}

	function onInit()
	{
		this.goblin_fighter.onInit();
		this.m.BaseProperties.MeleeSkill -= 5;
		this.m.BaseProperties.RangedDefense -= 5;
		this.m.BaseProperties.MeleeDefense -= 5;
		this.m.BaseProperties.DamageDirectMult = 1.0;
		this.m.Skills.update();
	}

});

