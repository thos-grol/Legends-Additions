//TODO: Swordmaster builds
//level 11 - 11 perks (1 from being trained + trait), 1-3 stars
::Const.Tactical.Actor.Swordmaster <- {
	XP = 500,
	ActionPoints = 9,
	Hitpoints = 55,
	Bravery = 60,
	Stamina = 95,
	MeleeSkill = 75,
	RangedSkill = 37,
	MeleeDefense = 25,
	RangedDefense = 5,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};
::mods_hookExactClass("entity/tactical/humans/swordmaster", function(o)
{
	o.m.build_num <- 0;

	o.assignRandomEquipment = function()
	{
		this.addArmor();
		local weapons = [
			"weapons/noble_sword",
			"weapons/arming_sword",
			"weapons/legend_estoc",
			"weapons/shamshir"
		];

		this.m.build_num = this.Math.rand(0, 6);
		switch(this.m.build_num)
		{
			case 0: //Metzger - Southern Curved Swords
				local weapons = [
					"weapons/shamshir",
					"weapons/scimitar"
				];
				this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(weapons)));

				this.m.Skills.add(::new("scripts/skills/perks/perk_legend_smashing_shields")); //1
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_heft")); //2
				//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_balance")); //3
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_swordmaster_metzger")); //4
				this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_axe")); //4
				//this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2 -> 5
				//this.m.Skills.add(::new("scripts/skills/perks/perk_legend_lithe")); //6
				this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_cull")); //7
				this.level_melee_skill(7, this.Math.rand(1, 3) );
				this.level_melee_defense(7, this.Math.rand(1, 3) );
				this.level_resolve(4, this.Math.rand(1, 3) );
				this.level_health(3, this.Math.rand(1, 3) );
				break;

			case 1: //perk_ptr_swordmaster_blade_dancer
				break;
			case 2: //perk_ptr_swordmaster_precise
				break;
			case 3: //perk_ptr_swordmaster_juggernaut
				break;
			case 4: //perk_ptr_swordmaster_reaper
				break;

		}

	}

    o.onInit = function()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Swordmaster);
		b.IsSpecializedInSwords = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");

		//light armor + defensive perks
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless")); //3
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble")); //5
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5 -> 6
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pattern_recognition")); //6 -> 7






	}

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss()) return false;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		local weapons = [
			"weapons/named/named_sword",
			"weapons/named/legend_named_estoc",
			"weapons/named/named_sword",
			"weapons/named/named_shamshir"
		];

		local armor = [
			"armor/named/black_leather_armor",
			"armor/named/blue_studded_mail_armor",
			"armor/named/named_noble_mail_armor"
		];


		if (this.Math.rand(1, 100) <= 70)
		{
			this.m.Items.equip(::new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]));
		}
		else
		{
			this.m.Items.equip(::Const.World.Common.pickArmor(::Const.World.Common.convNameToList(armor)));
		}

		return true;
	}

	o.addArmor <- function()
	{
		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Body))
		{
			this.m.Items.equip(::Const.World.Common.pickArmor([
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
				]
			]));
		}

		if (this.m.Items.hasEmptySlot(::Const.ItemSlot.Head) && this.Math.rand(1, 100) <= 90)
		{
			this.m.Items.equip(::Const.World.Common.pickHelmet([
				[
					3,
					"nasal_helmet"
				],
				[
					2,
					"nasal_helmet_with_mail"
				],
				[
					2,
					"mail_coif"
				],
				[
					1,
					"feathered_hat"
				],
				[
					1,
					"headscarf"
				]
			]));
		}
	}
});