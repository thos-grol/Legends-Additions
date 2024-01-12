this.bandit_marksman <- this.inherit("scripts/entity/tactical/abstract_human", {
	m = {},
	function create()
	{
		this.m.Name = "Raider";
		this.m.Type = ::Const.EntityType.BanditMarksman;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.BanditMarksman.XP;
		this.abstract_human.create();
		this.m.Faces = ::Const.Faces.AllMale;
		this.m.Hairs = ::Const.Hair.UntidyMale;
		this.m.HairColors = ::Const.HairColors.All;
		this.m.Beards = ::Const.Beards.Raider;

		if (::Math.rand(1, 100) <= 10)
		{
			this.setGender(1);
		}

		this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.abstract_human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditMarksman);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (::Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = ::Math.rand(150, 255);
		}

		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
	}

	function onAppearanceChanged( _appearance, _setDirty = true )
	{
		this.actor.onAppearanceChanged(_appearance, false);
		this.setDirty(true);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && _skill.isRanged())
		{
			this.updateAchievement("TasteYourOwnMedicine", 1, 1);
		}

		this.human.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function assignRandomEquipment()
	{
		this.abstract_human.assignRandomEquipment();

		local r = ::Math.rand(1, 3);
		if (r == 1) this.m.Items.addToBag(this.new("scripts/items/weapons/dagger"));
		else if (r == 2) this.m.Items.addToBag(this.new("scripts/items/weapons/hatchet"));
		else this.m.Items.addToBag(this.new("scripts/items/weapons/bludgeon"));
	}

	function pickOutfit()
	{
		local item = ::Const.World.Common.pickArmor([
			[
				20,
				"thick_tunic"
			],
			[
				20,
				"padded_surcoat"
			],
			[
				20,
				"leather_wraps"
			],
			[
				20,
				"blotched_gambeson"
			]
		]);
		this.m.Items.equip(item);

		if (::Math.rand(1, 100) <= 50)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					20,
					"hood"
				],
				[
					20,
					"open_leather_cap"
				],
				[
					20,
					"headscarf"
				],
				[
					20,
					"full_leather_cap"
				],
				[
					20,
					"mouth_piece"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}

});

