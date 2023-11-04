this.spider_bodyguard <- this.inherit("scripts/entity/tactical/enemies/spider", {
	m = {},
	function create()
	{
		this.spider.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/spider_bodyguard_agent");
		this.m.AIAgent.setActor(this);
	}

});

