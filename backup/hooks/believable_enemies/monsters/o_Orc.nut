::Const.Tactical.Actor.OrcYoung <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 125,
	Bravery = 65,
	Stamina = 150,
	MeleeSkill = 65,
	RangedSkill = 50,
	MeleeDefense = 15,
	RangedDefense = -10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.15
};
::Const.Tactical.Actor.OrcBerserker <- {
	XP = 350,
	ActionPoints = 9,
	Hitpoints = 250,
	Bravery = 90,
	Stamina = 200,
	MeleeSkill = 80,
	RangedSkill = 30,
	MeleeDefense = 25,
	RangedDefense = -10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.2
};
::Const.Tactical.Actor.OrcWarrior <- {
	XP = 400,
	ActionPoints = 8,
	Hitpoints = 200,
	Bravery = 75,
	Stamina = 300,
	MeleeSkill = 70,
	RangedSkill = 40,
	MeleeDefense = -25,
	RangedDefense = -10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.25
};
::Const.Tactical.Actor.LegendOrcElite <- {
	XP = 800,
	ActionPoints = 8,
	Hitpoints = 300,
	Bravery = 90,
	Stamina = 400,
	MeleeSkill = 70,
	RangedSkill = 40,
	MeleeDefense = 35,
	RangedDefense = -10,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.25
};
::Const.Tactical.Actor.LegendOrcBehemoth <- {
	XP = 400,
	ActionPoints = 9,
	Hitpoints = 800,
	Bravery = 55,
	Stamina = 500,
	MeleeSkill = 70,
	RangedSkill = 40,
	MeleeDefense = 0,
	RangedDefense = -10,
	Initiative = 60,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.5
};
::Const.Tactical.Actor.OrcWarlord <- {
	XP = 600,
	ActionPoints = 8,
	Hitpoints = 300,
	Bravery = 90,
	Stamina = 450,
	MeleeSkill = 80,
	RangedSkill = 40,
	MeleeDefense = 35,
	RangedDefense = -10,
	Initiative = 125,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 25,
	DamageTotalMult = 1.35
};

::mods_hookExactClass("entity/tactical/enemies/orc_young", function (o)
{
	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcYoung);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 70)
		{
			b.IsSpecializedInThrowing = true;

			if (this.World.getTime().Days >= 150)
			{
				b.RangedSkill += 5;
			}
		}

		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_01_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_01_body");
		body.varySaturation(0.05);
		body.varyColor(0.07, 0.07, 0.07);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_01_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_01_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_01_head_injured");
		local v = -7;
		local v2 = 0;

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_01_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/actives/charge"));

		this.m.Skills.add(::new("scripts/skills/effects/orc_warrior_potion_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));
	}

});
::mods_hookExactClass("entity/tactical/enemies/orc_warrior", function (o)
{
	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcWarrior);
		this.m.BaseProperties.DamageTotalMult -= 0.1;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_03_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_03_body");
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_03_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_03_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_03_head_injured");
		local v = 1;
		local v2 = -6;

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_03_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.6;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));

		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/actives/charge"));

		this.m.Skills.add(::new("scripts/skills/effects/orc_warrior_potion_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		this.m.Skills.add(this.new("scripts/skills/effects/captain_effect"));


		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/actives/line_breaker"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
	}

});

::mods_hookExactClass("entity/tactical/enemies/orc_warlord", function (o)
{
	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcWarlord);
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_04_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_04_body");
		body.varyColor(0.1, 0.1, 0.1);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_04_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_04_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_04_head_injured");

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
		}

		local v = 8;
		local v2 = -15;

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			if (!this.hasSprite(a))
			{
				continue;
			}

			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_04_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.setSpriteOffset("arms_icon", this.createVec(-8, 0));
		this.setSpriteOffset("shield_icon", this.createVec(-5, 0));
		this.setSpriteOffset("stunned", this.createVec(0, 10));
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(0, 16));
		this.setSpriteOffset("status_stunned", this.createVec(-5, 30));
		this.setSpriteOffset("arrow", this.createVec(-5, 30));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/actives/warcry"));
		this.m.Skills.add(this.new("scripts/skills/actives/line_breaker"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));

		this.m.Skills.add(::new("scripts/skills/effects/orc_warrior_potion_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_inspiring_presence"));
	}

});

