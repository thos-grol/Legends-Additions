//Direwolf
//Attributes: Winter, Edge
//Weakness: Heart

::Const.Tactical.Actor.Direwolf <- {
	XP = 1000,
	ActionPoints = 12,
	Hitpoints = 800,
	Bravery = 10,
	Stamina = 180,
	MeleeSkill = 115,
	RangedSkill = 0,
	MeleeDefense = 50,
	RangedDefense = 50,
	Initiative = 145,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 20,
	Armor = [
		200,
		200
	]
};

this.la_direwolf <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(::Const.Tactical.Actor.Direwolf);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult *= 1.5;

		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = ::Const.DefaultMovementAPCost;
		this.m.FatigueCosts = ::Const.DefaultMovementFatigueCost;

		local scale_mult = 1.25;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_direwolf_0" + this.Math.rand(1, 3));
		body.Scale = scale_mult;

		if (this.Math.rand(0, 100) < 90) body.varySaturation(0.2);
		if (this.Math.rand(0, 100) < 90) body.varyColor(0.05, 0.05, 0.05);

		local head = this.addSprite("head");
		head.setBrush("bust_direwolf_03_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		head.Scale = scale_mult;
		local head_frenzy = this.addSprite("head_frenzy");
		head_frenzy.setBrush(this.getSprite("head").getBrush().Name + "_frenzy");
		head_frenzy.Scale = scale_mult;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_direwolf_injured");
		injury.Scale = scale_mult;
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		body_blood.Scale = scale_mult;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54 * scale_mult;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));

		////////////////////////////////////////////////////////////////////////

		this.getFlags().add("la_direwolf");
		this.getFlags().add("immunity_overwhelm");
		this.m.Skills.add(::new("scripts/skills/perks/perk_underdog"));

		this.m.Skills.add(::new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_escape_artist"));

		this.m.Skills.add(::new("scripts/skills/perks/perk_fast_adaption"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_berserk"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_crippling_strikes"));
        this.m.Skills.add(::new("scripts/skills/traits/boss_fearless_trait")); //doesn't run until 25% hp

		this.m.Skills.add(::new("scripts/skills/perks/perk_direwolf_berserk_mode"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_legend_second_wind"));
		this.m.Skills.add(::new("scripts/skills/perks/perk_class_ruin_knight"));

		//this.m.Skills.add(::new("scripts/skills/racial/werewolf_racial"));
		this.m.Skills.add(::new("scripts/skills/actives/direwolf_bite"));
		this.m.Skills.add(::new("scripts/skills/actives/direwolf_hunt_teleport"));
		this.m.Skills.add(::new("scripts/skills/actives/direwolf_indomitable"));
	}

	function create()
	{
		this.m.Type = ::Const.EntityType.Direwolf;
		this.m.BloodType = ::Const.BloodType.Red;
		this.m.XP = ::Const.Tactical.Actor.Direwolf.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-10, -25);
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
			"sounds/enemies/werewolf_hurt_01.wav",
			"sounds/enemies/werewolf_hurt_02.wav",
			"sounds/enemies/werewolf_hurt_03.wav",
			"sounds/enemies/werewolf_hurt_04.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/werewolf_death_01.wav",
			"sounds/enemies/werewolf_death_02.wav",
			"sounds/enemies/werewolf_death_03.wav",
			"sounds/enemies/werewolf_death_04.wav",
			"sounds/enemies/werewolf_death_05.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/werewolf_flee_01.wav",
			"sounds/enemies/werewolf_flee_02.wav",
			"sounds/enemies/werewolf_flee_03.wav",
			"sounds/enemies/werewolf_flee_04.wav",
			"sounds/enemies/werewolf_flee_05.wav",
			"sounds/enemies/werewolf_flee_06.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/werewolf_idle_01.wav",
			"sounds/enemies/werewolf_idle_02.wav",
			"sounds/enemies/werewolf_idle_03.wav",
			"sounds/enemies/werewolf_idle_04.wav",
			"sounds/enemies/werewolf_idle_05.wav",
			"sounds/enemies/werewolf_idle_06.wav",
			"sounds/enemies/werewolf_idle_07.wav",
			"sounds/enemies/werewolf_idle_08.wav",
			"sounds/enemies/werewolf_idle_09.wav",
			"sounds/enemies/werewolf_idle_10.wav",
			"sounds/enemies/werewolf_idle_11.wav",
			"sounds/enemies/werewolf_idle_12.wav",
			"sounds/enemies/werewolf_idle_13.wav",
			"sounds/enemies/werewolf_idle_14.wav",
			"sounds/enemies/werewolf_idle_15.wav",
			"sounds/enemies/werewolf_idle_16.wav",
			"sounds/enemies/werewolf_idle_17.wav",
			"sounds/enemies/werewolf_idle_18.wav",
			"sounds/enemies/werewolf_idle_19.wav",
			"sounds/enemies/werewolf_idle_20.wav",
			"sounds/enemies/werewolf_idle_21.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Attack] = [
			"sounds/enemies/werewolf_idle_01.wav",
			"sounds/enemies/werewolf_idle_02.wav",
			"sounds/enemies/werewolf_idle_03.wav",
			"sounds/enemies/werewolf_idle_05.wav",
			"sounds/enemies/werewolf_idle_06.wav",
			"sounds/enemies/werewolf_idle_07.wav",
			"sounds/enemies/werewolf_idle_08.wav"
		];
		this.m.Sound[::Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/werewolf_fatigue_01.wav",
			"sounds/enemies/werewolf_fatigue_02.wav",
			"sounds/enemies/werewolf_fatigue_03.wav",
			"sounds/enemies/werewolf_fatigue_04.wav",
			"sounds/enemies/werewolf_fatigue_05.wav",
			"sounds/enemies/werewolf_fatigue_06.wav",
			"sounds/enemies/werewolf_fatigue_07.wav"
		];
		this.m.SoundVolume[::Const.Sound.ActorEvent.Attack] = 0.8;
		this.m.SoundVolume[::Const.Sound.ActorEvent.Move] = 0.7;
		this.m.SoundPitch = this.Math.rand(95, 105) * 0.01;
		this.m.AIAgent = ::new("scripts/ai/tactical/agents/la_direwolf_agent");
		this.m.AIAgent.setActor(this);
	}

	function playAttackSound()
	{
		if (this.Math.rand(1, 100) <= 50)
		{
			this.playSound(::Const.Sound.ActorEvent.Attack, ::Const.Sound.Volume.Actor * this.m.SoundVolume[::Const.Sound.ActorEvent.Attack] * (this.Math.rand(75, 100) * 0.01), this.m.SoundPitch * 1.15);
		}
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled() && _skill != null && !_skill.isRanged())
		{
			this.updateAchievement("Ulfhednar", 1, 1);
		}

		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			local head_frenzy = this.getSprite("head_frenzy");
			decal = _tile.spawnDetail("bust_direwolf_01_body_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != ::Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;

				if (head_frenzy.HasBrush)
				{
					decal = _tile.spawnDetail(head_frenzy.getBrush().Name + "_dead", ::Const.Tactical.DetailFlag.Corpse, flip);
					decal.Scale = 0.95;
				}
			}
			else if (_fatalityType == ::Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead"
				];

				if (head_frenzy.HasBrush)
				{
					layers.push(head_frenzy.getBrush().Name + "_dead");
				}

				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, "bust_direwolf_head_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;

				if (head_frenzy.HasBrush)
				{
					decap[1].Scale = 0.95;
				}
			}

			if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_arrows", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == ::Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail("bust_direwolf_01_body_dead_javelin", ::Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone ::Const.Corpse;
			corpse.CorpseName = "A Direwolf";
			corpse.IsHeadAttached = _fatalityType != ::Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if (_killer == null || _killer.getFaction() == ::Const.Faction.Player || _killer.getFaction() == ::Const.Faction.PlayerAnimals)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = i )
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						if (::Const.DLC.Unhold)
						{
							local r = this.Math.rand(1, 100);
							local loot;

							if (r <= 70)
							{
								loot = ::new("scripts/items/misc/werewolf_pelt_item");
							}
							else
							{
								loot = ::new("scripts/items/misc/adrenaline_gland_item");
							}

							loot.drop(_tile);
						}
						else
						{
							local loot = ::new("scripts/items/misc/werewolf_pelt_item");
							loot.drop(_tile);
						}
					}
					else if (this.Math.rand(1, 100) <= 33)
					{
						local loot = ::new("scripts/items/supplies/strange_meat_item");
						loot.drop(_tile);
					}

					if (this.isKindOf(this, "direwolf_high") && this.Math.rand(1, 100) <= 20)
					{
						local loot = ::new("scripts/items/loot/sabertooth_item");
						loot.drop(_tile);
					}

					i = ++i;
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function drop_loot(_tile)
	{
		if (this.World.Retinue.hasFollower("follower.surgeon") && ::Math.rand(1,100) <= 33)
		{
			local tome = this.new("scripts/items/misc/anatomist/direwolf_potion_item");
			tome.drop(_tile);
		}

		// for(local i = 0; i < 3; i++ )
		// {
		// 	if (::Math.rand(1,100) <= 20 )
		// 	{
		// 		local s = this.new("scripts/items/misc/magic/soul_splinter");
		// 		s.drop(_tile);
		// 	}
		// }

	}
});



