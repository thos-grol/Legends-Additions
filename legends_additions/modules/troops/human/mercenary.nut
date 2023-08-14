::Const.Tactical.Actor.Mercenary = {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 110,
	Bravery = 70,
	Stamina = 135,
	MeleeSkill = 75,
	RangedSkill = 65,
	MeleeDefense = 25,
	RangedDefense = 10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};
::mods_hookExactClass("entity/tactical/humans/mercenary", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Mercenary);
		b.IsSpecializedInSwords = true;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInMaces = true;
		b.IsSpecializedInFlails = true;
		b.IsSpecializedInPolearms = true;
		b.IsSpecializedInThrowing = true;
		b.IsSpecializedInHammers = true;
		b.IsSpecializedInSpears = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_rotation"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_rebound"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_clarity"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_footwork"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steadfast"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		local r;

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Mainhand))
		{
			local weapons = [
				"weapons/billhook",
				"weapons/pike",
				"weapons/warbrand",
				"weapons/longsword",
				"weapons/legend_longsword",
				"weapons/hand_axe",
				"weapons/fighting_spear",
				"weapons/legend_glaive",
				"weapons/morning_star",
				"weapons/falchion",
				"weapons/arming_sword",
				"weapons/flail",
				"weapons/military_pick",
				"weapons/legend_ranged_flail"
			];

			if (this.Const.DLC.Unhold)
			{
				weapons.extend([
					"weapons/polehammer",
					"weapons/three_headed_flail"
				]);
			}

			if (this.Const.DLC.Wildmen)
			{
				weapons.extend([
					"weapons/bardiche",
					"weapons/scimitar"
				]);
			}

			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			if (this.Math.rand(1, 100) <= 75)
			{
				r = this.Math.rand(0, 2);

				if (r == 0)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else if (r == 1)
				{
					this.m.Items.equip(this.new("scripts/items/shields/heater_shield"));
				}
				else if (r == 2)
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/tools/throwing_net"));
			}
		}

		if (this.getIdealRange() == 1 && this.Math.rand(1, 100) <= 60)
		{
			if (this.Const.DLC.Unhold)
			{
				r = this.Math.rand(1, 3);

				if (r == 1)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
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
					this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
				}
				else if (r == 2)
				{
					this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
				}
			}
		}

		local armor = [
			[
				1,
				"sellsword_armor"
			],
			[
				1,
				"reinforced_mail_hauberk"
			],
			[
				1,
				"mail_hauberk"
			],
			[
				1,
				"traze_northern_mercenary_armor"
			],
			[
				1,
				"northern_mercenary_armor_00"
			],
			[
				1,
				"northern_mercenary_armor_01"
			],
			[
				1,
				"northern_mercenary_armor_02"
			],
			[
				1,
				"lamellar_harness"
			],
			[
				1,
				"footman_armor"
			],
			[
				1,
				"light_scale_armor"
			],
			[
				1,
				"leather_scale_armor"
			]
		];
		local helm = [
			[
				1,
				""
			],
			[
				5,
				"nasal_helmet_with_mail"
			],
			[
				5,
				"nasal_helmet"
			],
			[
				5,
				"mail_coif"
			],
			[
				5,
				"reinforced_mail_coif"
			],
			[
				5,
				"headscarf"
			],
			[
				5,
				"kettle_hat"
			],
			[
				5,
				"kettle_hat_with_mail"
			],
			[
				5,
				"rondel_helm"
			],
			[
				5,
				"traze_northern_mercenary_cap"
			],
			[
				5,
				"deep_sallet"
			],
			[
				5,
				"scale_helm"
			],
			[
				5,
				"flat_top_helmet"
			],
			[
				5,
				"flat_top_with_mail"
			],
			[
				5,
				"closed_flat_top_helmet"
			],
			[
				5,
				"closed_mail_coif"
			],
			[
				5,
				"bascinet_with_mail"
			],
			[
				5,
				"nordic_helmet"
			],
			[
				5,
				"nordic_helmet_with_closed_mail"
			],
			[
				5,
				"legend_enclave_vanilla_kettle_sallet_02"
			],
			[
				5,
				"legend_enclave_vanilla_kettle_sallet_03"
			],
			[
				5,
				"legend_enclave_vanilla_skullcap_01"
			],
			[
				5,
				"steppe_helmet_with_mail"
			],
			[
				5,
				"barbute_helmet"
			]
		];

		helm.push([
			5,
			"theamson_barbute_helmet"
		]);

		local outfits = [
			[
				1,
				"northern_mercenary_outfit_00"
			],
			[
				1,
				"northern_mercenary_outfit_01"
			],
			[
				1,
				"northern_mercenary_outfit_02"
			],
			[
				1,
				"traze_northern_mercenary_outfit_00"
			]
		];

		foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helm) )
		{
			this.m.Items.equip(item);
		}
	}

});

