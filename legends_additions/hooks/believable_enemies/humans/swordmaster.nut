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

		this.m.build_num = this.Math.rand(0, 3);
		switch(this.m.build_num)
		{
			case 0: //Metzger
				this.build_metzger();
				break;
			case 1: //Blade Dancer
				this.build_bladedancer();
				break;
			case 2: //Reaper
				this.build_reaper();
				break;
			case 3: //Precise
				this.build_precise();
				break;
		}

	}

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

		//metzger free perks and actives
		local item = this.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
		if (item != null) item.addSkill(::new("scripts/skills/actives/decapitate"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_sanguinary"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bloodbath"));

		this.level_melee_skill(8, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(1, 3) );
		this.level_initiative(5, this.Math.rand(-3, 3) );
		this.level_resolve(2, this.Math.rand(-3, 3) );
		this.level_fatigue(5, this.Math.rand(-3, 3) );

		if (o.m.is_miniboss) this.add_potion("necrosavant", true);
		else if (this.Math.rand(1, 100) <= 25) this.add_potion("necrosavant", false);
	}

	o.build_bladedancer <- function() //warbrand
	{
		if (this.m.is_miniboss) this.m.Items.equip(::new("scripts/items/weapons/named/named_warbrand"));
		else this.m.Items.equip(::new("scripts/items/weapons/warbrand"));

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
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_swordmaster_blade_dancer")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_kata")); //6
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm")); //6
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_clarity")); //7

		this.level_melee_skill(8, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(1, 3) );
		this.level_initiative(7, 3 );
		this.level_fatigue(5, this.Math.rand(-3, 3) );

		if (o.m.is_miniboss) this.add_potion("direwolf", true);
		else if (this.Math.rand(1, 100) <= 25) this.add_potion("direwolf", false);
	}

	o.build_reaper <- function()
	{
		if (this.m.is_miniboss) this.m.Items.equip(::new("scripts/items/weapons/named/named_greatsword"));
		else this.m.Items.equip(::new("scripts/items/weapons/greatsword"));

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
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_swordmaster_reaper")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_en_garde")); //7

		this.m.Skills.add(::new("scripts/skills/perks/perk_fortified_mind")); //5
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_mind_over_body")); //6

		this.m.Skills.removeByID("perk.relentless");
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bloody_harvest"));

		this.level_melee_skill(8, this.Math.rand(1, 3) );
		this.level_melee_defense(10, this.Math.rand(1, 3) );
		this.level_resolve(10, 3 );
		this.level_fatigue(2, this.Math.rand(-3, 3) );

		if (o.m.is_miniboss) this.add_potion("direwolf", true);
		else if (this.Math.rand(1, 100) <= 25) this.add_potion("direwolf", false);
	}

	o.build_precise <- function()
	{
		if (this.m.is_miniboss) this.m.Items.equip(::new("scripts/items/weapons/named/named_fencing_sword"));
		else this.m.Items.equip(::new("scripts/items/weapons/fencing_sword"));

		// Base skills 6 skills
		// this.m.Skills.add(::new("scripts/skills/perks/perk_legend_alert")); //1
		// this.m.Skills.add(::new("scripts/skills/perks/perk_dodge")); //2
		// this.m.Skills.add(::new("scripts/skills/perks/perk_relentless")); //3
		// this.m.Skills.add(::new("scripts/skills/perks/perk_nimble")); //5
		// this.m.Skills.add(::new("scripts/skills/perks/perk_underdog")); //5 -> 6
		// this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_pattern_recognition")); //7

		// 5 allowed
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_fluid_weapon")); //3
		this.m.Skills.add(::new("scripts/skills/perks/perk_mastery_sword")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_swordmaster_precise")); //4
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_kata")); //6
		this.m.Skills.add(::new("scripts/skills/perks/perk_bf_fencer")); //7

		this.m.Skills.removeByID("perk.underdog");
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_clarity"));

		this.level_initiative(10, 3 );
		this.level_melee_skill(10, this.Math.rand(1, 3) );
		this.level_melee_defense(8, this.Math.rand(1, 3) );
		this.level_fatigue(2, this.Math.rand(-3, 3) );

		this.m.AIAgent = this.new("scripts/ai/tactical/agents/legend_fencer_agent");
		this.m.AIAgent.setActor(this);

		if (o.m.is_miniboss) this.add_potion("orc", true);
		else if (this.Math.rand(1, 100) <= 25) this.add_potion("orc", false);
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