this.goblin_ambusher <- this.inherit("scripts/entity/tactical/goblin", {
	m = {
		IsLow = false
	},
	function create()
	{
		this.m.Type = this.Const.EntityType.GoblinAmbusher;
		this.m.XP = this.Const.Tactical.Actor.GoblinAmbusher.XP;
		this.goblin.create();
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/goblin_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.goblin.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.GoblinAmbusher);
		b.DamageDirectMult = 1.25;
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.getSprite("head").setBrush("bust_goblin_01_head_0" + this.Math.rand(1, 3));
		this.getSprite("quiver").Visible = true;
		this.addDefaultStatusSprites();

		if (!this.m.IsLow) b.Vision = 8;
		this.m.Skills.add(this.new("scripts/skills/racial/goblin_ambusher_racial"));
	}

	function assignRandomEquipment()
	{
		this.goblin.assignRandomEquipment();
		this.m.Items.addToBag(this.new("scripts/items/weapons/greenskins/goblin_notched_blade"));
		if (this.Math.rand(1, 100) <= 10) this.m.Items.addToBag(this.new("scripts/items/accessory/poison_item"));
	}

	function pickOutfit()
	{
		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			local item = this.Const.World.Common.pickArmor([
				[
					1,
					"greenskins/goblin_skirmisher_armor"
				]
			]);
			this.m.Items.equip(item);
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
		{
			local item = this.Const.World.Common.pickHelmet([
				[
					1,
					"greenskins/goblin_skirmisher_helmet"
				]
			]);
			this.m.Items.equip(item);
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

