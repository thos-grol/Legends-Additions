::Const.Tactical.Actor.Wolf <- {
	XP = 100,
	ActionPoints = 12,
	Hitpoints = 80,
	Bravery = 40,
	Stamina = 150,
	MeleeSkill = 75,
	RangedSkill = 0,
	MeleeDefense = 15,
	RangedDefense = 10,
	Initiative = 140,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	Armor = [
		0,
		0
	],
	FatigueRecoveryRate = 20
};

this.wolf <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Type = ::Const.EntityType.Wolf;
		this.m.XP = ::Const.Tactical.Actor.Wolf.XP;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.ExcludedInjuries = [
			"injury.fractured_hand",
			"injury.crushed_finger",
			"injury.fractured_elbow",
			"injury.smashed_hand",
			"injury.broken_arm",
			"injury.cut_arm_sinew",
			"injury.cut_arm",
			"injury.split_hand",
			"injury.pierced_hand",
			"injury.pierced_arm_muscles",
			"injury.burnt_hands"
		];
		this.actor.create();
		this.m.IsActingImmediately = true;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-4, -25);
		this.m.DecapitateBloodAmount = 0.5;
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/wolf_death_00.wav",
			"sounds/enemies/wolf_death_01.wav",
			"sounds/enemies/wolf_death_02.wav",
			"sounds/enemies/wolf_death_03.wav",
			"sounds/enemies/wolf_death_04.wav",
			"sounds/enemies/wolf_death_05.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/wolf_flee_00.wav",
			"sounds/enemies/wolf_flee_01.wav",
			"sounds/enemies/wolf_flee_02.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/wolf_hurt_00.wav",
			"sounds/enemies/wolf_hurt_01.wav",
			"sounds/enemies/wolf_hurt_02.wav",
			"sounds/enemies/wolf_hurt_03.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/wolf_idle_00.wav",
			"sounds/enemies/wolf_idle_01.wav",
			"sounds/enemies/wolf_idle_02.wav",
			"sounds/enemies/wolf_idle_03.wav",
			"sounds/enemies/wolf_idle_04.wav",
			"sounds/enemies/wolf_idle_06.wav",
			"sounds/enemies/wolf_idle_07.wav",
			"sounds/enemies/wolf_idle_08.wav",
			"sounds/enemies/wolf_idle_09.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = this.m.Sound[::Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[::Const.Sound.ActorEvent.Death] = 0.7;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/wardog_agent");
		this.m.AIAgent.setActor(this);
	}

	function setVariant( _v, _c, _s, _hp = 1.0 )
	{
		this.m.Items.getAppearance().Body = "bust_wolf_0" + _v;
		this.m.Items.getAppearance().Armor = "bust_wolf_02_armor_01";
		local body = this.getSprite("body");
		body.setBrush("bust_wolf_0" + _v + "_body");
		body.Color = _c;
		body.Saturation = _s;
		local head = this.getSprite("head");
		head.setBrush("bust_wolf_0" + _v + "_head");
		head.Color = _c;
		head.Saturation = _s;
		this.getSprite("armor").Visible = true;

		if (_hp != 1.0)
		{
			this.m.Hitpoints = this.getHitpointsMax() * _hp;
			this.onUpdateInjuryLayer();
		}
		else
		{
			this.setDirty(true);
		}
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Wolf);
		b.TargetAttractionMult = 0.5;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		local variant = ::Math.rand(1, 2);
		this.m.Items.getAppearance().Body = "bust_wolf_0" + variant;
		this.addSprite("socket").setBrush("bust_base_goblins");
		local body = this.addSprite("body");
		body.setBrush("bust_wolf_0" + variant + "_body");
		body.varySaturation(0.15);
		body.varyColor(0.07, 0.07, 0.07);
		local head = this.addSprite("head");
		head.setBrush("bust_wolf_0" + variant + "_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_wolf_01_injured");
		local armor = this.addSprite("armor");
		armor.setBrush("bust_wolf_02_armor_01");
		armor.Visible = false;
		this.setAlwaysApplySpriteOffset(false);
		local offset = this.createVec(0, -20);
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("armor", offset);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.58;
		this.setSpriteOffset("status_rooted", this.createVec(-6, -39));
		this.setSpriteOffset("status_stunned", this.createVec(-10, -40));
		this.setSpriteOffset("arrow", this.createVec(-10, -40));
		this.m.Skills.add(this.new("scripts/skills/actives/wolf_bite"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_lone_wolf"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fortified_mind"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_survival_instinct"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_head_hunter"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_berserk"));
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local flip = ::Math.rand(0, 100) < 50;
			local appearance = this.getItems().getAppearance();
			local decal;
			this.m.IsCorpseFlipped = flip;
			decal = _tile.spawnDetail(this.getSprite("body").getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
			decal.setBrightness(0.9);
			decal.Scale = 0.95;

			if (appearance.CorpseArmor != "")
			{
				decal = _tile.spawnDetail(appearance.CorpseArmor, ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.setBrightness(0.9);
				decal.Scale = 0.95;
			}

			if (_fatalityType != ::Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(this.getSprite("head").getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.setBrightness(0.9);
				decal.Scale = 0.95;
			}
			else if (_fatalityType == ::Const.FatalityType.Decapitated)
			{
				local layers = [
					this.getSprite("head").getBrush().Name + "_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-20, 15), 0.0, "bust_wolf_head_bloodpool");
				decap[0].setBrightness(0.9);
				decap[0].Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail(this.getSprite("body").getBrush().Name + "_dead_arrows", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail(this.getSprite("body").getBrush().Name + "_dead_javelin", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone ::Const.Corpse;
			corpse.CorpseName = this.getName();
			corpse.IsHeadAttached = _fatalityType != ::Const.FatalityType.Decapitated;
			corpse.IsResurrectable = false;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

});

