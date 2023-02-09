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
	o.m.is_miniboss <- false;

	o.makeMiniboss = function()
	{
		if (!this.actor.makeMiniboss()) return false;
		this.m.is_miniboss = true;
		this.m.XP *= 1.5;

		this.getSprite("miniboss").setBrush("bust_miniboss");
		return true;
	}

	// local weapons = [
	// 	"weapons/named/named_sword",
	// 	"weapons/named/legend_named_estoc",
	// 	"weapons/named/named_sword",
	// 	"weapons/named/named_shamshir"
	// ];

	o.assignRandomEquipment = function()
	{
		this.addArmor();

		//light armor + defensive perks
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_alert")); //1
		this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless")); //3
		this.m.Skills.add(::new("scripts/skills/perks/perk_nimble")); //5
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5 -> 6
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pattern_recognition")); //7

		local weapons = [
			"weapons/noble_sword",
			"weapons/arming_sword",
			"weapons/legend_estoc",
			"weapons/shamshir"
		];

		this.m.build_num = this.Math.rand(0, 6);

		this.build_metzger();
		// switch(this.m.build_num)
		// {
		// 	case 0: //Metzger - Southern Curved Swords
		// 		break;

		// 	case 1: //perk_ptr_swordmaster_blade_dancer
		// 		break;
		// 	case 2: //perk_ptr_swordmaster_precise
		// 		break;
		// 	case 3: //perk_ptr_swordmaster_juggernaut
		// 		break;
		// 	case 4: //perk_ptr_swordmaster_reaper
		// 		break;

		// }

	}

	// "scripts/skills/perks/perk_ptr_swordmaster_blade_dancer",
	// 		"scripts/skills/perks/perk_ptr_swordmaster_precise",
	// 		"scripts/skills/perks/perk_ptr_swordmaster_versatile_swordsman",
	// 		"scripts/skills/perks/perk_ptr_swordmaster_juggernaut",
	// 		"scripts/skills/perks/perk_ptr_swordmaster_grappler",
	// 		"scripts/skills/perks/perk_ptr_swordmaster_reaper",

	o.build_metzger <- function()
	{
		if (this.m.is_miniboss) this.m.Items.equip(::new("scripts/items/weapons/named/named_shamshir"));
		else
		{
			local weapons = [
				"weapons/shamshir"
			];
			this.m.Items.equip(::new("scripts/items/" + ::MSU.Array.rand(weapons)));
		}

		// Base skills 6 skills
		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_alert")); //1
		// this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
		// this.m.Skills.add(::new("scripts/skills/perks/perk_relentless")); //3
		// this.m.Skills.add(::new("scripts/skills/perks/perk_nimble")); //5
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5 -> 6
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pattern_recognition")); //7

		// 5 allowed
		//duelist
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_swordmaster_metzger")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bloodlust")); //5
		this.m.Skills.add(::new("scripts/skills/perks/perk_duelist")); //6
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_en_garde")); //7

		this.level_melee_skill(8, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(1, 3) );
		this.level_initiative(5, this.Math.rand(-3, 3) );
		this.level_resolve(2, this.Math.rand(-3, 3) );
		this.level_fatigue(5, this.Math.rand(-3, 3) );

		if (o.m.is_miniboss || this.Math.rand(1, 100) <= 25) this.add_potion("necrosavant", false);
	}

	o.build_bladedancer <- function() //TODO
	{

	}

	o.build_reaper <- function() //TODO
	{

	}

	o.build_precise <- function() //TODO
	{

	}

	o.build_swordsman <- function() //TODO
	{

	}

	o.build_juggernaut <- function() //TODO
	{

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