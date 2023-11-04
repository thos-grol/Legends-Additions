this.goblin_ambusher_low <- this.inherit("scripts/entity/tactical/enemies/goblin_ambusher", {
	m = {},
	function create()
	{
		this.goblin_ambusher.create();
		this.m.IsLow = true;
	}

	function onInit()
	{
		this.goblin_ambusher.onInit();
		this.m.BaseProperties.MeleeSkill -= 5;
		this.m.BaseProperties.RangedSkill -= 5;
		this.m.BaseProperties.RangedDefense -= 5;
		this.m.BaseProperties.MeleeDefense -= 5;
		this.m.BaseProperties.DamageDirectMult = 1.0;
		this.m.Skills.update();
	}

});

