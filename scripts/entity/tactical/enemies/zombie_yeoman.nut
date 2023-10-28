this.zombie_yeoman <- this.inherit("scripts/entity/tactical/enemies/zombie", {
	m = {},
	function create()
	{
		this.zombie.create();
		this.m.Type = this.Const.EntityType.ZombieYeoman;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.ZombieYeoman.XP;
		this.m.ResurrectionValue = 3.0;
		this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_yeoman";
	}

	function onInit()
	{
		this.zombie.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.ZombieYeoman);
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
		local armor = this.Const.World.Common.pickArmor(aList);

		if (this.Math.rand(1, 100) <= 66)
		{
			armor.setArmor(this.Math.round(armor.getArmorMax() / 2 - 1));
		}

		this.m.Items.equip(armor);

		if (this.Math.rand(1, 100) <= 75)
		{
			local item = this.Const.World.Common.pickHelmet([
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
				if (this.Math.rand(1, 100) <= 66)
				{
					item.setArmor(this.Math.round(item.getArmorMax() / 2 - 1));
				}

				this.m.Items.equip(item);
			}
		}
	}

});

