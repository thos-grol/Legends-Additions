this.desert_stalker <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Name = "Stalker";
		this.m.Type = ::Const.EntityType.DesertStalker;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.DesertStalker.XP;
		this.abstract_human.create();
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMaleOnly;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.SouthernOnly;
		this.m.BeardChance = 100;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.DesertStalker);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && _skill.isRanged()) this.updateAchievement("Bullseye", 1, 1);
		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function pickOutfit()
	{
		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"oriental/plated_nomad_mail"
			]
		]));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && ::Math.rand(1, 100) <= 75)
		{
			local helm = ::Const.World.Common.pickHelmet([
				[
					1,
					"oriental/desert_stalker_head_wrap"
				]
			]);
			this.m.Items.equip(helm);
		}
	}

	function assignRandomEquipment()
	{
		this.abstract_human.assignRandomEquipment();
		this.m.Items.addToBag(::new("scripts/items/weapons/oriental/nomad_mace"));
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = ::Math.rand(1, 3);
		if (r == 1)
		{
			this.m.Items.equip(::Const.World.Common.pickArmor([
				[
					1,
					"named/black_leather_armor"
				]
			]));
		}
		else this.m.IsMinibossWeapon <- true;
	}

	function makeMiniboss()
	{
		this.actor.makeMiniboss();
		this.getSprite("miniboss").setBrush("bust_miniboss");
	}

});

