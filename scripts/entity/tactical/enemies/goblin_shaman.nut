this.goblin_shaman <- this.inherit("scripts/entity/tactical/goblin", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.GoblinShaman;
		this.m.XP = ::Const.Tactical.Actor.GoblinShaman.XP;
		this.goblin.create();
		this.m.SoundPitch = ::Math.rand(90, 100) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_shaman_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GoblinShaman);
		b.Vision = 8;
		b.TargetAttractionMult = 2.0;
		b.IsAffectedByNight = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_02_head_01");
		this.addDefaultStatusSprites();
		this.m.Skills.add(this.new("scripts/skills/racial/goblin_shaman_racial"));
		this.m.Skills.add(this.new("scripts/skills/actives/grant_night_vision_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/root_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/insects_skill"));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("Wildgrowth", 1, 1);
		}
		this.goblin.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function pickOutfit()
	{
		local item = ::Const.World.Common.pickArmor([
			[
				1,
				"greenskins/goblin_shaman_armor"
			]
		]);
		this.m.Items.equip(item);
		local item = ::Const.World.Common.pickHelmet([
			[
				1,
				"greenskins/goblin_shaman_helmet"
			]
		]);
		this.m.Items.equip(item);
	}

});

