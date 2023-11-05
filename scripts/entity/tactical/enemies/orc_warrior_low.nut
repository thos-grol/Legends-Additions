this.orc_warrior_low <- this.inherit("scripts/entity/tactical/enemies/orc_warrior", {
	m = {},
	function create()
	{
		this.orc_warrior.create();
	}

	function onInit()
	{
		this.orc_warrior.onInit();
		this.m.BaseProperties.MeleeSkill -= 10;
		this.m.BaseProperties.MeleeDefense -= 5;
		this.m.BaseProperties.RangedDefense -= 5;
		this.m.Skills.update();
	}

	function onFinish()
	{
		this.actor.onFinish();
	}

});

