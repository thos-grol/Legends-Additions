::mods_hookExactClass("skills/actives/legend_gruesome_feast", function (o)
{
	local create = o.create;
    o.create = function()
    {
        this.m.ID = "actives.legend_gruesome_feast";
		this.m.Name = "Gruesome Feast";
		this.m.Description = "Feast on a corpse to regain health and cure injuries. This will daze and disgust any non-mutated human within four tiles. \n\nWill automatically feast on corpses at the end of the battle and restore full health and remove injuries.";
		this.m.Icon = "skills/gruesome_square.png";
		this.m.IconDisabled = "skills/gruesome_square_bw.png";
		this.m.Overlay = "gruesome_square";
		this.m.SoundOnUse = [
			"sounds/enemies/gruesome_feast_01.wav",
			"sounds/enemies/gruesome_feast_02.wav",
			"sounds/enemies/gruesome_feast_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAudibleWhenHidden = false;
		this.m.IsUsingActorPitch = true;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 35;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.MaxLevelDifference = 4;
    }

    local onUse = o.onUse;
    o.onUse = function(_user, _targetTile)
    {
        _targetTile = _user.getTile();

        if (_targetTile.IsVisibleForPlayer)
        {
            if (::Const.Tactical.GruesomeFeastParticles.len() != 0)
            {
                for( local i = 0; i < ::Const.Tactical.GruesomeFeastParticles.len(); i = i )
                {
                    this.Tactical.spawnParticleEffect(false, ::Const.Tactical.GruesomeFeastParticles[i].Brushes, _targetTile, ::Const.Tactical.GruesomeFeastParticles[i].Delay, ::Const.Tactical.GruesomeFeastParticles[i].Quantity, ::Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, ::Const.Tactical.GruesomeFeastParticles[i].SpawnRate, ::Const.Tactical.GruesomeFeastParticles[i].Stages);
                    i = ++i;
                }
            }

            if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
                this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " feasts on a corpse");
        }

        if (!_user.isHiddenToPlayer()) this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onRemoveCorpse, _targetTile);
        else this.onRemoveCorpse(_targetTile);

        this.spawnBloodbath(_targetTile);
        _user.setHitpoints(::Math.min(_user.getHitpoints() + 50, _user.getHitpointsMax()));
        local skills = _user.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);

        foreach( s in skills )
        {
            if (s.getOrder() == ::Const.SkillOrder.PermanentInjury) continue;
            s.removeSelf();
        }

        local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

        foreach( a in actors )
        {
            if (a.getID() == _user.getID()) continue;
            if (_user.getTile().getDistanceTo(a.getTile()) > 4) continue;
            if (_user.getFlags().getAsInt("SequencesUsed") > 0) continue;

            a.getSkills().add(::new("scripts/skills/effects/legend_dazed_effect"));
            if (a.getFaction() != _user.getFaction()) continue;
            a.worsenMood(2.0, "Witnessed someone eat a corpse");
        }

        _user.onUpdateInjuryLayer();
        return true;
    }

	o.onAdded <- function()
	{
		local actor = this.getContainer().getActor();
		if (actor.isPlayerControlled()) return;
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.GruesomeFeast) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_gruesome_feast_potion"));
			agent.finalizeBehaviors();
		}
	}

});

