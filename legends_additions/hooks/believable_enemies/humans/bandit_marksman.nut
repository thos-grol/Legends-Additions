//Hunter Template
//Level 8 Hunter Template, 7 perks
::Const.Tactical.Actor.BanditMarksman <- {
	XP = 225,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 45,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 55,
	MeleeDefense = 5,
	RangedDefense = 8,
	Initiative = 110,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::mods_hookExactClass("entity/tactical/enemies/bandit_marksman", function(o)
{
	o.m.build_num <- 0;

	o.assignRandomEquipment = function()
	{
		this.addArmor();

		//Base perks
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully")); //tribal perk

		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble")); //6


		switch(this.Math.rand(0, 1))
		{
			case 0:
				local weapons = [
					"weapons/short_bow",
					"weapons/hunting_bow"
				];
				this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(weapons)));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));

				this.m.build_num = this.Math.rand(0, 1);

				switch(this.m.build_num)
				{
					case 0: //quick shot
						this.m.Skills.add(::new("scripts/skills/perks/perk_recover")); //1
						// this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
						this.m.Skills.add(::new("scripts/skills/perks/perk_rotation")); //3
						this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_bow")); //4
						this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_eyes_up")); //5
						// this.m.Skills.add(::new("scripts/skills/perks/perk_nimble")); //6
						this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_hip_shooter")); //7
						this.level_ranged_skill(7, this.Math.rand(-6, 3) );
						this.level_melee_defense(4, 1);
						this.level_initiative(4, this.Math.rand(-6, 3) );
						this.level_fatigue(6, this.Math.rand(-6, 3) );
						break;
					case 0: //aimed shot
						this.m.Skills.add(::new("scripts/skills/perks/perk_recover")); //1
						// this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
						this.m.Skills.add(::new("scripts/skills/perks/perk_bullseye")); //2 -> 3
						this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_bow")); //4
						this.m.Skills.add(::new("scripts/skills/perks/perk_footwork")); //5
						this.m.Skills.removeByID("perk.nimble");
						this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_flaming_arrows")); //6
						this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_marksmanship")); //7
						this.level_ranged_skill(7, this.Math.rand(-6, 3) );
						this.level_melee_defense(7, 1);
						this.level_initiative(4, this.Math.rand(-6, 3) );
						this.level_fatigue(3, this.Math.rand(-6, 3) );
						break;

				}
				break;
			case 1:
				local weapons = [
					"weapons/crossbow",
					"weapons/light_crossbow"
				];
				this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(weapons)));
				this.m.Items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));

				this.m.build_num = 2;
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_power_shot")); //1
				// this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
				this.m.Skills.add(::new("scripts/skills/perks/perk_rotation")); //3
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_crossbow")); //4
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_iron_sights")); //5
				// this.m.Skills.add(::new("scripts/skills/perks/perk_nimble")); //6
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_muscle_memory")); //7
				this.level_ranged_skill(7, this.Math.rand(-6, 3) );
				this.level_melee_defense(7, 1);
				this.level_initiative(4, this.Math.rand(-6, 3) );
				this.level_fatigue(3, this.Math.rand(-6, 3) );
				break;
		}

		this.m.Skills.addTreeOfEquippedWeapon(4);

		//add random melee weapon to bag
		local weapons = [
			"weapons/dagger",
			"weapons/knife",
			"weapons/hatchet",
			"weapons/bludgeon"
		];
		this.m.Items.addToBag(::new("scripts/items/" + ::MSU.Array.rand(weapons)));
	}

	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditMarksman);
		b.TargetAttractionMult = 1.1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 20)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
			dirt.Alpha = this.Math.rand(150, 255);
		}

		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);
	}

	o.addArmor <- function()
	{
		local item = this.Const.World.Common.pickArmor([
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

		if (this.Math.rand(1, 100) <= 50)
		{
			local item = this.Const.World.Common.pickHelmet([
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
