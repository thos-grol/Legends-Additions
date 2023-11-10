this.xxmob_fungal_b <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		BackupFaction = 0,
		IsSpawningOnTile = false
	},
	function create()
	{
		this.m.Name = "Fungal Giant";
		this.m.Type = this.Const.EntityType.SkeletonBoss;
		this.m.BloodType = this.Const.BloodType.Dark;
		this.m.MoraleState = this.Const.MoraleState.Ignore;
		this.m.XP = this.Const.Tactical.Actor.Unhold.XP;
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
		this.getFlags().add("fungal");
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
		this.m.BackupFaction = this.getFaction();
		if (_tile != null)
		{
			local effect = {
				Delay = 0,
				Quantity = 80,
				LifeTimeQuantity = 40,
				SpawnRate = 200,
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
						ScaleMin = 1.3,
						ScaleMax = 1.5,
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
						ScaleMin = 1.3,
						ScaleMax = 1.5,
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
						ScaleMin = 1.3,
						ScaleMax = 1.5,
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

			local freeTiles = [];
			for( local i = 0; i < 6; i = ++i )
			{
				if (!_tile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = _tile.getNextTile(i);

					if (nextTile.Level > _tile.Level + 1)
					{
					}
					else if (nextTile.IsEmpty)
					{
						freeTiles.push(nextTile);
					}
				}
			}
			if (freeTiles.len() != 0)
			{
				local spawnmax = 2;
				local n = 2;
				n = --n;
				while (n >= 0 && freeTiles.len() >= 1 && spawnmax > 0)
				{
					spawnmax = spawnmax - 1;
					local r = this.Math.rand(0, freeTiles.len() - 1);
					local tile = freeTiles[r];
					freeTiles.remove(r);
					local rock = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/xxmob_fungal_a", tile.Coords.X, tile.Coords.Y);
					rock.setFaction(this.getFaction());
					if (tile.IsVisibleForPlayer)
					{
						for( local i = 0; i < this.Const.Tactical.SandGolemParticles.len(); i = ++i )
						{
							this.Tactical.spawnParticleEffect(false, this.Const.Tactical.SandGolemParticles[i].Brushes, tile, this.Const.Tactical.SandGolemParticles[i].Delay, this.Const.Tactical.SandGolemParticles[i].Quantity, this.Const.Tactical.SandGolemParticles[i].LifeTimeQuantity, this.Const.Tactical.SandGolemParticles[i].SpawnRate, this.Const.Tactical.SandGolemParticles[i].Stages);
						}
					}
				}
				if (n > 0)
				{
					this.m.IsSpawningOnTile = true;
				}
			}
			else
			{
				this.m.IsSpawningOnTile = true;
			}
		}
		else
		{
			this.m.IsSpawningOnTile = true;
		}
		if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
		{
			local loot;
			if (this.Math.rand(1, 100) <= 30)
			{
				loot = this.new("scripts/items/loot/soul_splinter_item");
				loot.drop(_tile);
			}
			if (this.Math.rand(1, 100) <= 5)
			{
				loot = this.new("scripts/items/loot/ancient_gold_coins_item");
				loot.drop(_tile);
			}
		}
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onAfterDeath( _tile )
	{
		if (!this.m.IsSpawningOnTile)
		{
			return;
		}
		local rock = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/xxmob_fungal_a", _tile.Coords.X, _tile.Coords.Y);
		rock.setFaction(this.m.BackupFaction);
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
		b.DamageRegularMax += 70;
		if (!this.Tactical.State.isScenarioMode() && this.World.getTime().Days >= 155)
		{
			b.DamageTotalMult += 0.2;
			b.Hitpoints += 350;
			b.MeleeSkill += 20;
		}
		else
		{
			b.Hitpoints += 250;
			b.MeleeSkill += 10;
		}
		b.Vision += 2;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_fungal_03");
		body.varySaturation(0.2);
		body.varyColor(0.06, 0.06, 0.06);
		local injury = this.addSprite("injury");
		injury.setBrush("bust_alp_01_injured");
		injury.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.55;
		this.setSpriteOffset("status_rooted", this.createVec(0, 10));

		local wtt = this.new("scripts/items/weapons/named/xx_mob_fakeweapon15");
		wtt.m.RangeMin = 1;
		wtt.m.RangeMax = 3;
		wtt.m.RangeIdeal = 3;
		this.m.Items.equip(wtt);

		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		local skilla = this.new("scripts/skills/actives/ai_meleeshoot");
		skilla.m.MaxRange = 3;
		skilla.m.IsIgnoredAsAOO = false;
		this.m.Skills.add(skilla);
	}

});

