::Const.Tactical.Actor.AlpShadow = {
	XP = 0,
	ActionPoints = 9,
	Hitpoints = 5,
	Bravery = 100,
	Stamina = 100,
	MeleeSkill = 50,
	RangedSkill = 50,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 100,
	FatigueEffectMult = 0.0,
	MoraleEffectMult = 0.0,
	FatigueRecoveryRate = 15,
	Vision = 3,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/alp_shadow", function(o) {
	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local effect = {
				Delay = 0,
				Quantity = 12,
				LifeTimeQuantity = 12,
				SpawnRate = 100,
				Brushes = [
					"bust_alp_shadow_03"
				],
				Stages = [
					{
						LifeTimeMin = 0.5,
						LifeTimeMax = 0.5,
						ColorMin = this.createColor("0000002f"),
						ColorMax = this.createColor("0000002f"),
						ScaleMin = 1.0,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(-10, -10),
						SpawnOffsetMax = this.createVec(10, 10),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.5,
						LifeTimeMax = 0.5,
						ColorMin = this.createColor("0000001f"),
						ColorMax = this.createColor("0000001f"),
						ScaleMin = 0.9,
						ScaleMax = 0.9,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("00000000"),
						ColorMax = this.createColor("00000000"),
						ScaleMin = 0.1,
						ScaleMax = 0.1,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 80,
						VelocityMax = 100,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.onInit = function()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.AlpShadow);

		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 150)
		{
			b.MeleeDefense += 5;
		}

		b.IsImmuneToBleeding = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToDisarm = true;
		b.IsIgnoringArmorOnAttack = true;
		b.IsAffectedByNight = false;
		b.IsAffectedByInjuries = false;
		b.IsMovable = false;
		b.IsRooted = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.SameMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;
		local variant = this.Math.rand(1, 3);
		local blurAlpha = 110;
		local socket = this.addSprite("socket");
		local body = this.addSprite("body");
		body.setBrush("bust_alp_shadow_0" + variant);
		body.Alpha = 0;
		body.fadeToAlpha(blurAlpha, 750);
		local head = this.addSprite("head");
		head.setBrush("bust_alp_shadow_0" + variant);
		head.Alpha = 0;
		head.fadeToAlpha(blurAlpha, 750);
		local blur_1 = this.addSprite("blur_1");
		blur_1.setBrush("bust_alp_shadow_0" + variant);
		blur_1.Alpha = 0;
		blur_1.fadeToAlpha(blurAlpha, 750);
		local blur_2 = this.addSprite("blur_2");
		blur_2.setBrush("bust_alp_shadow_0" + variant);
		blur_2.Alpha = 0;
		blur_2.fadeToAlpha(blurAlpha, 750);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(-5, -5));
		this.m.Skills.add(this.new("scripts/skills/actives/nightmare_touch_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/nightmare_touch_zoc_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
	}

	o.onRoundStart = function()
	{
		if (this.getTile().Properties.Effect == null || this.getTile().Properties.Effect.Timeout == this.Time.getRound() || this.getTile().Properties.Effect.Type != "shadows")
		{
			this.killSilently();
		}
		else
		{
			this.actor.onRoundStart();
		}
	}

});

