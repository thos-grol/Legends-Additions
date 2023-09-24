this.la_direwolf_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = ::Const.AI.Agent.ID.Direwolf;
		this.m.Properties.TargetPriorityHitchanceMult = 0.5;
		this.m.Properties.TargetPriorityHitpointsMult = 0.25;
		this.m.Properties.TargetPriorityRandomMult = 0.25;
		this.m.Properties.TargetPriorityDamageMult = 0.25;
		this.m.Properties.TargetPriorityFleeingMult = 0.75;
		this.m.Properties.TargetPriorityHittingAlliesMult = 0.1;
		this.m.Properties.TargetPriorityCounterSkillsMult = 0.75;
		this.m.Properties.OverallDefensivenessMult = 0.0;
		this.m.Properties.OverallFormationMult = 1.0;
		this.m.Properties.EngageFlankingMult = 1.75;
		this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.5;
		this.m.Properties.EngageLockDownTargetMult = 2.0;
		this.m.Properties.PreferCarefulEngage = false;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_roam"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));

		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_direwolf_bite"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_direwolf_hunt"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_direwolf_indomitable"));
	}

});