::mods_hookExactClass("entity/tactical/enemies/orc_berserker", function (o)
{
	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcBerserker);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 190)
		{
			b.MeleeSkill += 5;
			b.DamageTotalMult += 0.1;
			b.Bravery += 5;
		}

		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		b.IsSpecializedInFlails = true;
		b.IsAffectedByFreshInjuries = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_02_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_02_body");
		body.varySaturation(0.1);
		body.varyColor(0.08, 0.08, 0.08);
		local tattoo_body = this.addSprite("tattoo_body");

		if (this.Math.rand(1, 100) <= 50)
		{
			tattoo_body.setBrush("bust_orc_02_body_paint_0" + this.Math.rand(1, 3));
		}

		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_02_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_02_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local tattoo_head = this.addSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 50)
		{
			tattoo_head.setBrush("bust_orc_02_head_paint_0" + this.Math.rand(1, 3));
		}

		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_02_head_injured");

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
		}

		local v = 3;
		local v2 = -5;

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			if (!this.hasSprite(a))
			{
				continue;
			}

			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_rage = this.addSprite("body_rage");
		body_rage.Visible = false;
		body_rage.Alpha = 220;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.6;
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand_orc"));
		this.m.Skills.add(this.new("scripts/skills/actives/charge"));
		this.m.Skills.add(this.new("scripts/skills/effects/berserker_rage_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_flow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		
		this.m.Skills.add(::new("scripts/skills/effects/orc_warrior_potion_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_colossus"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
	}

});

::mods_hookExactClass("entity/tactical/enemies/legend_orc_behemoth", function (o)
{
	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.LegendOrcBehemoth);
		this.m.BaseProperties.DamageTotalMult -= 0.1;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints * 2;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "legend_orc_behemoth_body_01";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("legend_orc_behemoth_body_01");
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("legend_orc_behemoth_body_01_bloodied");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("legend_orc_behemoth_head_01");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("legend_orc_behemoth_head_01_bloodied");

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
		}

		local v = 15;
		local v2 = -5;

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			if (!this.hasSprite(a))
			{
				continue;
			}

			this.setSpriteOffset(a, this.createVec(v2, v));
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_03_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.8;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));
		this.m.Skills.add(this.new("scripts/skills/actives/line_breaker"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_assured_conquest"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_taste_the_pain"));

		this.m.Skills.add(::new("scripts/skills/effects/orc_warrior_potion_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
	}
});

::mods_hookExactClass("entity/tactical/enemies/legend_orc_elite", function (o)
{
	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.OrcWarrior);

		this.m.BaseProperties.DamageTotalMult -= 0.1;
		b.IsSpecializedInAxes = true;
		b.IsSpecializedInCleavers = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints * 2;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_orc_03_body";
		this.addSprite("socket").setBrush("bust_base_orcs");
		local body = this.addSprite("body");
		body.setBrush("bust_orc_03_body");
		body.varyColor(0.09, 0.09, 0.09);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_orc_03_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.setBrush("bust_orc_03_head_0" + this.Math.rand(1, 3));
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_orc_03_head_injured");

		foreach( a in this.Const.CharacterSprites.Helmets )
		{
			this.addSprite(a);
		}

		local body_blood = this.addSprite("body_blood");
		body_blood.setBrush("bust_orc_03_body_bloodied");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.6;
		this.setSpriteOffset("status_rooted", this.createVec(0, 5));
		this.m.Skills.add(this.new("scripts/skills/special/double_grip"));
		this.m.Skills.add(this.new("scripts/skills/actives/hand_to_hand"));
		this.m.Skills.add(this.new("scripts/skills/actives/line_breaker"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battering_ram"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_bash"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_perfect_focus"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));

		this.m.Skills.add(::new("scripts/skills/effects/orc_warrior_potion_effect"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_full_force"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_second_wind"));
		
	}
});