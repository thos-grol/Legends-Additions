::mods_hookExactClass("entity/tactical/actor", function (o){
	//copied from legends actor hook
	o.kill <- function ( _killer = null, _skill = null, _fatalityType = this.Const.FatalityType.None, _silent = false )
	{
		if (!this.isAlive()) return;
		if (_killer != null && !_killer.isAlive()) _killer = null;
		if (this.m.IsMiniboss && !this.Tactical.State.isScenarioMode() && _killer != null && _killer.isPlayerControlled())
		{
			this.updateAchievement("GiveMeThat", 1, 1);
			if (!this.Tactical.State.isScenarioMode() && this.World.Retinue.hasFollower("follower.bounty_hunter"))
			{
				this.World.Retinue.getFollower("follower.bounty_hunter").onChampionKilled(this);
			}
		}

		this.m.IsDying = true;
		local isReallyDead = this.isReallyKilled(_fatalityType);

		if (!isReallyDead)
		{
			this.TherianthropeInfection(_killer);
			_fatalityType = this.Const.FatalityType.Unconscious;
			this.logDebug(this.getName() + " is unconscious.");
		}
		else
		{
			this.logDebug(this.getName() + " has died.");
		}

		if (!_silent)
		{
			this.playSound(this.Const.Sound.ActorEvent.Death, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Death] * this.m.SoundVolumeOverall, this.m.SoundPitch);
		}

		local myTile = this.isPlacedOnMap() ? this.getTile() : null;
		local tile = this.findTileToSpawnCorpse(_killer);
		this.m.Skills.onDeath(_fatalityType);
		this.onDeath(_killer, _skill, tile, _fatalityType);
		::Z.Lib.imprint_corpse(this, tile);

		if (!this.Tactical.State.isFleeing() && _killer != null)
		{
			_killer.onActorKilled(this, tile, _skill);
		}

		if (_killer != null && !_killer.isHiddenToPlayer() && !this.isHiddenToPlayer())
		{
			if (isReallyDead)
			{
				if (_killer.getID() != this.getID())
				{
					this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_killer) + " has killed " + this.Const.UI.getColorizedEntityName(this));
				}
				else
				{
					this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " has died");
				}
			}
			else if (_killer.getID() != this.getID())
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_killer) + " has struck down " + this.Const.UI.getColorizedEntityName(this));
			}
			else
			{
				this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(this) + " is struck down");
			}
		}

		if (!this.Tactical.State.isFleeing() && myTile != null)
		{
			local actors = this.Tactical.Entities.getAllInstances();

			foreach( i in actors )
			{
				foreach( a in i )
				{
					if (a.getID() != this.getID())
					{
						a.onOtherActorDeath(_killer, this, _skill);
					}
				}
			}
		}

		if (!this.isHiddenToPlayer())
		{
			if (tile != null)
			{
				if (_fatalityType == this.Const.FatalityType.Decapitated)
				{
					this.spawnDecapitateSplatters(tile, 1.0 * this.m.DecapitateBloodAmount);
				}
				else if (_fatalityType == this.Const.FatalityType.Smashed && (this.getFlags().has("human") || this.getFlags().has("zombie_minion")))
				{
					this.spawnSmashSplatters(tile, 1.0);
				}
				else
				{
					this.spawnBloodSplatters(tile, this.Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);

					if (!this.getTile().isSameTileAs(tile))
					{
						this.spawnBloodSplatters(this.getTile(), this.Const.Combat.BloodSplattersAtOriginalPosMult);
					}
				}
			}
			else if (myTile != null)
			{
				this.spawnBloodSplatters(this.getTile(), this.Const.Combat.BloodSplattersAtDeathMult * this.m.DeathBloodAmount);
			}
		}

		if (tile != null)
		{
			this.spawnBloodPool(tile, this.Math.rand(this.Const.Combat.BloodPoolsAtDeathMin, this.Const.Combat.BloodPoolsAtDeathMax));
		}

		this.m.IsTurnDone = true;
		this.m.IsAlive = false;

		if (this.m.WorldTroop != null && ("Party" in this.m.WorldTroop) && this.m.WorldTroop.Party != null && !this.m.WorldTroop.Party.isNull())
		{
			this.m.WorldTroop.Party.removeTroop(this.m.WorldTroop);
		}

		if (!this.Tactical.State.isScenarioMode())
		{
			this.World.Contracts.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);
			this.World.Events.onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);
			this.World.Assets.getOrigin().onActorKilled(this, _killer, this.Tactical.State.getStrategicProperties().CombatID);

			if (this.Tactical.State.getStrategicProperties() != null && this.Tactical.State.getStrategicProperties().IsArenaMode)
			{
				if (_killer == null || _killer.getID() == this.getID())
				{
					this.Sound.play(this.Const.Sound.ArenaFlee[this.Math.rand(0, this.Const.Sound.ArenaFlee.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
				}
				else
				{
					this.Sound.play(this.Const.Sound.ArenaKill[this.Math.rand(0, this.Const.Sound.ArenaKill.len() - 1)], this.Const.Sound.Volume.Tactical * this.Const.Sound.Volume.Arena);
				}
			}
		}

		if (this.isPlayerControlled())
		{
			if (isReallyDead)
			{
				if (this.isGuest())
				{
					this.World.getGuestRoster().remove(this);
				}
				else
				{
					this.World.getPlayerRoster().remove(this);
				}
			}

			if (this.Tactical.Entities.getHostilesNum() != 0)
			{
				this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.PlayerDestroyed);
			}
			else
			{
				this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.EnemyDestroyed);
			}
		}
		else
		{
			if (!this.Tactical.State.isAutoRetreat())
			{
				this.Tactical.Entities.setLastCombatResult(this.Const.Tactical.CombatResult.EnemyDestroyed);
			}

			if (_killer != null && _killer.isPlayerControlled() && !this.Tactical.State.isScenarioMode() && this.World.FactionManager.getFaction(this.getFaction()) != null && !this.World.FactionManager.getFaction(this.getFaction()).isTemporaryEnemy())
			{
				this.World.FactionManager.getFaction(this.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationUnitKilled);
			}
		}

		if (isReallyDead)
		{
			if (!this.Tactical.State.isScenarioMode() && this.isPlayerControlled() && !this.isGuest())
			{
				local roster = this.World.getPlayerRoster().getAll();

				foreach( bro in roster )
				{
					if (bro.isAlive() && !bro.isDying() && bro.getCurrentProperties().IsAffectedByDyingAllies)
					{
						if (this.World.Assets.getOrigin().getID() != "scenario.manhunters" || this.getBackground().getID() != "background.slave")
						{
							bro.worsenMood(this.Const.MoodChange.BrotherDied, this.getName() + " died in battle");
						}
					}
				}
			}

			this.die();
		}
		else
		{
			this.removeFromMap();
		}

		if (this.m.Items != null)
		{
			this.m.Items.onActorDied(tile);

			if (isReallyDead)
			{
				this.m.Items.setActor(null);
			}
		}

		if (!this.Tactical.State.isScenarioMode() && _killer != null && _killer.getFaction() == this.Const.Faction.PlayerAnimals && _skill != null && _skill.getID() == "actives.wardog_bite")
		{
			this.updateAchievement("WhoLetTheDogsOut", 1, 1);
		}

		this.onAfterDeath(myTile);
	};
});