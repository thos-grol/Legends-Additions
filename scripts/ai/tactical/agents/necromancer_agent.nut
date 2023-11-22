this.necromancer_agent <- this.inherit("scripts/ai/tactical/agent", {
	m = {},
	function create()
	{
		this.agent.create();
		this.m.ID = this.Const.AI.Agent.ID.Necromancer;
		this.m.Properties.OverallMagnetismMult = 3.0;
	}

	function onAddBehaviors()
	{
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));

		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_puncture"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_splitshield"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_swing"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_split"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_thresh"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_crush_armor"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_decapitate"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_knock_out"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_distract"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_lash"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_gash"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_deathblow"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_reap"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_spearwall"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_shieldwall"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_riposte"));
		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_recover"));

		this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
	}

	function onTurnStarted()
	{
		this.agent.onTurnStarted();
		local allies = this.Tactical.Entities.getInstancesOfFaction(this.getActor().getFaction());
		local myTile = this.getActor().getTile();
		local nearest = 9999;

		foreach( a in allies )
		{
			if (a.getID() == this.getActor().getID())
			{
				continue;
			}

			local d = a.getTile().getDistanceTo(myTile);

			if (d < nearest)
			{
				nearest = d;
			}
		}

		if (nearest >= 10)
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageRanged] = 1.0;
		}
		else
		{
			this.m.Properties.BehaviorMult[this.Const.AI.Behavior.ID.EngageRanged] = 0.0;
		}
	}

});

