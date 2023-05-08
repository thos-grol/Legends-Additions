::Const.Tactical.Actor.BarbarianMarauder = {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 120,
	Bravery = 80,
	Stamina = 130,
	MeleeSkill = 65,
	RangedSkill = 60,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 115,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/humans/barbarian_marauder", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_body = this.actor.getSprite("tattoo_body");
			local body = this.actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			local tattoo_head = this.actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}

		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BarbarianMarauder);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.Skills.update();
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_wildmen_01");
		this.m.Skills.add(this.new("scripts/skills/actives/barbarian_fury_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		if (this.LegendsMod.Configs().LegendTherianthropyEnabled())
		{
			if (this.Math.rand(1, 20) == 1)
			{
				this.m.Skills.add(this.new("scripts/skills/injury_permanent/legend_aperthropy_injury"));
			}
		}

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_alert"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_balance"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_onslaught"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_mastery_fist"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 60)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r = this.Math.rand(1, 5);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/axehammer"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/crude_axe"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/skull_hammer"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/weapons/barbarians/two_handed_spiked_mace"));
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 40)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_javelin"));
				}
				else if (r == 3)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_spear"));
				}
			}
			else
			{
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/barbarians/heavy_javelin"));
				}
			}
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null && this.Math.rand(1, 100) <= 20)
		{
			this.m.Items.equip(this.new("scripts/items/shields/wooden_shield_old"));
		}

		local armor = [
			[
				33,
				"barbarians/scrap_metal_armor"
			],
			[
				34,
				"barbarians/hide_and_bone_armor"
			],
			[
				33,
				"barbarians/reinforced_animal_hide_armor"
			]
		];

		if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
		{
			armor.push([
				5,
				"barbarians/legend_barbarian_southern_armor"
			]);
		}

		this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		local item = this.Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_headband"
			],
			[
				1,
				"barbarians/bear_headpiece"
			],
			[
				1,
				"barbarians/leather_helmet"
			],
			[
				1,
				"barbarians/crude_metal_helmet"
			],
			[
				1,
				""
			]
		]);

		if (item != null)
		{
			this.m.Items.equip(item);
		}
	}

});

