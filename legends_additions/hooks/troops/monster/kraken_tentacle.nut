::Const.Tactical.Actor.KrakenTentacle = {
	XP = 200,
	ActionPoints = 9,
	Hitpoints = 300,
	Bravery = 60,
	Stamina = 999,
	MeleeSkill = 80,
	RangedSkill = 0,
	MeleeDefense = 25,
	RangedDefense = 25,
	Initiative = 100,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 25,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/kraken_tentacle", function(o) {
	o.setParent = function( _p )
	{
		if (_p == null)
		{
			this.m.Parent = null;
		}
		else
		{
			this.m.Parent = this.WeakTableRef(_p);
		}
	}

	o.getParent = function()
	{
		return this.m.Parent;
	}

	o.setMode = function( _m )
	{
		this.m.Mode = _m;

		if (this.isPlacedOnMap())
		{
			if (this.m.Mode == 0 && _m == 1)
			{
				this.m.IsUsingZoneOfControl = true;
				this.setZoneOfControl(this.getTile(), true);
			}

			this.onUpdateInjuryLayer();
		}
	}

	o.getMode = function()
	{
		return this.m.Mode;
	}

	o.getImageOffsetY = function()
	{
		return 20;
	}

	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.KrakenTentacle);
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		b.IsAffectedByRain = false;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_kraken_tentacle_01");
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.68;
		this.setSpriteOffset("status_rooted", this.createVec(5, 25));
		this.setSpriteOffset("arrow", this.createVec(0, 25));
		this.setSpriteOffset("status_stunned", this.createVec(0, 25));
		this.m.Skills.add(this.new("scripts/skills/actives/kraken_move_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/kraken_bite_skill"));
		this.m.Skills.add(this.new("scripts/skills/actives/kraken_ensnare_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_stalwart"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_poison_immunity"));
		this.Tactical.getTemporaryRoster().add(this);
	}

	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
		}

		_tile = this.getTile();
		local decal_body = _tile.spawnDetail(this.getMode() == 0 ? "bust_kraken_tentacle_01_injured" : "bust_kraken_tentacle_02_injured", this.Const.Tactical.DetailFlag.Corpse, false);
		local corpse_data = {
			Body = decal_body,
			Start = this.Time.getRealTimeF(),
			Vector = this.createVec(0.0, -150.0),
			Tile = _tile,
	o.onCorpseEffect = function( _data )
			{
				if (this.Time.getRealTimeF() - _data.Start >= 0.75)
				{
					_tile.clear(this.Const.Tactical.DetailFlag.Corpse);
					return;
				}

				local f = (this.Time.getRealTimeF() - _data.Start) / 0.75;
				_data.Body.setOffset(this.createVec(0.0, 0.0 + _data.Vector.Y * f));
				this.Time.scheduleEvent(this.TimeUnit.Real, 10, _data.onCorpseEffect, _data);
			}

		};
		this.Time.scheduleEvent(this.TimeUnit.Real, 10, corpse_data.onCorpseEffect, corpse_data);

		if (this.Const.Tactical.TerrainDropdownParticles[_tile.Subtype].len() != 0)
		{
			for( local i = 0; i < this.Const.Tactical.TerrainDropdownParticles[_tile.Subtype].len(); i = i )
			{
				if (this.Tactical.getWeather().IsRaining && !this.Const.Tactical.TerrainDropdownParticles[_tile.Subtype][i].ApplyOnRain)
				{
				}
				else
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.TerrainDropdownParticles[_tile.Subtype][i].Brushes, _tile, this.Const.Tactical.TerrainDropdownParticles[_tile.Subtype][i].Delay, this.Const.Tactical.TerrainDropdownParticles[_tile.Subtype][i].Quantity, this.Const.Tactical.TerrainDropdownParticles[_tile.Subtype][i].LifeTimeQuantity, this.Const.Tactical.TerrainDropdownParticles[_tile.Subtype][i].SpawnRate, this.Const.Tactical.TerrainDropdownParticles[_tile.Subtype][i].Stages);
				}

				i = ++i;
			}
		}
		else if (this.Const.Tactical.RaiseFromGroundParticles.len() != 0)
		{
			for( local i = 0; i < this.Const.Tactical.RaiseFromGroundParticles.len(); i = i )
			{
				this.Tactical.spawnParticleEffect(false, this.Const.Tactical.RaiseFromGroundParticles[i].Brushes, _tile, this.Const.Tactical.RaiseFromGroundParticles[i].Delay, this.Const.Tactical.RaiseFromGroundParticles[i].Quantity, this.Const.Tactical.RaiseFromGroundParticles[i].LifeTimeQuantity, this.Const.Tactical.RaiseFromGroundParticles[i].SpawnRate, this.Const.Tactical.RaiseFromGroundParticles[i].Stages);
				i = ++i;
			}
		}

		if (this.m.Parent != null && !this.m.Parent.isNull() && this.m.Parent.isAlive() && !this.m.Parent.isDying())
		{
			this.m.Parent.onTentacleDestroyed();
		}

		this.Tactical.getTemporaryRoster().remove(this);
		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.spawnBloodPool = function( _a, _b )
	{
	}

	o.onDamageReceived = function( _attacker, _skill, _hitInfo )
	{
		_hitInfo.BodyPart = this.Const.BodyPart.Body;
		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	o.onPlacedOnMap = function()
	{
		this.actor.onPlacedOnMap();
		this.onUpdateInjuryLayer();
	}

});

