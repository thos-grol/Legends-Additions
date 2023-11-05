this.orc_young_low <- this.inherit("scripts/entity/tactical/enemies/orc_young", {
	m = {},
	function create()
	{
		this.orc_young.create();
	}

	function onInit()
	{
		this.orc_young.onInit();
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

