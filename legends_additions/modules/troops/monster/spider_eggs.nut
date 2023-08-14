::Const.Tactical.Actor.SpiderEggs = {
	XP = 0,
	ActionPoints = 0,
	Hitpoints = 20,
	Bravery = 0,
	Stamina = 0,
	MeleeSkill = 0,
	RangedSkill = 0,
	MeleeDefense = -50,
	RangedDefense = 0,
	Initiative = 0,
	FatigueEffectMult = 1.0,
	MoraleEffectMult = 1.0,
	FatigueRecoveryRate = 0,
	Armor = [
		0,
		0
	]
};
::mods_hookExactClass("entity/tactical/enemies/spider_eggs", function(o) {
	o.onDeath = function( _killer, _skill, _tile, _fatalityType )
	{
		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("ScrambledEggs", 1, 1);
		}

		local flip = this.Math.rand(0, 100) < 50;

		if (_tile != null)
		{
			_tile.spawnDetail("nest_01_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			this.spawnTerrainDropdownEffect(_tile);
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	o.onDamageReceived = function( _attacker, _skill, _hitInfo )
	{
		_hitInfo.BodyPart = this.Const.BodyPart.Body;
		return this.actor.onDamageReceived(_attacker, _skill, _hitInfo);
	}

	o.onInit = function()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.SpiderEggs);
		b.IsImmuneToKnockBackAndGrab = true;
		b.IsImmuneToRoot = true;
		b.IsImmuneToBleeding = true;
		b.IsImmuneToPoison = true;
		b.IsAffectedByNight = false;
		b.IsMovable = false;
		b.IsAffectedByInjuries = false;
		b.IsImmuneToDisarm = true;
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local flip = this.Math.rand(0, 1) == 1;
		local body = this.addSprite("body");
		body.setBrush("nest_01");
		body.setHorizontalFlipping(flip);
		this.addDefaultStatusSprites();
		this.m.Skills.add(this.new("scripts/skills/perks/perk_legend_composure"));
		this.m.Skills.add(this.new("scripts/skills/racial/skeleton_racial"));
		this.m.Skills.update();
	}

	o.onPlacedOnMap = function()
	{
		this.actor.onPlacedOnMap();
		this.registerSpawnEvent();
	}

	o.registerSpawnEvent = function()
	{
		this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 2), this.onSpawn.bindenv(this), this.getTile());
	}

	o.onSpawn = function( _tile )
	{
		if (_tile.IsEmpty)
		{
			return;
		}

		if (!_tile.IsOccupiedByActor || _tile.getEntity().getType() != this.Const.EntityType.SpiderEggs)
		{
			return;
		}

		if (this.Tactical.Entities.isEnemyRetreating())
		{
			return;
		}

		local tile;

		for( local i = 0; i < 6; i = i )
		{
			if (!_tile.hasNextTile(i))
			{
			}
			else
			{
				local nextTile = _tile.getNextTile(i);

				if (!nextTile.IsEmpty || this.Math.abs(nextTile.Level - _tile.Level) > 1)
				{
				}
				else
				{
					tile = nextTile;
					break;
				}
			}

			i = ++i;
		}

		if (tile != null)
		{
			local spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/spider", tile.Coords);
			spawn.setSize(this.Math.rand(60, 75) * 0.01);
			spawn.setFaction(this.getFaction());
			spawn.m.XP = spawn.m.XP / 2;
			local allies = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());

			foreach( a in allies )
			{
				if (a.getType() == this.Const.EntityType.Hexe)
				{
					spawn.getSkills().add(this.new("scripts/skills/effects/fake_charmed_effect"));
					break;
				}
			}

			++this.m.Count;
		}

		if (this.m.Count < 4)
		{
			this.registerSpawnEvent();
		}
		else
		{
			this.killSilently();
		}
	}

});

