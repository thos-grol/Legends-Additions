//TODO: goblin_fighter
// "weapons/greenskins/goblin_falchion",
// "weapons/greenskins/goblin_spear",
// "weapons/legend_chain",
// "weapons/greenskins/goblin_notched_blade"

// "weapons/greenskins/goblin_pike"
"weapons/named/named_goblin_falchion",
"weapons/named/named_goblin_pike",
"weapons/named/named_goblin_spear"

//nets

this.goblin_fighter <- this.inherit("scripts/entity/tactical/goblin", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.GoblinFighter;
		this.m.XP = this.Const.Tactical.Actor.GoblinFighter.XP;
		this.goblin.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinFighter);
		b.DamageDirectMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + this.Math.rand(1, 3));
		this.addDefaultStatusSprites();
	}

	function pickOutfit()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local item = this.Const.World.Common.pickArmor([
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

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
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

