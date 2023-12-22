::Const.Tactical.Actor.Spider <- {
	XP = 200,
	ActionPoints = 11,
	Hitpoints = 60,
	Bravery = 45,
	Stamina = 130,
	MeleeSkill = 65,
	RangedSkill = 0,
	MeleeDefense = 10,
	RangedDefense = 20,
	Initiative = 150,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		20,
		20
	]
};

this.spider <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		Size = 1.0,
		DistortTargetA = null,
		DistortTargetPrevA = this.createVec(0, 0),
		DistortTargetB = null,
		DistortTargetPrevB = this.createVec(0, 0),
		DistortTargetC = null,
		DistortTargetPrevC = this.createVec(0, 0),
		DistortAnimationStartTimeA = 0,
		IsFlipping = false,
		Variant = "Normal"
	},
	function create()
	{
		this.m.Type = ::Const.EntityType.Spider;
		this.m.BloodType = ::Const.BloodType.Green;
		this.m.MoraleState = ::Const.MoraleState.Ignore;
		this.m.XP = ::Const.Tactical.Actor.Spider.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(20, -15);
		this.m.DecapitateBloodAmount = 1.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
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
		this.m.Sound[::Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/dlc2/giant_spider_hurt_01.wav",
			"sounds/enemies/dlc2/giant_spider_hurt_02.wav",
			"sounds/enemies/dlc2/giant_spider_hurt_03.wav",
			"sounds/enemies/dlc2/giant_spider_hurt_04.wav",
			"sounds/enemies/dlc2/giant_spider_hurt_05.wav",
			"sounds/enemies/dlc2/giant_spider_hurt_06.wav",
			"sounds/enemies/dlc2/giant_spider_hurt_07.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/dlc2/giant_spider_death_01.wav",
			"sounds/enemies/dlc2/giant_spider_death_02.wav",
			"sounds/enemies/dlc2/giant_spider_death_03.wav",
			"sounds/enemies/dlc2/giant_spider_death_04.wav",
			"sounds/enemies/dlc2/giant_spider_death_05.wav",
			"sounds/enemies/dlc2/giant_spider_death_06.wav",
			"sounds/enemies/dlc2/giant_spider_death_07.wav",
			"sounds/enemies/dlc2/giant_spider_death_08.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/dlc2/giant_spider_flee_01.wav",
			"sounds/enemies/dlc2/giant_spider_flee_02.wav",
			"sounds/enemies/dlc2/giant_spider_flee_03.wav",
			"sounds/enemies/dlc2/giant_spider_flee_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/dlc2/giant_spider_idle_01.wav",
			"sounds/enemies/dlc2/giant_spider_idle_02.wav",
			"sounds/enemies/dlc2/giant_spider_idle_03.wav",
			"sounds/enemies/dlc2/giant_spider_idle_04.wav",
			"sounds/enemies/dlc2/giant_spider_idle_05.wav",
			"sounds/enemies/dlc2/giant_spider_idle_06.wav",
			"sounds/enemies/dlc2/giant_spider_idle_07.wav",
			"sounds/enemies/dlc2/giant_spider_idle_08.wav",
			"sounds/enemies/dlc2/giant_spider_idle_09.wav",
			"sounds/enemies/dlc2/giant_spider_idle_10.wav",
			"sounds/enemies/dlc2/giant_spider_idle_11.wav",
			"sounds/enemies/dlc2/giant_spider_idle_12.wav",
			"sounds/enemies/dlc2/giant_spider_idle_13.wav",
			"sounds/enemies/dlc2/giant_spider_idle_14.wav",
			"sounds/enemies/dlc2/giant_spider_idle_15.wav",
			"sounds/enemies/dlc2/giant_spider_idle_16.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = this.m.Sound[::Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[::Const.Sound.ActorEvent.Move] = 0.7;
		this.m.SoundVolume[::Const.Sound.ActorEvent.Idle] = 2.0;
		this.m.SoundPitch = ::Math.rand(95, 105) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/spider_agent");
		this.m.AIAgent.setActor(this);

		//Roll Variant
		local roll = ::Math.rand(1, 100);
		if (roll < 20) this.m.Variant = "Huge";
		else if (roll < 40) this.m.Variant = "Stalker";
		else this.m.Variant = "Normal";
	}

	function onInit()
	{
		this.actor.onInit();
		this.setRenderCallbackEnabled(true);

		this.addSprite("socket").setBrush("bust_base_beasts");
		local legs_back = this.addSprite("legs_back");
		legs_back.setBrush("bust_spider_legs_back");
		local body = this.addSprite("body");
		body.setBrush("bust_spider_body_0" + ::Math.rand(1, 4));
		if (::Math.rand(0, 100) < 90) body.varySaturation(0.3);
		if (::Math.rand(0, 100) < 90) body.varyColor(0.1, 0.1, 0.1);
		if (::Math.rand(0, 100) < 90) body.varyBrightness(0.1);
		local legs_front = this.addSprite("legs_front");
		legs_front.setBrush("bust_spider_legs_front");
		legs_front.Color = body.Color;
		legs_front.Saturation = body.Saturation;
		legs_back.Color = body.Color;
		legs_back.Saturation = body.Saturation;
		local head = this.addSprite("head");
		head.setBrush("bust_spider_head_01");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_spider_01_injured");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.65;
		this.setSpriteOffset("status_rooted", this.createVec(7, 10));
		this.setSpriteOffset("status_stunned", this.createVec(0, -20));
		this.setSpriteOffset("arrow", this.createVec(0, -20));

		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Spider);
		b.IsAffectedByNight = false;
		b.IsImmuneToPoison = true;
		b.IsImmuneToDisarm = true;
		b.IsAffectedByLosingHitpoints = false;
		b.DamageDirectAdd += 0.1;
		b.MeleeDefense += 5;
		b.RangedDefense += 5;

		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));

		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_survival_instinct"));

		this.m.Skills.add(this.new("scripts/skills/actives/spider_bite_skill"));

		switch(this.m.Variant)
		{
			case "Huge":
				this.m.Name = "Armor";
				this.setSize(::Math.rand(100, 110) * 0.01);
				b.DamageDirectAdd += 0.5;
				this.m.Skills.add(this.new("scripts/skills/actives/web_skill"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_battle_forged"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
				b.Initiative -= 50;
				b.Armor = [
					500,
					500
				]
				this.m.XP *= 2;
				break;

			case "Stalker":
				this.m.Name = "Stalker";
				this.setSize(::Math.rand(70, 90) * 0.01);
				this.m.Skills.add(this.new("scripts/skills/racial/spider_racial"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_blend_in"));
				break;

			case "Normal":
				this.m.Name = "Webknecht";
				this.setSize(::Math.rand(70, 90) * 0.01);
				this.m.Skills.add(this.new("scripts/skills/racial/spider_racial"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				break;
			case "Baby":
				this.m.XP /= 2;
				b.Hitpoints -= 20;
				b.DamageDirectAdd -= 0.5;
				b.Initiative += 20;
				this.m.Name = "Baby";
				this.setSize(::Math.rand(55, 65) * 0.01);
				this.m.Skills.add(this.new("scripts/skills/racial/spider_racial"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_dodge"));
				this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
				break;
		}
		
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;
		this.m.MaxTraversibleLevels = 3;

		
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == ::Const.Sound.ActorEvent.Move && ::Math.rand(1, 100) <= 33) return;
		this.actor.playSound(_type, _volume, _pitch);
	}

	function onRender()
	{
		this.actor.onRender();

		if (this.m.DistortTargetA == null)
		{
			this.m.DistortTargetA = this.m.IsFlipping ? this.createVec(0, 1.0 * this.m.Size) : this.createVec(0, -1.0 * this.m.Size);
			this.m.DistortTargetB = !this.m.IsFlipping ? this.createVec(-0.5 * this.m.Size, 0) : this.createVec(0.5 * this.m.Size, 0);
			this.m.DistortTargetC = !this.m.IsFlipping ? this.createVec(0.5 * this.m.Size, 0) : this.createVec(-0.5 * this.m.Size, 0);
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF() - ::Math.rand(10, 100) * 0.01;
		}

		this.moveSpriteOffset("legs_back", this.m.DistortTargetPrevB, this.m.DistortTargetB, 1.0, this.m.DistortAnimationStartTimeA);
		this.moveSpriteOffset("legs_front", this.m.DistortTargetPrevC, this.m.DistortTargetC, 1.0, this.m.DistortAnimationStartTimeA);
		this.moveSpriteOffset("body", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA);
		this.moveSpriteOffset("injury", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA);

		if (this.moveSpriteOffset("head", this.m.DistortTargetPrevA, this.m.DistortTargetA, 1.0, this.m.DistortAnimationStartTimeA))
		{
			this.m.DistortAnimationStartTimeA = this.Time.getVirtualTimeF();
			this.m.DistortTargetPrevA = this.m.DistortTargetA;
			this.m.DistortTargetA = this.m.IsFlipping ? this.createVec(0, 1.0 * this.m.Size) : this.createVec(0, -1.0 * this.m.Size);
			this.m.DistortTargetPrevB = this.m.DistortTargetB;
			this.m.DistortTargetB = !this.m.IsFlipping ? this.createVec(-0.5 * this.m.Size, 0) : this.createVec(0.5 * this.m.Size, 0);
			this.m.DistortTargetPrevC = this.m.DistortTargetC;
			this.m.DistortTargetC = !this.m.IsFlipping ? this.createVec(0.5 * this.m.Size, 0) : this.createVec(-0.5 * this.m.Size, 0);
			this.m.IsFlipping = !this.m.IsFlipping;
		}
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local flip = ::Math.rand(0, 100) < 50;
			local decal;
			local body_decal;
			local head_decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			decal = _tile.spawnDetail("bust_spider_body_01_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.9 * this.m.Size;
			body_decal = decal;

			if (_fatalityType != ::Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail("bust_spider_head_01_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.9 * this.m.Size;
				head_decal = decal;

				if (_fatalityType == ::Const.FatalityType.None)
				{
					local corpse_data = {
						Body = body_decal,
						Head = head_decal,
						Start = this.Time.getRealTimeF(),
						Vector = this.createVec(0.0, -1.0),
						Iterations = 0,
						function onCorpseEffect( _data )
						{
							if (this.Time.getRealTimeF() - _data.Start > 0.2)
							{
								if (++_data.Iterations > 5)
								{
									return;
								}

								_data.Vector = this.createVec(::Math.rand(-100, 100) * 0.01, ::Math.rand(-100, 100) * 0.01);
								_data.Start = this.Time.getRealTimeF();
							}

							local f = (this.Time.getRealTimeF() - _data.Start) / 0.2;
							_data.Body.setOffset(this.createVec(0.0 + 0.5 * _data.Vector.X * f, 30.0 + 1.0 * _data.Vector.Y * f));
							_data.Head.setOffset(this.createVec(0.0 + 0.5 * _data.Vector.X * f, 30.0 + 1.0 * _data.Vector.Y * f));
							this.Time.scheduleEvent(this.TimeUnit.Real, 10, _data.onCorpseEffect, _data);
						}

					};
					this.Time.scheduleEvent(this.TimeUnit.Real, 10, corpse_data.onCorpseEffect, corpse_data);
				}
			}
			else if (_fatalityType == ::Const.FatalityType.Decapitated)
			{
				local layers = [
					"bust_spider_head_01_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(-50, -10), 0.0, "bust_spider_head_01_dead_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.9 * this.m.Size;
			}

			if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_spider_body_01_dead_arrows", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9 * this.m.Size;
			}

			if (_fatalityType == ::Const.FatalityType.Disemboweled)
			{
				decal = _tile.spawnDetail("bust_spider_gut", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9 * this.m.Size;
			}
			else if (_fatalityType == ::Const.FatalityType.Smashed)
			{
				decal = _tile.spawnDetail("bust_spider_skull", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.9 * this.m.Size;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone ::Const.Corpse;
			corpse.CorpseName = "A Webknecht";
			corpse.IsHeadAttached = _fatalityType != ::Const.FatalityType.Decapitated;
			corpse.IsConsumable = false;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if ((_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals) && this.m.Size > 0.75 && ::Math.rand(1, 100) <= 60)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && ::Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = ++i )
				{
					local r = ::Math.rand(1, 100);
					local loot;

					if (r <= 60)
					{
						loot = ::new("scripts/items/misc/spider_silk_item");
						loot.drop(_tile);
					}
					
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	

	function setSize( _s )
	{
		this.m.Size = _s;
		this.m.DecapitateBloodAmount = _s * 0.75;
		this.getSprite("body").Scale = _s;
		this.getSprite("head").Scale = _s;
		this.getSprite("injury").Scale = _s;
		this.getSprite("status_rooted").Scale = _s * 0.65;
		this.getSprite("status_rooted_back").Scale = _s * 0.65;
		this.getSprite("legs_back").Scale = _s;
		this.getSprite("legs_front").Scale = _s;
		local offset = this.createVec(0, -10.0 * (1.0 - _s));
		this.setSpriteOffset("body", offset);
		this.setSpriteOffset("head", offset);
		this.setSpriteOffset("injury", offset);
		this.setSpriteOffset("status_rooted", this.createVec(7, 10 - 10.0 * (1.0 - _s)));
		this.setSpriteOffset("status_rooted_back", this.createVec(7, 10 - 10.0 * (1.0 - _s)));
		this.setSpriteOffset("legs_back", offset);
		this.setSpriteOffset("legs_front", offset);
	}

});

