::Const.Tactical.Actor.SandGolem = {
	XP = 150,
	ActionPoints = 8,
	Hitpoints = 110,
	Bravery = 999,
	Stamina = 400,
	MeleeSkill = 65,
	RangedSkill = 60,
	MeleeDefense = -5,
	RangedDefense = -5,
	Initiative = 60,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		110,
		110
	]
};
::mods_hookExactClass("entity/tactical/enemies/sand_golem", function(o) {
	o.getIdealRange = function()
	{
		if (this.m.Size == 1)
		{
			return 1;
		}
		else
		{
			return 5;
		}
	}

	o.onDamageReceived = function( _attacker, _skill, _hitInfo )
	{
		_hitInfo.BodyPart = this.Const.BodyPart.Body;
		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("StoneMason", 1, 1);
		}

		this.m.BackupFaction = this.getFaction();
		this.m.BackupWorldParty = this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull() ? this.m.WorldTroop.Party : null;

		if (_tile != null && this.getSize() > 1)
		{
			local freeTiles = [];

			for( local i = 0; i < 6; i = i )
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

				i = ++i;
			}

			if (freeTiles.len() != 0)
			{
				local n = 2;

				while (n != 0 && freeTiles.len() >= 1)
				{
					local r = this.Math.rand(0, freeTiles.len() - 1);
					local tile = freeTiles[r];
					freeTiles.remove(r);
					local rock = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/sand_golem", tile.Coords.X, tile.Coords.Y);
					rock.setFaction(this.getFaction());
					n = n - 1;

					if (this.getWorldTroop() != null && ("Party" in this.getWorldTroop()) && this.getWorldTroop().Party != null && !this.m.WorldTroop.Party.isNull())
					{
						local e;

						if (this.getSize() == 3)
						{
							e = this.Const.World.Common.addTroop(this.getWorldTroop().Party.get(), {
								Type = this.Const.World.Spawn.Troops.SandGolemMEDIUM
							}, false);
						}
						else
						{
							e = this.Const.World.Common.addTroop(this.getWorldTroop().Party.get(), {
								Type = this.Const.World.Spawn.Troops.SandGolem
							}, false);
						}

						rock.setWorldTroop(e);
					}

					rock.getSprite("body").Color = this.getSprite("body").Color;
					rock.getSprite("body").Saturation = this.getSprite("body").Saturation;

					if (tile.IsVisibleForPlayer)
					{
						for( local i = 0; i < this.Const.Tactical.SandGolemParticles.len(); i = i )
						{
							this.Tactical.spawnParticleEffect(false, this.Const.Tactical.SandGolemParticles[i].Brushes, tile, this.Const.Tactical.SandGolemParticles[i].Delay, this.Const.Tactical.SandGolemParticles[i].Quantity, this.Const.Tactical.SandGolemParticles[i].LifeTimeQuantity, this.Const.Tactical.SandGolemParticles[i].SpawnRate, this.Const.Tactical.SandGolemParticles[i].Stages);
							i = ++i;
						}
					}

					if (this.getSize() == 3)
					{
						rock.grow(true);
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

		local flip = this.Math.rand(0, 100) < 50;
		local sprite_body = this.getSprite("body");

		if (_tile != null)
		{
			local decal;
			local skin = this.getSprite("body");
			this.m.IsCorpseFlipped = flip;
			decal = _tile.spawnDetail(sprite_body.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = skin.Color;
			decal.Saturation = skin.Saturation;
			decal.Scale = 0.9;
			decal.setBrightness(0.9);
			this.spawnTerrainDropdownEffect(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "An " + this.getName();
			corpse.Tile = _tile;
			corpse.Value = 2.0;
			corpse.IsResurrectable = false;
			corpse.IsConsumable = false;
			corpse.Armor = this.m.BaseProperties.Armor;
			corpse.IsHeadAttached = true;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if ((_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals) && this.Math.rand(1, 100) <= 40)
			{
				local n = 0 + this.Math.rand(0, 1) + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = i )
				{
					local loot = this.new("scripts/items/misc/sulfurous_rocks_item");
					loot.drop(_tile);
					i = ++i;
				}

				if (this.Math.rand(1, 100) <= 10)
				{
					local loot = this.new("scripts/items/loot/glittering_rock_item");
					loot.drop(_tile);
				}
				else if (this.Math.rand(1, 100) <= 5)
				{
					local loot = this.new("scripts/items/trade/uncut_gems_item");
					loot.drop(_tile);
				}
			}

			this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
		}
	}

	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SandGolem);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToFire = true;
		b.IsAffectedByInjuries = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.m.Variant = this.Math.rand(1, 2);
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_golem_body_0" + this.m.Variant + "_small");
		body.varySaturation(0.2);
		body.varyColor(0.06, 0.06, 0.06);
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.45;
		this.setSpriteOffset("status_rooted", this.createVec(-4, 7));
		this.m.Skills.add(this.new("scripts/skills/racial/golem_racial"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_crippling_strikes"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_bullseye"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.m.Skills.add(this.new("scripts/skills/actives/merge_golem_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/throw_golem_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/headbutt_skill"));

		if (("Assets" in this.World) && this.World.Assets != null && this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
		{
			this.m.Skills.add(this.new("scripts/skills/perks/perk_last_stand"));
			this.m.Hitpoints = b.Hitpoints * 1.5;
			this.m.Skills.add(this.new("scripts/skills/traits/fearless_trait"));
			this.m.Skills.add(this.new("scripts/skills/traits/determined_trait"));
		}
	}

	o.shrink = function( _instant = false )
	{
		if (this.m.Size == 1)
		{
			return;
		}

		if (!_instant && this.m.Sound[this.Const.Sound.ActorEvent.Other2].len() != 0)
		{
			this.Sound.play(this.m.Sound[this.Const.Sound.ActorEvent.Other2][this.Math.rand(0, this.m.Sound[this.Const.Sound.ActorEvent.Other2].len() - 1)], this.Const.Sound.Volume.Actor, this.getPos());
		}

		this.m.Size = this.Math.max(1, this.m.Size - 1);
		this.m.IsShrinking = true;
		local b = this.m.BaseProperties;
		b.IsImmuneToKnockBackAndGrab = false;

		if (this.m.Size == 2)
		{
			this.getSprite("body").setBrush("bust_golem_body_0" + this.m.Variant + "_medium");

			if (!_instant)
			{
				this.setRenderCallbackEnabled(true);
				this.m.ScaleStartTime = this.Time.getVirtualTimeF();
			}

			this.getSprite("status_rooted").Scale = 0.5;
			this.getSprite("status_rooted_back").Scale = 0.5;
			this.setSpriteOffset("status_rooted", this.createVec(-4, 10));
			this.setSpriteOffset("status_rooted_back", this.createVec(-4, 10));

			if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null)
			{
				this.m.WorldTroop.Script = this.Const.World.Spawn.Troops.SandGolemMEDIUM.Script;
				this.m.WorldTroop.Strength = this.Const.World.Spawn.Troops.SandGolemMEDIUM.Strength;
			}
		}
		else if (this.m.Size == 1)
		{
			this.getSprite("body").setBrush("bust_golem_body_0" + this.m.Variant + "_small");

			if (!_instant)
			{
				this.setRenderCallbackEnabled(true);
				this.m.ScaleStartTime = this.Time.getVirtualTimeF();
			}

			this.getSprite("status_rooted").Scale = 0.6;
			this.getSprite("status_rooted_back").Scale = 0.6;
			this.setSpriteOffset("status_rooted", this.createVec(-7, 14));
			this.setSpriteOffset("status_rooted_back", this.createVec(-7, 14));

			if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null)
			{
				this.m.WorldTroop.Script = this.Const.World.Spawn.Troops.SandGolem.Script;
				this.m.WorldTroop.Strength = this.Const.World.Spawn.Troops.SandGolem.Strength;
			}
		}

		this.m.SoundPitch = 1.2 - this.m.Size * 0.1;
		this.m.Skills.update();
		this.setDirty(true);
	}

	o.onMovementStep = function( _tile, _levelDifference )
	{
		for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = i )
		{
			this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, _tile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.15 * this.m.Size, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.15 * this.m.Size, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
			i = ++i;
		}

		return this.actor.onMovementStep(_tile, _levelDifference);
	}

	o.onRemovedFromMap = function()
	{
		this.actor.onRemovedFromMap();

		if (!this.m.IsAlive && this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull())
		{
			this.m.WorldTroop.Party.removeTroop(this.m.WorldTroop);
		}
	}

});

