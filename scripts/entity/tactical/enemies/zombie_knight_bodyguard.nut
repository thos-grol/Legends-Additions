this.zombie_knight_bodyguard <- this.inherit("scripts/entity/tactical/enemies/zombie_knight", {
	m = {},
	function create()
	{
		this.m.IsCreatingAgent = false;
		this.zombie_knight.create();
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_knight_bodyguard";
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/zombie_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.zombie_knight.onInit();
		local b = this.m.BaseProperties;
	}

});

