this.desert_devil <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Name = "Blade Dancer";
		this.m.Type = ::Const.EntityType.DesertDevil;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.DesertDevil.XP;
		this.abstract_human.create();
		this.m.Bodies = ::Const.Bodies.SouthernMale;
		this.m.Faces = ::Const.Faces.SouthernMale;
		this.m.Hairs = ::Const.Hair.SouthernMale;
		this.m.HairColors = ::Const.HairColors.Southern;
		this.m.Beards = ::Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bounty_hunter_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.DesertDevil);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_nomads");
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("DanceOff", 1, 1);
		}

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
				"oriental/assassin_robe"
			],
			[
				1,
				"blade_dancer_armor_00"
			]
		]));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			local helm = ::Const.World.Common.pickHelmet([
				[
					1,
					"oriental/blade_dancer_head_wrap"
				],
				[
					1,
					"blade_dancer_helmet_00"
				]
			]);
			this.m.Items.equip(helm);
		}
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
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

