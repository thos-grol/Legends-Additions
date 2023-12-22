this.zombie_yeoman <- this.inherit("scripts/entity/tactical/enemies/zombie", {
	m = {},
	function create()
	{
		this.zombie.create();
		this.m.Type = ::Const.EntityType.ZombieYeoman;
		this.m.BloodType = ::Const.BloodType.Dark;
		this.m.MoraleState = ::Const.MoraleState.Ignore;
		this.m.XP = ::Const.Tactical.Actor.ZombieYeoman.XP;
		this.m.ResurrectionValue = 3.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_yeoman";
	}

	function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.ZombieYeoman);
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToBleeding = true;

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 20)
		{
			b.FatigueDealtPerHitMult = 2.0;
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 90)
		{
			b.DamageTotalMult += 0.1;
		}

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Skills.update();
	}

	function pickOutfit()
	{
		local aList = [
			[
				1,
				"padded_leather"
			],
			[
				1,
				"worn_mail_shirt"
			],
			[
				1,
				"patched_mail_shirt"
			],
			[
				1,
				"ragged_surcoat"
			],
			[
				1,
				"basic_mail_shirt"
			]
		];
		local armor = ::Const.World.Common.pickArmor(aList);

		if (::Math.rand(1, 100) <= 66)
		{
			armor.setArmor(::Math.round(armor.getArmorMax() / 2 - 1));
		}

		this.m.Items.equip(armor);

		if (::Math.rand(1, 100) <= 75)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					1,
					"aketon_cap"
				],
				[
					1,
					"full_aketon_cap"
				],
				[
					1,
					"kettle_hat"
				],
				[
					1,
					"padded_kettle_hat"
				],
				[
					1,
					"dented_nasal_helmet"
				],
				[
					1,
					"mail_coif"
				],
				[
					1,
					"full_leather_cap"
				]
			]);

			if (item != null)
			{
				if (::Math.rand(1, 100) <= 66)
				{
					item.setArmor(::Math.round(item.getArmorMax() / 2 - 1));
				}

				this.m.Items.equip(item);
			}
		}
	}

});

