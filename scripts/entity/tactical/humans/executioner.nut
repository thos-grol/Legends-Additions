this.executioner <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Name = "Executioner";
		this.m.Type = this.Const.EntityType.Executioner;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Executioner.XP;
		this.abstract_human.create();
		this.m.Bodies = this.Const.Bodies.Gladiator;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.Body = this.Math.rand(0, this.m.Bodies.len() - 1);
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Executioner);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
	}

	function pickOutfit()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			this.m.Items.equip(this.Const.World.Common.pickArmor([
				[
					1,
					"lamellar_harness"
				],
				[
					1,
					"heavy_lamellar_armor"
				]
			]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helm = [
				[
					3,
					"oriental/nomad_reinforced_helmet"
				],
				[
					3,
					"oriental/southern_helmet_with_coif"
				],
				[
					3,
					"oriental/turban_helmet"
				]
			];
			helm.push([
				1,
				"oriental/janissary_helmet"
			]);
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helm));
		}
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = this.Math.rand(1, 3);
		if (r == 1)
		{
			local armor = clone this.Const.Items.NamedSouthernArmors;
			this.m.Items.equip(this.Const.World.Common.pickArmor(this.Const.World.Common.convNameToList(armor)));
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

