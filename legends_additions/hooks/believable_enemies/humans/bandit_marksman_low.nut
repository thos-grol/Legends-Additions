::mods_hookExactClass("entity/tactical/enemies/bandit_marksman_low", function(o) {

	o.addArmor <- function()
	{
		local item = this.Const.World.Common.pickArmor([
			[
				20,
				"leather_wraps"
			]
		]);
		this.m.Items.equip(item);

		if (this.Math.rand(0, 1) == 0)
		{
			local item = this.Const.World.Common.pickHelmet([
				[
					5,
					"headscarf"
				],
				[
					5,
					"mouth_piece"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}

	}
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
					"weapons/short_bow"
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
});
