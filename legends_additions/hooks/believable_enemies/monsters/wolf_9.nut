//FEATURE_2: Make monsters match potions a bit/rebalance monster stats
::Const.Tactical.Actor.Direwolf <- {
	XP = 200,
	ActionPoints = 12,
	Hitpoints = 130,
	Bravery = 60,
	Stamina = 120,
	MeleeSkill = 60,
	RangedSkill = 0,
	MeleeDefense = 20,
	RangedDefense = 20,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 15,
	Armor = [
		30,
		30
	]
};

::mods_hookExactClass("entity/tactical/enemies/direwolf", function (o)
{
    o.onInit = function()
    {
        this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Direwolf);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_direwolf_0" + this.Math.rand(1, 3));

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.05, 0.05, 0.05);
		}

		local head = this.addSprite("head");
		head.setBrush("bust_direwolf_0" + this.Math.rand(1, 3) + "_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local head_frenzy = this.addSprite("head_frenzy");
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_direwolf_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));

		this.m.Skills.add(::new("scripts/skills/actives/werewolf_bite"));

		//potion perks
		this.getFlags().add("werewolf");
		this.m.Skills.add(::new("scripts/skills/effects/direwolf_potion_effect"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_survival_instinct"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_menacing"));

        this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_relentless"));

        this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_bear_down"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_onslaught"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_unstoppable"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_vengeful_spite"));
    }
});