this.xxmob_fungal_a <- this.inherit("scripts/entity/tactical/actor", {
	m = {},
	function create()
	{
		this.m.Name = "Fungal Zombie";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.FlyingSkull.XP;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/zombie_hurt_01.wav",
			"sounds/enemies/zombie_hurt_02.wav",
			"sounds/enemies/zombie_hurt_03.wav",
			"sounds/enemies/zombie_hurt_04.wav",
			"sounds/enemies/zombie_hurt_05.wav",
			"sounds/enemies/zombie_hurt_06.wav",
			"sounds/enemies/zombie_hurt_07.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/zombie_death_01.wav",
			"sounds/enemies/zombie_death_02.wav",
			"sounds/enemies/zombie_death_03.wav",
			"sounds/enemies/zombie_death_04.wav",
			"sounds/enemies/zombie_death_05.wav",
			"sounds/enemies/zombie_death_06.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/zombie_idle_01.wav",
			"sounds/enemies/zombie_idle_02.wav",
			"sounds/enemies/zombie_idle_03.wav",
			"sounds/enemies/zombie_idle_04.wav",
			"sounds/enemies/zombie_idle_05.wav",
			"sounds/enemies/zombie_idle_06.wav",
			"sounds/enemies/zombie_idle_07.wav",
			"sounds/enemies/zombie_idle_08.wav",
			"sounds/enemies/zombie_idle_09.wav",
			"sounds/enemies/zombie_idle_10.wav",
			"sounds/enemies/zombie_idle_11.wav",
			"sounds/enemies/zombie_idle_12.wav",
			"sounds/enemies/zombie_idle_13.wav",
			"sounds/enemies/zombie_idle_14.wav",
			"sounds/enemies/zombie_idle_15.wav",
			"sounds/enemies/zombie_idle_16.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = this.m.Sound[this.Const.Sound.ActorEvent.Idle];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.1;
		this.m.SoundPitch = this.Math.rand(70, 120) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/xxmonster_a_agent");
		this.m.AIAgent.setActor(this);
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		if (_type == this.Const.Sound.ActorEvent.Move && this.Math.rand(1, 100) <= 50)
		{
			return;
		}

		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local effect = {
				Delay = 0,
				Quantity = 80,
				LifeTimeQuantity = 40,
				SpawnRate = 300,
				Brushes = [
					"blood_splatter_green_01",
					"blood_splatter_green_02",
					"blood_splatter_green_05",
					"blood_splatter_green_06",
					"blood_splatter_green_07",
					"blood_splatter_green_08",
					"blood_splatter_green_09"
				],
				Stages = [
					{
						LifeTimeMin = 0.2,
						LifeTimeMax = 0.6,
						ColorMin = this.createColor("ffffff00"),
						ColorMax = this.createColor("ffffff00"),
						ScaleMin = 0.8,
						ScaleMax = 1.2,
						RotationMin = 0,
						RotationMax = 300,
						VelocityMin = 100,
						VelocityMax = 300,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						SpawnOffsetMin = this.createVec(0, 0),
						SpawnOffsetMax = this.createVec(0, 0),
						ForceMin = this.createVec(0, 0),
						ForceMax = this.createVec(0, 0)
					},
					{
						LifeTimeMin = 0.2,
						LifeTimeMax = 0.4,
						ColorMin = this.createColor("ffffffff"),
						ColorMax = this.createColor("ffffffff"),
						ScaleMin = 0.5,
						ScaleMax = 1.1,
						RotationMin = 0,
						RotationMax = 300,
						VelocityMin = 100,
						VelocityMax = 300,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, -100),
						ForceMax = this.createVec(0, -100)
					},
					{
						LifeTimeMin = 0.1,
						LifeTimeMax = 0.1,
						ColorMin = this.createColor("ffffff7f"),
						ColorMax = this.createColor("ffffff7f"),
						ScaleMin = 0.3,
						ScaleMax = 1.0,
						RotationMin = 0,
						RotationMax = 0,
						VelocityMin = 200,
						VelocityMax = 300,
						DirectionMin = this.createVec(-1.0, -1.0),
						DirectionMax = this.createVec(1.0, 1.0),
						ForceMin = this.createVec(0, -100),
						ForceMax = this.createVec(0, -100)
					}
				]
			};
			this.Tactical.spawnParticleEffect(false, effect.Brushes, _tile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 40));

			local myTile = this.getTile();
			for( local i = 0; i < 6; i = ++i )
			{
				if (!myTile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = myTile.getNextTile(i);

					if (this.Math.abs(myTile.Level - nextTile.Level) <= 1 && nextTile.IsOccupiedByActor)
					{
						local target = nextTile.getEntity();

						if (!target.isAlive() || target.isDying() || this.isAlliedWith(target))
						{
						}
						else
						{
							local hitInfo = clone this.Const.Tactical.HitInfo;
							local dmg = 10;
							if (target.getHitpoints() > dmg)
							{
								hitInfo.DamageRegular = dmg;
							}
							else
							{
								hitInfo.DamageRegular = target.getHitpoints() - 1;
								target.getSkills().add(this.new("scripts/skills/effects/bleeding_effect"));
							}
							hitInfo.DamageDirect = 1;
							hitInfo.BodyPart = 0;
							hitInfo.FatalityChanceMult = 0;
							hitInfo.Injuries = this.Const.Injury.PiercingBody;
							target.onDamageReceived(this, null, hitInfo);

							dmg = this.Math.rand(10, 30);
							hitInfo.DamageRegular = 0;
							hitInfo.DamageDirect = 0;
							hitInfo.DamageArmor = dmg;
							hitInfo.BodyPart = this.Const.BodyPart.Body;
							target.onDamageReceived(this, null, hitInfo);
							hitInfo.BodyPart = this.Const.BodyPart.Head;
							target.onDamageReceived(this, null, hitInfo);
						}
					}
				}
			}

			local flip = this.Math.rand(0, 100) < 50;
			this.m.IsCorpseFlipped = flip;
			local decal;
			for( local i = 0; i != this.Const.CorpsePart.len(); i = ++i )
			{
				decal = _tile.spawnDetail(this.Const.CorpsePart[i]);
				decal.Scale = 1.15;
			}
			this.spawnTerrainDropdownEffect(_tile);
			this.spawnBloodPool(_tile, 1);
		}
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.BanditPoacher);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByInjuries = false;
		b.DamageRegularMin += 30;
		b.DamageRegularMax += 50;
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 155)
		{
			b.Hitpoints += 80;
			b.MeleeSkill += 5;
		}
		else
		{
			b.Hitpoints += 50;
			b.MeleeSkill -= 5;
		}
		b.Initiative += this.Math.rand(-55, 55);
		b.MovementAPCostAdditional += 1;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_fungal_0" + this.Math.rand(1, 2));
		body.varySaturation(0.2);
		body.varyColor(0.06, 0.06, 0.06);
		local injury = this.addSprite("injury");
		injury.setBrush("bust_alp_01_injured");
		injury.Scale = 0.8;
		injury.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 10));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		local skilla = this.new("scripts/skills/actives/ai_punch");
		skilla.m.Overlay = "active_24";
		skilla.m.SoundOnUse = [
			"sounds/enemies/zombie_bite_01.wav",
			"sounds/enemies/zombie_bite_02.wav",
			"sounds/enemies/zombie_bite_03.wav",
			"sounds/enemies/zombie_bite_04.wav"
		];
		skilla.m.SoundOnHit = [
			"sounds/enemies/skeleton_hurt_02.wav",
			"sounds/enemies/skeleton_hurt_03.wav",
			"sounds/enemies/skeleton_hurt_04.wav"
		];
		this.m.Skills.add(skilla);
	}

});

