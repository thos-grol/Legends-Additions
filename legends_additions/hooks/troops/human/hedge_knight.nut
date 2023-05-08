::Const.Tactical.Actor.HedgeKnight = {
	XP = 450,
	ActionPoints = 9,
	Hitpoints = 185,
	Bravery = 90,
	Stamina = 160,
	MeleeSkill = 85,
	RangedSkill = 50,
	MeleeDefense = 25,
	RangedDefense = 15,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25
};
::mods_hookExactClass("entity/tactical/humans/hedge_knight", function(o) {
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.HedgeKnight);
		b.TargetAttractionMult = 1.0;
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
		this.getSprite("socket").setBrush("bust_base_military");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_devastating_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_killing_frenzy"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_recover"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_feint"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_skill"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_specialist_shield_push"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_smashing_shields"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_back_to_basics"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
			this.m.Skills.add(this.new("scripts/skills/perks/perk_bloody_harvest"));
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
		}
	}

	o.assignRandomEquipment = function()
	{
		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Offhand))
		{
			local weapons = [
				"weapons/greatsword",
				"weapons/greataxe",
				"weapons/two_handed_hammer",
				"weapons/two_handed_flanged_mace",
				"weapons/two_handed_flail",
				"weapons/bardiche"
			];
			this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local armor = [
				[
					1,
					"coat_of_plates"
				],
				[
					1,
					"coat_of_scales"
				],
				[
					1,
					"heavy_lamellar_armor"
				]
			];
			local helmet = [
				[
					30,
					"full_helm"
				],
				[
					10,
					"closed_flat_top_with_mail"
				],
				[
					5,
					"legend_helm_breathed"
				],
				[
					5,
					"legend_helm_full"
				],
				[
					5,
					"legend_helm_bearded"
				],
				[
					5,
					"legend_helm_point"
				],
				[
					5,
					"legend_helm_snub"
				],
				[
					5,
					"legend_helm_short"
				],
				[
					5,
					"legend_helm_curved"
				],
				[
					2,
					"legend_enclave_vanilla_great_helm_01"
				],
				[
					2,
					"legend_enclave_vanilla_armet_01"
				],
				[
					2,
					"legend_enclave_vanilla_armet_02"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_01"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_02"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_03"
				],
				[
					2,
					"legend_enclave_vanilla_kettle_sallet_01"
				],
				[
					2,
					"legend_enclave_vanilla_kettle_sallet_02"
				]
			];
			local outfits = [
				[
					1,
					"brown_hedgeknight_outfit_00"
				]
			];

			foreach( item in this.Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item);
			}

			return;
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Body))
		{
			local armor = [
				[
					1,
					"coat_of_plates"
				],
				[
					1,
					"coat_of_scales"
				],
				[
					1,
					"heavy_lamellar_armor"
				],
				[
					1,
					"brown_hedgeknight_armor"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickArmor(armor));
		}

		if (this.m.Items.hasEmptySlot(this.Const.ItemSlot.Head))
		{
			local helmet = [
				[
					30,
					"full_helm"
				],
				[
					10,
					"closed_flat_top_with_mail"
				],
				[
					5,
					"legend_helm_breathed"
				],
				[
					5,
					"legend_helm_full"
				],
				[
					5,
					"legend_helm_bearded"
				],
				[
					5,
					"legend_helm_point"
				],
				[
					5,
					"legend_helm_snub"
				],
				[
					5,
					"legend_helm_short"
				],
				[
					5,
					"legend_helm_curved"
				],
				[
					2,
					"legend_enclave_vanilla_great_helm_01"
				],
				[
					2,
					"legend_enclave_vanilla_armet_01"
				],
				[
					2,
					"legend_enclave_vanilla_armet_02"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_01"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_02"
				],
				[
					2,
					"legend_enclave_vanilla_great_bascinet_03"
				],
				[
					2,
					"legend_enclave_vanilla_kettle_sallet_01"
				],
				[
					2,
					"legend_enclave_vanilla_kettle_sallet_02"
				]
			];
			this.m.Items.equip(this.Const.World.Common.pickHelmet(helmet));
		}
	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss())
		{
			return false;
		}

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_greataxe",
			"weapons/named/named_greatsword",
			"weapons/named/named_two_handed_hammer"
		];

		if (this.Const.DLC.Unhold)
		{
			weapons.extend([
				"weapons/named/named_two_handed_mace",
				"weapons/named/named_two_handed_flail"
			]);
		}

		if (this.Const.DLC.Wildmen)
		{
			weapons.extend([
				"weapons/named/named_bardiche"
			]);
		}

		this.m.Items.equip(this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		this.m.Items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"named/brown_coat_of_plates_armor"
			],
			[
				1,
				"named/golden_scale_armor"
			],
			[
				1,
				"named/green_coat_of_plates_armor"
			]
		]));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
		return true;
	}

});

