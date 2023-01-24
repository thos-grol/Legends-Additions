//Bandit Thug
//Lvl 5 peasant templates
//Avg Daytaler stats, 1 tribal perk + 4 perks
//1 defensive perk like poacher
//3 combat perks
::Const.Tactical.Actor.BanditThug <- {
	XP = 150,
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

::mods_hookExactClass("entity/tactical/enemies/bandit_thug", function(o) {
	o.assignRandomEquipment = function()
	{
		//TODO: finish all the builds for bandit_thug
		//tribal trait
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));
		//defensive perk
		if(this.Math.rand(1, 6) < 6) this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_strength_in_numbers"));
		else this.m.Skills.add(::new("scripts/skills/perks/perk_dodge"));

		local r = this.Math.rand(1, 15);

		if (r == 1)
		{
			r = this.Math.rand(1, 3);
			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
				this.level_resolve(4, this.Math.rand(1, 4) > 3 ? 0 : 1 );
				this.level_melee_skill(4, this.Math.rand(1, 4) > 3 ? 0 : 1 );
				this.level_melee_defense(4, this.Math.rand(1, 4) > 3 ? 0 : 1 );

			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/goedendag"));
				this.level_resolve(4, this.Math.rand(1, 4) > 3 ? 0 : 1 );
				this.level_melee_skill(4, this.Math.rand(1, 4) > 3 ? 0 : 1 );
				this.level_melee_defense(4, this.Math.rand(1, 4) > 3 ? 0 : 1 );

			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
				this.level_melee_skill(4, this.Math.rand(1, 4) > 3 ? 0 : 1 );
				this.level_melee_defense(4, this.Math.rand(1, 4) > 3 ? 0 : 1 );
				this.level_initiative(4, this.Math.rand(1, 4) > 3 ? 0 : 1 );
			}


		}
		else
		{
			//TODO: 1h rolls stats no stars
			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
				}
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
				}
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
				}
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
				}
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/pickaxe"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smackdown"));
				}
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
				}
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/wooden_flail"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
				}
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_bloodbath"));
				}
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/dagger"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_duelist"));
				}
			}
			else if (r == 11)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_scythe"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
				}
			}
			else if (r == 12)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_tipstaff"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_return_favor"));
				}
			}
			else if (r == 13)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_militia_glaive"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
				}
			}
			else if (r == 14)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_tipstaff"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
				}
			}
			else if (r == 15)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/legend_ranged_wooden_flail"));

				if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
				{
					this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
				}
			}

			if (this.Math.rand(1, 100) <= 50)
			{
				local r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
				}
			}
		}

		local item = this.Const.World.Common.pickArmor([
			[
				20,
				"blotched_gambeson"
			],
			[
				20,
				"ragged_surcoat"
			],
			[
				20,
				"padded_surcoat"
			],
			[
				20,
				"thick_tunic"
			],
			[
				20,
				"gambeson"
			]
		]);
		if (item != null)
		{
			this.m.Items.equip(item);
		}

		item = this.Const.World.Common.pickHelmet([
			[
				1,
				"hood"
			],
			[
				1,
				"open_leather_cap"
			],
			[
				1,
				"headscarf"
			],
			[
				1,
				"mouth_piece"
			],
			[
				1,
				"full_leather_cap"
			],
			[
				1,
				"aketon_cap"
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditThug);
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
