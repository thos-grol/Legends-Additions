::Const.Contracts.Roaming_Beasts <- {};
::Const.Contracts.Roaming_Beasts.VillageInfo <- [
	{
		Medium = "medium_snow_village",
		Small = "small_snow_village",
		Legends = "legends_snow_village",
		Flags = [
			{
				ID = "IsHumans",
				Chance = 5
			},
			{
				ID = "IsDirewolves",
				Chance = 40
			},
			{
				ID = "IsGhouls",
				Chance = 100
			}
		]
	},
	{
		Medium = "medium_tundra_village",
		Small = "small_tundra_village",
		Legends = "legends_tundra_village",
		Flags = [
			{
				ID = "IsHumans",
				Chance = 5
			},
			{
				ID = "IsDirewolves",
				Chance = 40
			},
			{
				ID = "IsGhouls",
				Chance = 100
			}
		]
	},
	{
		Medium = "medium_steppe_village",
		Small = "small_steppe_village",
		Legends = "legends_steppe_village",
		Flags = [
			{
				ID = "IsHumans",
				Chance = 5
			},
			{
				ID = "IsDirewolves",
				Chance = 40
			},
			{
				ID = "IsGhouls",
				Chance = 100
			}
		]
	},
	{
		Medium = "medium_farming_village",
		Small = "small_farming_village",
		Legends = "legends_farming_village",
		Flags = [
			{
				ID = "IsHumans",
				Chance = 5
			},
			{
				ID = "IsDirewolves",
				Chance = 40
			},
			{
				ID = "IsGhouls",
				Chance = 100
			}
		]
	},
	{
		Medium = "medium_fishing_village",
		Small = "small_fishing_village",
		Legends = "legends_fishing_village",
		Flags = [
			{
				ID = "IsSpiders",
				Chance = 50
			},
			{
				ID = "IsGhouls",
				Chance = 100
			}
		]
	},
	{
		Medium = "medium_lumber_village",
		Small = "small_lumber_village",
		Legends = "legends_lumber_village",
		Flags = [
			{
				ID = "IsHumans",
				Chance = 5
			},
			{
				ID = "IsSpiders",
				Chance = 50
			},
			{
				ID = "IsDirewolves",
				Chance = 100
			}
		]
	},
	{
		Medium = "medium_swamp_village",
		Small = "small_swamp_village",
		Legends = "legends_swamp_village",
		Flags = [
			{
				ID = "IsGhouls",
				Chance = 25
			},
			{
				ID = "IsSpiders",
				Chance = 100
			}
		]
	},
	{
		Medium = "medium_mining_village",
		Small = "small_mining_village",
		Legends = "legends_mining_village",
		Flags = [
			{
				ID = "IsSpiders",
				Chance = 50
			},
			{
				ID = "IsGhouls",
				Chance = 100
			}
		]
	}
];


::mods_hookExactClass("factions/contracts/roaming_beasts_action", function (o)
{
    o.onUpdate = function( _faction )
	{
		if (!_faction.isReadyForContract()) return;
		if (_faction.getSettlements()[0].isIsolated() || _faction.getSettlements()[0].getSize() > 2) return;
		this.m.Score = 1;
	}
});

