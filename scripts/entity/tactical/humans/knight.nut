this.knight <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Knight;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Knight.XP;
		this.m.Name = this.generateName();
		this.m.IsGeneratingKillName = false;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.SmartMale;
		this.m.Hairs = ::Const.Hair.CommonMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Tidy;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		return ::Const.Strings.KnightNames[::Math.rand(0, ::Const.Strings.KnightNames.len() - 1)];
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Knight);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_military");
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("AKnightsTale", 1, 1);
		}

		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function pickOutfit()
	{
		local r;
		local banner = 4;

		if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())
		{
			banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
		}
		else
		{
			banner = this.getFaction();
		}

		this.m.Surcoat = banner;

		if (::Math.rand(1, 100) <= 90)
		{
			this.getSprite("surcoat").setBrush("surcoat_" + (banner < 10 ? "0" + banner : banner));
		}

		this.m.Items.equip(::Const.World.Common.pickArmor([
			[
				1,
				"coat_of_plates"
			],
			[
				1,
				"coat_of_scales"
			]
		]));

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
		{
			this.m.Items.equip(::Const.World.Common.pickHelmet([
				[
					30,
					"full_helm"
				],
				[
					5,
					"legend_helm_breathed"
				],
				[
					5,
					"legend_helm_full"
				],
				[
					5,
					"legend_helm_bearded"
				],
				[
					5,
					"legend_helm_point"
				],
				[
					5,
					"legend_helm_snub"
				],
				[
					5,
					"legend_helm_wings"
				],
				[
					5,
					"legend_helm_short"
				],
				[
					5,
					"legend_helm_curved"
				],
				[
					2,
					"legend_enclave_vanilla_great_helm_01"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_01"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_02"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_03"
				],
				[
					15,
					"faction_helm",
					banner
				],
				[
					5,
					"legend_frogmouth_helm"
				],
				[
					1,
					"legend_frogmouth_helm_crested"
				]
			]));
		}
	}

	function post_init()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Offhand))
		{
			local shield = this.new("scripts/items/shields/faction_heater_shield");
			local banner = 4;
			if (("State" in this.Tactical) && this.Tactical.State != null && !this.Tactical.State.isScenarioMode())
			{
				banner = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
			}
			else
			{
				banner = this.getFaction();
			}
			shield.setFaction(banner);
			this.m.Items.equip(shield);
		}
	}

	function pickNamed()
	{
		//decide what item will be named
		local r = ::Math.rand(1, 2);
		if (r == 1) //armor
		{
			local armor = [
				"armor/named/brown_coat_of_plates_armor",
				"armor/named/golden_scale_armor",
				"armor/named/green_coat_of_plates_armor",
				"armor/named/heraldic_mail_armor"
			];
			local h = ::Const.World.Common.pickArmor(::Const.World.Common.convNameToList(armor));
			this.m.Items.equip(h);
		}
		else
		{
			this.m.IsMinibossWeapon <- true;
			local shields = clone ::Const.Items.NamedShields;
			this.m.Items.equip(this.new("scripts/items/" + shields[::Math.rand(0, shields.len() - 1)]));
		}

		this.m.Items.equip(::Const.World.Common.pickHelmet([
			[
				3,
				"named/legend_frogmouth_helm_crested_painted"
			],
			[
				3,
				"named/bascinet_named"
			],
			[
				3,
				"named/kettle_helm_named"
			],
			[
				3,
				"named/deep_sallet_named"
			],
			[
				3,
				"named/barbute_named"
			],
			[
				3,
				"named/italo_norman_helm_named"
			],
			[
				1,
				"named/legend_helm_full_named"
			]
		]));
	}

	function makeMiniboss()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

});

