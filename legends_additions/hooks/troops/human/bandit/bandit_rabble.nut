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
		local r = this.Math.rand(1, 13);
		local item;

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_pitchfork"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"straw_hat"
					]
				]);
			}
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_wooden_spear"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_militia_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_militia_damage"));
				this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"open_leather_cap"
					]
				]);
			}
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_sickle"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_sickle_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_sickle_damage"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"hood"
					]
				]);
			}
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_staff"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_staff_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mastery_staff_stun"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"hood"
					]
				]);
			}
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shovel"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shovel_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shovel_damage"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"hood"
					]
				]);
			}
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_rebound"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"straw_hat"
					]
				]);
			}
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hammer"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_hammer_damage"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"mouth_piece"
					]
				]);
			}
		}
		else if (r == 8)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_shiv"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_knife_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_knife_damage"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"headscarf"
					]
				]);
			}
		}
		else if (r == 9)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/lute"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_lute_damage"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_mind_over_body"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"feathered_hat"
					]
				]);
			}
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_butcher_damage"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"mouth_piece"
					]
				]);
			}
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_saw"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_woodaxe_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_woodaxe_damage"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"headscarf"
					]
				]);
			}
		}
		else if (r == 12)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/legend_hoe"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"straw_hat"
					]
				]);
			}
		}
		else if (r == 13)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/wooden_flail"));

			if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			{
				this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_pitchfork_damage"));
				item = this.Const.World.Common.pickHelmet([
					[
						1,
						"cultist_hood"
					]
				]);
			}
		}

		this.m.Items.equip(item);

		if (this.Math.rand(1, 100) <= 90)
		{
			local item = this.Const.World.Common.pickArmor([
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
	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		local weapons = [
			"legend_named_blacksmith_hammer",
			"legend_named_butchers_cleaver",
			"legend_named_shovel",
			"legend_named_sickle"
		];
		this.m.Items.unequip(this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		this.m.Items.equip(this.new("scripts/items/named/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
	}

	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditRabble);
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

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 40)
		{
			b.MeleeDefense += 5;
		}

		this.setArmorSaturation(0.8);
		this.getSprite("shield_icon").setBrightness(0.9);

	}

});