::mods_hookExactClass("contracts/contracts/roaming_beasts_contract", function (o)
{
	o.createStates = function()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Hunt down what terrorizes " + this.Contract.m.Home.getName()
				];
				if (::Math.rand(1, 100) <= ::Const.Contracts.Settings.IntroChance) this.Contract.setScreen("Intro");
				else this.Contract.setScreen("Task");
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = ::Math.rand(1, 100);
				local village = this.Contract.getHome().get();
				local twists = [];
				local r;

				this.logInfo("Hunting Beasts Contract: Rolling for contract type.");
				foreach (villageInfo in ::Const.Contracts.Roaming_Beasts.VillageInfo) 
				{
					if (::MSU.isKindOf( village, villageInfo.Legends) || ::MSU.isKindOf( village, villageInfo.Medium) || ::MSU.isKindOf( village, villageInfo.Small))
					{
						this.logInfo("VillageType is " + villageInfo.Medium);
						foreach (flag in villageInfo.Flags) 
						{
							local roll = ::Math.rand(1, 100);
							this.logInfo(flag.ID + ": Rolling " +  roll + " vs " + flag.Chance);
							if (roll <= flag.Chance)
							{
								this.Flags.set(flag.ID, true);
								this.logInfo("Setting ID as " + flag.ID);
								break;
							}
						}
					}
				}

				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10);
				local party;

				if (this.Flags.get("IsHumans"))
				{
					party = this.World.FactionManager.getFactionOfType(::Const.FactionType.Bandits).spawnEntity(tile, "Direwolves", false, ::Const.World.Spawn.BanditsDisguisedAsDirewolves, 100 * this.Contract.getDifficultyMult());
					party.setDescription("A pack of ferocious direwolves on the hunt for prey.");
					party.setFootprintType(::Const.World.FootprintsType.Direwolves);
					::Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), ::Const.BeastFootprints, ::Const.World.FootprintsType.Direwolves, 0.75);
				}
				else if (this.Flags.get("IsGhouls"))
				{
					party = this.World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).spawnEntity(tile, "Nachzehrers", false, ::Const.World.Spawn.Ghouls, 110 * this.Contract.getDifficultyMult());
					party.setDescription("A flock of scavenging nachzehrers.");
					party.setFootprintType(::Const.World.FootprintsType.Ghouls);
					::Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), ::Const.BeastFootprints, ::Const.World.FootprintsType.Ghouls, 0.75);
				}
				else if (this.Flags.get("IsSpiders"))
				{
					party = this.World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).spawnEntity(tile, "Webknechts", false, ::Const.World.Spawn.Spiders, 110 * this.Contract.getDifficultyMult());
					party.setDescription("A swarm of webknechts skittering about.");
					party.setFootprintType(::Const.World.FootprintsType.Spiders);
					::Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), ::Const.BeastFootprints, ::Const.World.FootprintsType.Spiders, 0.75);
				}
				else
				{
					party = this.World.FactionManager.getFactionOfType(::Const.FactionType.Beasts).spawnEntity(tile, "Direwolves", false, ::Const.World.Spawn.Direwolves, 110 * this.Contract.getDifficultyMult());
					party.setDescription("A pack of ferocious direwolves on the hunt for prey.");
					party.setFootprintType(::Const.World.FootprintsType.Direwolves);
					::Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), ::Const.BeastFootprints, ::Const.World.FootprintsType.Direwolves, 0.75);
				}

				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_beasts_01");
				local c = party.getController();
				c.getBehavior(::Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local roam = ::new("scripts/ai/world/orders/roam_order");
				roam.setPivot(this.Contract.m.Home);
				roam.setMinRange(2);
				roam.setMaxRange(8);
				roam.setAllTerrainAvailable();
				roam.setTerrain(::Const.World.TerrainType.Ocean, false);
				roam.setTerrain(::Const.World.TerrainType.Shore, false);
				roam.setTerrain(::Const.World.TerrainType.Mountains, false);
				c.addOrder(roam);
				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (this.Flags.get("IsHumans"))
					{
						this.Contract.setScreen("CollectingProof");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsGhouls"))
					{
						this.Contract.setScreen("CollectingGhouls");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsSpiders"))
					{
						this.Contract.setScreen("CollectingSpiders");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("CollectingPelts");
						this.World.Contracts.showActiveContract();
					}

					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsWorkOfBeastsShown") && this.World.getTime().IsDaytime && this.Contract.m.Target.isHiddenToPlayer() && ::Math.rand(1, 9000) <= 1)
				{
					this.Flags.set("IsWorkOfBeastsShown", true);
					this.Contract.setScreen("WorkOfBeasts");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsHumans") && !this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					local troops = this.Contract.m.Target.getTroops();

					foreach( t in troops )
					{
						t.ID = ::Const.EntityType.BanditRaider;
					}

					this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
					this.Contract.setScreen("Humans");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Return to " + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("IsHumans"))
					{
						this.Contract.setScreen("Success2");
					}
					else if (this.Flags.get("IsVermes"))
					{
						this.Contract.setScreen("Success5");
					}
					else if (this.Flags.get("IsGhouls"))
					{
						this.Contract.setScreen("Success3");
					}
					else if (this.Flags.get("IsSpiders"))
					{
						this.Contract.setScreen("Success4");
					}
					else
					{
						this.Contract.setScreen("Success1");
					}

					this.World.Contracts.showActiveContract();
				}
			}

		});
	}
});