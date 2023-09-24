::mods_hookExactClass("states/tactical_state", function (o)
{
	o.executeEntitySkill = function( _activeEntity, _targetTile )
	{
		local skill = _activeEntity.getSkills().getSkillByID(this.m.SelectedSkillID);

		if (skill != null && skill.isUsable() && skill.isAffordable())
		{
			if (_targetTile == null || skill.isTargeted() && this.wasInCameraMovementMode())
			{
				return;
			}

			if (skill.isUsableOn(_targetTile))
			{
				if (!_targetTile.IsEmpty)
				{
					local targetEntity = _targetTile.getEntity();

					if (this.Tactical.getCamera().Level < _targetTile.Level)
					{
						this.Tactical.getCamera().Level = this.Tactical.getCamera().getBestLevelForTile(_targetTile);
					}

					if (this.isKindOf(targetEntity, "actor"))
					{
						this.logDebug("[" + _activeEntity.getName() + "] executes skill [" + skill.getName() + "] on target [" + targetEntity.getName() + "]");
					}
				}

				skill.use(_targetTile);

				if (_activeEntity.isAlive())
				{
					this.Tactical.TurnSequenceBar.updateEntity(_activeEntity.getID());
				}

				this.Tooltip.reload();
				this.Tactical.TurnSequenceBar.deselectActiveSkill();
				this.Tactical.getHighlighter().clear();
				this.m.CurrentActionState = null;
				this.m.SelectedSkillID = null;
				this.updateCursorAndTooltip();
			}
			else
			{
				this.Cursor.setCursor(::Const.UI.Cursor.Denied);
			}
		}
	}

	//Copied from legends mod tactical state
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
				this.World.Statistics.getFlags().increment("BattlesWon");

				if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") == this.World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).getID())
				{
					this.World.Statistics.getFlags().increment("BeastsDefeated");
				}

				this.World.Assets.getOrigin().onBattleWon(this.m.CombatResultLoot);
				local playerRoster = this.World.getPlayerRoster().getAll();

				local trial_by_fire = false;

				foreach( bro in playerRoster )
				{
					if (bro.getSkills().hasSkill("perk.trial_by_fire") && bro.isPlacedOnMap()) trial_by_fire = true;
					break;
				}

				foreach( bro in playerRoster )
				{
					if (bro.getPlaceInFormation() <= 26 && !bro.isPlacedOnMap() && bro.getFlags().get("Devoured") == true)
					{
						bro.getSkills().onDeath(::Const.FatalityType.Devoured);
						bro.onDeath(null, null, null, ::Const.FatalityType.Devoured);
						this.World.getPlayerRoster().remove(bro);
					}
					else if (bro.getSkills().hasSkill("perk.legend_pacifist") && bro.isPlacedOnMap())
					{
						bro.getLifetimeStats().BattlesWithoutMe = 0;
						bro.worsenMood(::Const.MoodChange.BattleWithoutMe, "Forced into battle against their wishes");
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
							if (trial_by_fire && bro.m.Level < 5)
							{
								bro.m.PerkPoints += 1;
								bro.m.LevelUps += 1;
								bro.m.Level += 1;
								bro.m.XP += ::Const.LevelXP[bro.m.Level - 1];
							}
						}
					}
					else if (!this.m.StrategicProperties.IsUsingSetPlayers)
					{
						if (bro.isPlacedOnMap())
						{
							bro.getLifetimeStats().BattlesWithoutMe = 0;
							bro.improveMood(::Const.MoodChange.BattleWon, "Won a battle");
							if (trial_by_fire && bro.m.Level < 5)
							{
								bro.m.PerkPoints += 1;
								bro.m.LevelUps += 1;
								bro.m.Level += 1;
								bro.m.XP += ::Const.LevelXP[bro.m.Level - 1];
							}
						}
						else if (bro.getMoodState() > ::Const.MoodState.Concerned && !bro.getCurrentProperties().IsContentWithBeingInReserve && !this.World.Assets.m.IsDisciplined)
						{
							++bro.getLifetimeStats().BattlesWithoutMe;

							if (bro.getLifetimeStats().BattlesWithoutMe > this.Math.max(2, 6 - bro.getLevel()))
							{
								bro.worsenMood(::Const.MoodChange.BattleWithoutMe, "Felt useless in reserve");
							}
						}
					}

					bro.getFlags().remove("TemporaryRider");
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

						if (bro.getLifetimeStats().BattlesWithoutMe > this.Math.max(2, 6 - bro.getLevel()))
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
			this.Sound.play(::Const.Sound.ArenaEnd[this.Math.rand(0, ::Const.Sound.ArenaEnd.len() - 1)], ::Const.Sound.Volume.Tactical);
			this.Time.scheduleEvent(this.TimeUnit.Real, 4500, function ( _t )
			{
				this.Sound.play(::Const.Sound.ArenaOutro[this.Math.rand(0, ::Const.Sound.ArenaOutro.len() - 1)], ::Const.Sound.Volume.Tactical);
			}, null);
		}

		this.gatherBrothers(isVictory);
		this.gatherLoot();
		this.Time.scheduleEvent(this.TimeUnit.Real, 800, this.onBattleEndedDelayed.bindenv(this), isVictory);
	};
});