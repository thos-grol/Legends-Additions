//Bandit Leader
//Lvl 11 Player character template with stars
//10 perks
::Const.Tactical.Actor.BanditLeader <- {
	XP = 375,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 60,
	Stamina = 96,
	MeleeSkill = 65,
	RangedSkill = 40,
	MeleeDefense = 10,
	RangedDefense = 10,
	Initiative = 105,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/enemies/bandit_leader", function(o)
{
	//TODO: Bandit Leader builds
	o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.BanditLeader);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_bandits");
		local dirt = this.getSprite("dirt");
		dirt.Visible = true;
		dirt.Alpha = this.Math.rand(150, 255);
		this.setArmorSaturation(0.85);
		this.getSprite("shield_icon").setBrightness(0.85);

		//Bandit Leader Free Traits
		this.m.Skills.add(::new("scripts/skills/actives/rally_the_troops"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_captain"));

		//Commander Variant
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_shields_up"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_rally_the_troops"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_hold_the_line"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_push_forward"));

		//Free Tribal Perk
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bully"));

		// local roll = this.Math.rand(1.0, 100.0);
		// if (roll <= 15.0)
		// {
		// 	if (roll <= 3.0) this.add_potion("ghoul", true);
		// 	else if (roll <= 6.0) this.add_potion("ghoul", false);
		// 	else if (roll <= 9.0) this.add_potion("orc", true);
		// 	else if (roll <= 12.0) this.add_potion("orc", false);
		// 	else this.add_potion("unhold", true);
		// }

		//Defensive Perks
		this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel"));

		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_assured_conquest"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_the_rush_of_battle"));

		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_hold_the_line"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_push_forward"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_primal_fear"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_exude_confidence"));
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_vengeful_spite"));

		// if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		// {
		// 	this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		// 	this.m.Skills.add(::new("scripts/skills/perks/perk_legend_clarity"));

		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.Protect) != null)
		{
			agent.removeBehavior(::Const.AI.Behavior.ID.Protect);
			agent.finalizeBehaviors();
		}
	}

	o.assignRandomEquipment = function()
	{
		this.addArmor();

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Mainhand) == null)
		{
			local weapons = [
				"weapons/noble_sword",
				"weapons/fighting_axe",
				"weapons/warhammer",
				"weapons/legend_glaive",
				"weapons/fighting_spear",
				"weapons/winged_mace",
				"weapons/arming_sword",
				"weapons/military_cleaver"
			];

			if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Offhand) == null)
			{
				weapons.extend([
					"weapons/greatsword",
					"weapons/greataxe",
					"weapons/legend_swordstaff",
					"weapons/legend_longsword",
					"weapons/warbrand",
					"weapons/legend_estoc"
				]);
			}

			this.m.Items.equip(::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Offhand) == null)
		{
			local shields = [
				"shields/wooden_shield",
				"shields/heater_shield",
				"shields/kite_shield"
			];
			this.m.Items.equip(::new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (this.Math.rand(1, 100) <= 35)
		{
			local weapons = [
				"weapons/throwing_axe",
				"weapons/javelin"
			];
			this.m.Items.addToBag(::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}



		local weapon = this.getMainhandItem();
		local off = this.getOffhandItem();
		if (weapon == null && off != null)
		{
			this.m.Items.unequip(off);
			this.m.Items.equip(::new("scripts/items/weapons/legend_glaive"));
		}

		this.m.Skills.update();

		// if (weapon != null)
		// {
		// 	if (weapon.isItemType(::Const.Items.ItemType.TwoHanded))
		// 	{
		// 		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		// 		{
		// 			this.m.Skills.addPerkTree(::Const.Perks.TwoHandedTree);
		// 		}

		// 		this.m.Skills.add(::new("scripts/skills/perks/perk_reach_advantage"));
		// 	}
		// 	else
		// 	{
		// 		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == ::Const.Difficulty.Legendary)
		// 		{
		// 			this.m.Skills.addPerkTree(::Const.Perks.OneHandedTree);
		// 			this.m.Skills.add(::new("scripts/skills/perks/perk_double_strike"));
		// 			this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pattern_recognition"));
		// 		}
		// 		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist"));
		// 	}
		// }

		// this.m.Skills.addTreeOfEquippedWeapon();
	}

	o.makeMiniboss = function()
	{
		this.m.XP *= 1.5;
		// this.m.BaseProperties.Hitpoints += 5
		// this.m.BaseProperties.Bravery += 13
		// this.m.BaseProperties.Stamina += 4
		// this.m.BaseProperties.Initiative += 5
		// this.m.BaseProperties.MeleeSkill += 2

		this.m.IsMiniboss = true;
		this.m.IsGeneratingKillName = false;
		this.getSprite("miniboss").setBrush("bust_miniboss");

		//remove perks and rolls and start again
		this.m.Skills.removeByType(::Const.SkillType.Perk);

		//TODO: o.makeMiniboss logic - get build number and replace items with named items

		local shields = clone ::Const.Items.NamedShields;
		shields.extend([
			"shields/named/named_bandit_kite_shield",
			"shields/named/named_bandit_heater_shield"
		]);
		local r = this.Math.rand(1, 3);

		if (r == 2)
		{
			this.m.Items.equip(::new("scripts/items/" + shields[this.Math.rand(0, shields.len() - 1)]));
		}

		if (r == 1)
		{
			local namedWeaponArray = clone ::Const.Items.NamedMeleeWeapons;
			::MSU.Array.remove(namedWeaponArray, "weapons/named/named_dagger");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_parrying_dagger");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_shovel");
			::MSU.Array.remove(namedWeaponArray, "weapons/named/legend_named_sickle");
			this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(namedWeaponArray)));
		}
		else if (r == 2)
		{
			local named = ::Const.Items.NamedArmors;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickArmor(weightName));
		}
		else if (r == 3)
		{
			local named = ::Const.Items.NamedHelmets;
			local weightName = ::Const.World.Common.convNameToList(named);
			this.m.Items.equip(::Const.World.Common.pickHelmet(weightName));
		}

		return true;
	}

	o.addArmor <- function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body) && this.m.Items.hasEmptySlot(::Const.ItemSlot.Head))
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
					"footman_armor"
				],
				[
					1,
					"brown_hedgeknight_armor"
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
					"reinforced_mail_hauberk"
				],
				[
					1,
					"leather_scale_armor"
				],
				[
					1,
					"light_scale_armor"
				]
			];
			local helmet = [
				[
					1,
					"closed_mail_coif"
				],
				[
					1,
					"padded_kettle_hat"
				],
				[
					1,
					"kettle_hat_with_closed_mail"
				],
				[
					1,
					"kettle_hat_with_mail"
				],
				[
					1,
					"padded_flat_top_helmet"
				],
				[
					1,
					"nasal_helmet_with_mail"
				],
				[
					1,
					"flat_top_with_mail"
				],
				[
					1,
					"padded_nasal_helmet"
				],
				[
					1,
					"bascinet_with_mail"
				]
			];
			local outfits = [
				[
					1,
					"red_bandit_leader_outfit_00"
				]
			];

			foreach( item in ::Const.World.Common.pickOutfit(outfits, armor, helmet) )
			{
				this.m.Items.equip(item);
			}

			return;
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Body) == null)
		{
			local armor = [
				[
					1,
					"reinforced_mail_hauberk"
				],
				[
					1,
					"worn_mail_shirt"
				],
				[
					1,
					"patched_mail_shirt"
				]
			];

			if (::Const.DLC.Unhold)
			{
				armor.extend([
					[
						1,
						"footman_armor"
					],
					[
						1,
						"leather_scale_armor"
					],
					[
						1,
						"light_scale_armor"
					],
					[
						1,
						"red_bandit_leader_armor"
					]
				]);
			}

			this.m.Items.equip(::Const.World.Common.pickArmor(armor));
		}

		if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Head) == null)
		{
			local item = ::Const.World.Common.pickHelmet([
				[
					1,
					"closed_mail_coif"
				],
				[
					1,
					"padded_kettle_hat"
				],
				[
					1,
					"kettle_hat_with_closed_mail"
				],
				[
					1,
					"kettle_hat_with_mail"
				],
				[
					1,
					"padded_flat_top_helmet"
				],
				[
					1,
					"nasal_helmet_with_mail"
				],
				[
					1,
					"flat_top_with_mail"
				],
				[
					1,
					"padded_nasal_helmet"
				],
				[
					1,
					"bascinet_with_mail"
				],
				[
					1,
					"red_bandit_leader_helmet"
				]
			]);

			if (item != null)
			{
				this.m.Items.equip(item);
			}
		}
	}
});
