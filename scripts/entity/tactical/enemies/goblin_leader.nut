this.goblin_leader <- this.inherit("scripts/entity/tactical/goblin", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.GoblinLeader;
		this.m.XP = this.Const.Tactical.Actor.GoblinLeader.XP;
		this.goblin.create();
		this.m.SoundPitch = this.Math.rand(85, 95) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_leader_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinLeader);
		b.TargetAttractionMult = 1.5;
		b.DamageDirectMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_03_head_01");
		this.addDefaultStatusSprites();

		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/actives/goblin_whip"));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && _skill.isRanged()) this.updateAchievement("Outgunned", 1, 1);
		this.goblin.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		this.goblin.assignRandomEquipment();
		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_falchion"));
	}

	function pickOutfit()
	{
		local item = this.Const.World.Common.pickArmor([
			[
				1,
				"greenskins/goblin_leader_armor"
			]
		]);
		this.m.Items.equip(item);
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"greenskins/goblin_leader_helmet"
			]
		]);
		this.m.Items.equip(item);
	}

});

