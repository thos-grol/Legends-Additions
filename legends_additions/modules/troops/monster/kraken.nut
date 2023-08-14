::Const.Tactical.Actor.Kraken = {
	XP = 4500,
	ActionPoints = 9,
	Hitpoints = 3800,
	Bravery = 999,
	Stamina = 999,
	MeleeSkill = 999,
	RangedSkill = 0,
	MeleeDefense = -15,
	RangedDefense = -15,
	Initiative = -300,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		1600,
		1600
	]
};
::mods_hookExactClass("entity/tactical/enemies/kraken", function(o) {
	o.getImageOffsetY = function()
	{
		return 40;
	}

	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode())
		{
			this.updateAchievement("BeastOfBeasts", 1, 1);
		}

		if (_tile != null)
		{
			local flip = false;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			decal = _tile.spawnDetail("bust_kraken_body_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;
			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = this.getName();
			corpse.IsHeadAttached = true;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			foreach( t in this.m.Tentacles )
			{
				if (t.isNull())
				{
					continue;
				}

				t.setParent(null);

				if (t.isPlacedOnMap())
				{
					t.killSilently();
				}
			}

			this.m.Tentacles = [];
			local loot;
			loot = this.new("scripts/items/misc/kraken_horn_plate_item");
			loot.drop(_tile);
			loot = this.new("scripts/items/misc/kraken_horn_plate_item");
			loot.drop(_tile);
			loot = this.new("scripts/items/misc/kraken_tentacle_item");
			loot.drop(_tile);

			if (!this.Tactical.State.isScenarioMode() && this.World.Assets.getExtraLootChance() > 0)
			{
				loot = this.new("scripts/items/misc/kraken_horn_plate_item");
				loot.drop(_tile);
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.kill = function( _killer = null, _skill = null, _fatalityType = this.Const.FatalityType.None, _silent = false )
	{
		this.actor.kill(_killer, _skill, _fatalityType, _silent);
	}

	o.setFaction = function( _f )
	{
		this.actor.setFaction(_f);

		foreach( t in this.m.Tentacles )
		{
			if (!t.isNull() && t.isAlive())
			{
				t.setFaction(_f);
			}
		}
	}

	o.onTentacleDestroyed = function()
	{
		if (!this.isAlive() || this.isDying())
		{
			return;
		}

		++this.m.TentaclesDestroyed;

		foreach( i, t in this.m.Tentacles )
		{
			if (t.isNull() || t.isDying() || !t.isAlive())
			{
				this.m.Tentacles.remove(i);
				break;
			}
		}

		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.Math.max(35, 190 - (this.m.TentaclesDestroyed - 1) * 5);
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Head;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		this.onDamageReceived(this, null, hitInfo);

		if (!this.isAlive() || this.isDying())
		{
			return;
		}

		for( local numTentacles = this.Math.max(4, this.Math.min(8, this.Math.ceil(this.getHitpointsPct() * 2.0 * 8))); this.m.Tentacles.len() < numTentacles;  )
		{
			local mapSize = this.Tactical.getMapSize();
			local myTile = this.getTile();

			for( local attempts = 0; attempts < 500; attempts = attempts )
			{
				local x = this.Math.rand(this.Math.max(0, myTile.SquareCoords.X - 8), this.Math.min(mapSize.X - 1, myTile.SquareCoords.X + 8));
				local y = this.Math.rand(this.Math.max(0, myTile.SquareCoords.Y - 8), this.Math.min(mapSize.Y - 1, myTile.SquareCoords.Y + 8));
				local tile = this.Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
				}
				else
				{
					local tentacle = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/kraken_tentacle", tile.Coords);
					tentacle.setParent(this);
					tentacle.setFaction(this.getFaction());
					tentacle.setMode(this.m.IsEnraged ? 1 : 0);
					tentacle.riseFromGround();
					this.m.Tentacles.push(this.WeakTableRef(tentacle));
					break;
				}

				attempts = ++attempts;
			}
		}
	}

	o.onDamageReceived = function( _attacker, _skill, _hitInfo )
	{
		_hitInfo.BodyPart = this.Const.BodyPart.Head;
		local ret = this.actor.onDamageReceived(_attacker, _skill, _hitInfo);

		if (!this.m.IsEnraged && (this.m.TentaclesDestroyed >= 6 || this.getHitpointsPct() <= 0.5))
		{
			this.playSound(this.Const.Sound.ActorEvent.Other1, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1] * this.m.SoundVolumeOverall);
			this.m.IsEnraged = true;

			foreach( t in this.m.Tentacles )
			{
				if (!t.isNull() && t.isAlive() && t.getHitpoints() > 0)
				{
					t.setMode(1);
				}
			}
		}

		return ret;
	}

	o.onPlacedOnMap = function()
	{
		this.actor.onPlacedOnMap();
		this.getTile().clear();
		this.getTile().IsHidingEntity = false;
		local myTile = this.getTile();

		if (myTile.hasNextTile(this.Const.Direction.N))
		{
			local tile = myTile.getNextTile(this.Const.Direction.N);

			if (tile.IsEmpty)
			{
				this.Tactical.spawnEntity("scripts/entity/tactical/objects/swamp_tree1", tile.Coords);
			}

			if (tile.hasNextTile(this.Const.Direction.N))
			{
				local tile = tile.getNextTile(this.Const.Direction.N);

				if (tile.IsEmpty)
				{
					this.Tactical.spawnEntity("scripts/entity/tactical/objects/swamp_tree1", tile.Coords);
				}
			}
		}
	}

	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Kraken);
		b.TargetAttractionMult = 3.0;
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsRooted = true;
		b.IsImmuneToDisarm = true;
		b.IsAffectedByRain = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;

		if (!this.Tactical.State.isScenarioMode())
		{
			if (!this.World.Flags.get("IsKrakenDefeated"))
			{
				this.setName("Beast of Beasts");
			}
			else
			{
				this.setName(this.Const.Strings.KrakenNames[this.Math.rand(0, this.Const.Strings.KrakenNames.len() - 1)]);
			}
		}

		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_kraken_body_01");

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.08, 0.08, 0.08);
		}

		this.addDefaultStatusSprites();
		this.setSpriteOffset("arrow", this.createVec(20, 190));
		this.m.Skills.add(this.new("scripts/skills/actives/kraken_devour_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		local myTile = this.getTile();

		for( local i = 0; i < 8; i = i )
		{
			local mapSize = this.Tactical.getMapSize();

			for( local attempts = 0; attempts < 500; attempts = attempts )
			{
				local x = this.Math.rand(this.Math.max(0, myTile.SquareCoords.X - 2), this.Math.min(mapSize.X - 1, myTile.SquareCoords.X + 8));
				local y = this.Math.rand(this.Math.max(0, myTile.SquareCoords.Y - 8), this.Math.min(mapSize.Y - 1, myTile.SquareCoords.Y + 8));
				local tile = this.Tactical.getTileSquare(x, y);

				if (!tile.IsEmpty)
				{
				}
				else
				{
					local tentacle = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/kraken_tentacle", tile.Coords);
					tentacle.setParent(this);
					tentacle.setFaction(this.getFaction());
					this.m.Tentacles.push(this.WeakTableRef(tentacle));
					break;
				}

				attempts = ++attempts;
			}

			i = ++i;
		}
	}

	o.onDiscovered = function()
	{
		this.playSound(this.Const.Sound.ActorEvent.Idle, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Other1] * this.m.SoundVolumeOverall);
		this.actor.onDiscovered();
	}

});

