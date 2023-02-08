//Bandit Rabble
//Lvl 3 peasant template
//Avg Daytaler stats
::Const.Tactical.Actor.BanditRabble <- {
	XP = 100,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 35,
	Stamina = 95,
	MeleeSkill = 56,
	RangedSkill = 40,
	MeleeDefense = 3,
	RangedDefense = 3,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::mods_hookExactClass("entity/tactical/enemies/bandit_rabble", function(o) {

	o.assignRandomEquipment = function()
	{
		//roll stats
		this.level_health(2, 0);
		this.level_melee_skill(2, 0);
		this.level_melee_defense(2, 0);

		local r = this.Math.rand(1, 13);
		local item;

		if (r == 1)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_wooden_pitchfork"));
			item = ::Const.World.Common.pickHelmet([
				[
					1,
					"straw_hat"
				]
			]);
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_wooden_spear"));
			item = ::Const.World.Common.pickHelmet([
				[
					1,
					"open_leather_cap"
				]
			]);
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_militia_damage"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_sickle"));
			item = ::Const.World.Common.pickHelmet([
				[
					1,
					"hood"
				]
			]);
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_sickle_damage"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_staff"));
			item = ::Const.World.Common.pickHelmet([
				[
					1,
					"hood"
				]
			]);
			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_wear_them_down"));
		}
		else if (r == 5 || r == 6)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_shovel"));
			item = ::Const.World.Common.pickHelmet([
				[
					1,
					"hood"
				]
			]);
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_shovel_damage"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_hammer"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_hammer_damage"));
			item = ::Const.World.Common.pickHelmet([
				[
					1,
					"mouth_piece"
				]
			]);
		}
		else if (r == 8)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_shiv"));
			this.m.Skills.add(::new("scripts/skills/perks/perk_backstabber"));
				item = ::Const.World.Common.pickHelmet([
					[
						1,
						"headscarf"
					]
				]);
		}
		else if (r == 9 || r == 10)
		{
			this.m.Items.equip(::new("scripts/items/weapons/butchers_cleaver"));

			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_butcher_damage"));
				item = ::Const.World.Common.pickHelmet([
					[
						1,
						"mouth_piece"
					]
				]);
		}
		else if (r == 11)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_saw"));

			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_woodaxe_damage"));
				item = ::Const.World.Common.pickHelmet([
					[
						1,
						"headscarf"
					]
				]);
		}
		else if (r == 12)
		{
			this.m.Items.equip(::new("scripts/items/weapons/legend_hoe"));

			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
				item = ::Const.World.Common.pickHelmet([
					[
						1,
						"straw_hat"
					]
				]);
		}
		else if (r == 13)
		{
			this.m.Items.equip(::new("scripts/items/weapons/wooden_flail"));

			this.m.Skills.add(::new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
				item = ::Const.World.Common.pickHelmet([
					[
						1,
						"cultist_hood"
					]
				]);
		}

		this.m.Items.equip(item);

		if (this.Math.rand(1, 100) <= 90)
		{
			local item = ::Const.World.Common.pickArmor([
				[
					20,
					"leather_wraps"
				],
				[
					20,
					"tattered_sackcloth"
				],
				[
					20,
					"legend_rabble_tunic"
				],
				[
					20,
					"monk_robe"
				],
				[
					20,
					"legend_rabble_fur"
				]
			]);
			this.m.Items.equip(item);
		}

		//Add bandit tribal perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));

		local r = this.Math.rand(1, 6)
		if(r < 6) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
		else this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));
	}

	local onInit = o.onInit;
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditRabble);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");

		if (this.Math.rand(1, 100) <= 10)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_pox_01");
		}
		else if (this.Math.rand(1, 100) <= 15)
		{
			local pox = this.getSprite("tattoo_head");
			pox.Visible = true;
			pox.setBrush("bust_head_darkeyes_01");
		}
		else
		{
			local dirt = this.getSprite("dirt");
			dirt.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			this.getSprite("eye_rings").Visible = true;
		}

		this.setArmorSaturation(0.8);
		this.getSprite("shield_icon").setBrightness(0.9);
	}
});
