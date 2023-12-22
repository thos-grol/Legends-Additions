this.goblin_fighter <- this.inherit("scripts/entity/tactical/goblin", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.GoblinFighter;
		this.m.XP = ::Const.Tactical.Actor.GoblinFighter.XP;
		this.goblin.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GoblinFighter);
		b.DamageDirectMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + ::Math.rand(1, 3));
		this.addDefaultStatusSprites();
	}

	function pickOutfit()
	{
		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Body) == null)
		{
			local item = ::Const.World.Common.pickArmor([
				[
					1,
					"greenskins/goblin_light_armor"
				],
				[
					1,
					"greenskins/goblin_medium_armor"
				],
				[
					1,
					"greenskins/goblin_heavy_armor"
				]
			]);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Head) == null)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					75,
					"greenskins/goblin_light_helmet"
				],
				[
					25,
					"greenskins/goblin_heavy_helmet"
				]
			]);

			if (item != null) this.m.Items.equip(item);
		}
	}

	function pickNamed()
	{
		this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

