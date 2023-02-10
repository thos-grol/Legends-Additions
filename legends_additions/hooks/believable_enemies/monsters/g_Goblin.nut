::Const.Tactical.Actor.GoblinAmbusher <- {
	XP = 250,
	ActionPoints = 9,
	Hitpoints = 40,
	Bravery = 45,
	Stamina = 100,
	MeleeSkill = 55,
	RangedSkill = 65,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 120,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 15
};

::mods_hookExactClass("entity/tactical/goblin", function (o)
{

    o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.GoblinAmbusher);
		b.IsFleetfooted = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.Items.getAppearance().Body = "bust_goblin_01_body";
		this.addSprite("socket").setBrush("bust_base_goblins");
		local quiver = this.addSprite("quiver");
		quiver.Visible = false;
		local body = this.addSprite("body");
		body.setBrush("bust_goblin_01_body");
		body.varySaturation(0.1);
		body.varyColor(0.07, 0.07, 0.09);
		local injury_body = this.addSprite("injury_body");
		injury_body.Visible = false;
		injury_body.setBrush("bust_goblin_01_body_injured");
		this.addSprite("armor");
		local head = this.addSprite("head");
		head.Saturation = body.Saturation;
		head.Color = body.Color;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_goblin_01_head_injured");
		this.addSprite("helmet");
		this.addSprite("helmet_damage");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;

        //active skills
        this.m.Skills.add(::new("scripts/skills/actives/hand_to_hand"));
        this.m.Skills.add(::new("scripts/skills/actives/wake_ally_skill"));

        //traits setup
        this.m.Skills.add(::new("scripts/skills/racial/ptr_goblin_racial"));
        this.m.Skills.add(::new("scripts/skills/traits/tiny_trait"));
        this.m.Skills.add(::new("scripts/skills/effects/captain_effect"));
        this.m.Skills.add(::new("scripts/skills/special/double_grip"));
		this.m.Skills.add(::new("scripts/skills/effects/goblin_overseer_potion_effect"));


		//TODO: Goblin Perks
		//TODO: Rebalance Goblin stats/perks
		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_footwork"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_tumble"));

	}

});