::mods_hookExactClass("states/tactical_state", function ( o )
{
	o.onBattleEnded = function ()
	{
		if (this.m.IsExitingToMenu)
		{
			return;
		}

		this.m.IsBattleEnded = true;
		local isVictory = this.Tactical.Entities.getCombatResult() == ::Const.Tactical.CombatResult.EnemyDestroyed || this.Tactical.Entities.getCombatResult() == ::Const.Tactical.CombatResult.EnemyRetreated;
		this.m.IsFogOfWarVisible = false;
		this.Tactical.fillVisibility(::Const.Faction.Player, true);
		this.Tactical.getCamera().zoomTo(2.0, 1.0);
		this.Tooltip.hide();
		this.m.TacticalScreen.hide();
		this.Tactical.OrientationOverlay.removeOverlays();

		if (isVictory)
		{
			this.Music.setTrackList(::Const.Music.VictoryTracks, ::Const.Music.CrossFadeTime);

			if (!this.isScenarioMode())
			{
				if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsAttackingLocation)
				{
					this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnVictoryVSLocation);
				}
				else
				{
					this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnVictory);
				}

				this.World.Contracts.onCombatVictory(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				this.World.Events.onCombatVictory(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
				this.World.Statistics.getFlags().set("LastPlayersAtBattleStartCount", this.m.MaxPlayers);
				this.World.Statistics.getFlags().set("LastEnemiesDefeatedCount", this.m.MaxHostiles);
				this.World.Statistics.getFlags().set("LastCombatResult", 1);

				if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") == this.World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).getID())
				{
					this.World.Statistics.getFlags().increment("BeastsDefeated");
				}

				this.World.Assets.getOrigin().onBattleWon(this.m.CombatResultLoot);
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach( bro in playerRoster )
				{
					if (bro.getPlaceInFormation() <= 26 && !bro.isPlacedOnMap() && bro.getFlags().get("Devoured") == true)
					{
						bro.getSkills().onDeath(::Const.FatalityType.Devoured);
						bro.onDeath(null, null, null, ::Const.FatalityType.Devoured);
						this.World.getPlayerRoster().remove(bro);
					}
					else if (this.m.StrategicProperties.IsUsingSetPlayers && bro.isPlacedOnMap())
					{
						bro.getLifetimeStats().BattlesWithoutMe = 0;

						if (this.m.StrategicProperties.IsArenaMode)
						{
							bro.improveMood(::Const.MoodChange.BattleWon, "Won a fight in the arena");
						}
						else
						{
							bro.improveMood(::Const.MoodChange.BattleWon, "Won a battle");
						}
					}
					else if (bro.getSkills().hasSkill("perk.legend_pacifist"))
					{
						if (bro.getLifetimeStats().BattlesWithoutMe > bro.getLifetimeStats().Battles)
						{
							bro.worsenMood(::Const.MoodChange.BattleWithoutMe, "Forced into battle against their wishes");
						}
					}
					else if (!this.m.StrategicProperties.IsUsingSetPlayers)
					{
						if (bro.isPlacedOnMap())
						{
							bro.getLifetimeStats().BattlesWithoutMe = 0;
							bro.improveMood(::Const.MoodChange.BattleWon, "Won a battle");
						}
						else if (bro.getMoodState() > ::Const.MoodState.Concerned && !bro.getCurrentProperties().IsContentWithBeingInReserve && !this.World.Assets.m.IsDisciplined)
						{
							++bro.getLifetimeStats().BattlesWithoutMe;

							if (bro.getLifetimeStats().BattlesWithoutMe > ::Math.max(2, 6 - bro.getLevel()))
							{
								bro.worsenMood(::Const.MoodChange.BattleWithoutMe, "Felt useless in reserve");
							}
						}
					}

					bro.getFlags().remove("TemporaryRider");

					//if bro has gruesome feast skill, then run this code
					if (bro.getSkills().hasSkill("perk.legend_gruesome_feast"))
					{
						local skills = bro.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);
						foreach( s in skills )
						{
							if (s.getOrder() == ::Const.SkillOrder.PermanentInjury) continue;
							s.removeSelf();
						}

						bro.setHitpoints(bro.getHitpointsMax());
					}
				}
			}
		}
		else
		{
			this.Music.setTrackList(::Const.Music.DefeatTracks, ::Const.Music.CrossFadeTime);

			if (!this.isScenarioMode())
			{
				local playerRoster = this.World.getPlayerRoster().getAll();

				foreach( bro in playerRoster )
				{
					if (bro.getPlaceInFormation() <= 26 && !bro.isPlacedOnMap() && bro.getFlags().get("Devoured") == true)
					{
						if (bro.isAlive())
						{
							bro.getSkills().onDeath(::Const.FatalityType.Devoured);
							bro.onDeath(null, null, null, ::Const.FatalityType.Devoured);
							this.World.getPlayerRoster().remove(bro);
						}
					}
					else if (bro.isPlacedOnMap() && (bro.getFlags().get("Charmed") == true || bro.getFlags().get("Sleeping") == true || bro.getFlags().get("Nightmare") == true))
					{
						if (bro.isAlive())
						{
							bro.kill(null, null, ::Const.FatalityType.Suicide);
						}
					}
					else if (bro.isPlacedOnMap())
					{
						bro.getLifetimeStats().BattlesWithoutMe = 0;

						if (this.Tactical.getCasualtyRoster().getSize() != 0)
						{
							bro.worsenMood(::Const.MoodChange.BattleLost, "Lost a battle");
						}
						else if (this.World.Assets.getOrigin().getID() != "scenario.deserters")
						{
							bro.worsenMood(::Const.MoodChange.BattleRetreat, "Retreated from battle");
						}
					}
					else if (bro.getMoodState() > ::Const.MoodState.Concerned && !bro.getCurrentProperties().IsContentWithBeingInReserve && (!bro.getFlags().has("TemporaryRider") || !bro.getFlags().has("IsHorse")))
					{
						++bro.getLifetimeStats().BattlesWithoutMe;

						if (bro.getLifetimeStats().BattlesWithoutMe > ::Math.max(2, 6 - bro.getLevel()))
						{
							bro.worsenMood(::Const.MoodChange.BattleWithoutMe, "Felt useless in reserve");
						}
					}

					bro.getFlags().remove("TemporaryRider");
				}

				if (this.World.getPlayerRoster().getSize() != 0)
				{
					this.World.Assets.addBusinessReputation(::Const.World.Assets.ReputationOnLoss);
					this.World.Contracts.onRetreatedFromCombat(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
					this.World.Events.onRetreatedFromCombat(this.m.StrategicProperties != null ? this.m.StrategicProperties.CombatID : "");
					this.World.Statistics.getFlags().set("LastEnemiesDefeatedCount", 0);
					this.World.Statistics.getFlags().set("LastCombatResult", 2);
				}
			}
		}

		if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode)
		{
			this.Sound.play(::Const.Sound.ArenaEnd[::Math.rand(0, ::Const.Sound.ArenaEnd.len() - 1)], ::Const.Sound.Volume.Tactical);
			this.Time.scheduleEvent(this.TimeUnit.Real, 4500, function ( _t )
			{
				this.Sound.play(::Const.Sound.ArenaOutro[::Math.rand(0, ::Const.Sound.ArenaOutro.len() - 1)], ::Const.Sound.Volume.Tactical);
			}, null);
		}

		this.gatherBrothers(isVictory);
		this.gatherLoot();
		this.Time.scheduleEvent(this.TimeUnit.Real, 800, this.onBattleEndedDelayed.bindenv(this), isVictory);
	};
});