this.arena_tournament_contract <- this.inherit("scripts/contracts/contract", {
	m = {},
	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = 1.3;
		this.m.Type = "contract.arena_tournament";
		this.m.Name = "The Arena Tournament";
		this.m.Description = "Fight in today\'s Arena Tournament. Emerge victorious and receive a famed item.";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 1.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		local item;
		local idx = this.Math.rand(1, 3);

		if (idx == 1)
		{
			local items = clone this.Const.Items.NamedWeapons;
			item = this.new("scripts/items/" + items[this.Math.rand(0, items.len() - 1)]);
		}
		else if (idx == 2)
		{
			item = this.Const.World.Common.pickHelmet(this.Const.World.Common.convNameToList(this.Const.Items.NamedHelmets));
		}
		else if (idx == 3)
		{
			item = this.Const.World.Common.pickArmor(this.Const.World.Common.convNameToList(this.Const.Items.NamedArmors));
		}

		local cnh;

		if (idx == 1)
		{
			this.m.Flags.set("PrizeName", item.createRandomName());
			cnh = item.ClassNameHash;
		}
		else
		{
			local nameList = [];

			if ((item.m.ItemType & this.Const.Items.ItemType.Named) != 0)
			{
				nameList.push(item);
			}

			foreach( i in item.getUpgrades() )
			{
				if (i != 1)
				{
					continue;
				}

				local u = item.getUpgrade(i);

				if (u != null && u.isItemType(this.Const.Items.ItemType.Named))
				{
					nameList.push(u);
				}
			}

			local idx = this.Math.rand(0, nameList.len() - 1);
			local item = nameList[idx];
			this.m.Flags.set("PrizeName", item.getName());
			cnh = item.ClassNameHash;
		}

		this.m.Flags.set("PrizeScript", cnh);

		if (item.isItemType(this.Const.Items.ItemType.Weapon))
		{
			this.m.Flags.set("PrizeType", "weapon");
		}
		else if (item.isItemType(this.Const.Items.ItemType.Shield))
		{
			this.m.Flags.set("PrizeType", "shield");
		}
		else if (item.isItemType(this.Const.Items.ItemType.Armor))
		{
			this.m.Flags.set("PrizeType", "armor");
		}
		else if (item.isItemType(this.Const.Items.ItemType.Helmet))
		{
			this.m.Flags.set("PrizeType", "helmet");
		}

		this.m.Flags.set("Round", 1);
		this.m.Flags.set("RewardApplied", 0);
		this.m.Flags.set("Opponents1", this.getOpponents(1).I);
		this.m.Flags.set("Opponents2", this.getOpponents(2).I);
		this.m.Flags.set("Opponents3", this.getOpponents(3).I);
		this.contract.start();
	}

	function getOpponents( _round, _index = -1 )
	{
		local twists = [];

		if (_round >= 2)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.Swordmaster.Cost); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 50 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.Swordmaster.Cost * 2); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
						i = ++i;
					}
				}

			});
		}

		if (_round >= 2)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.HedgeKnight.Cost); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 50 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d - this.Const.World.Spawn.Troops.HedgeKnight.Cost * 2); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.BanditRaider, _d - this.Const.World.Spawn.Troops.HedgeKnight.Cost - this.Const.World.Spawn.Troops.Swordmaster.Cost); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.BanditRaider);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.HedgeKnight, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.MasterArcher, true);
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost - this.Const.World.Spawn.Troops.Swordmaster.Cost); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Swordmaster, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost * 2 - this.Const.World.Spawn.Troops.Swordmaster.Cost * 2); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
						i = ++i;
					}
				}

			});
		}

		if (_round >= 2)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Executioner.Cost); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 50 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Executioner.Cost * 2); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost - this.Const.World.Spawn.Troops.Executioner.Cost); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost * 2 - this.Const.World.Spawn.Troops.Executioner.Cost * 2); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertStalker);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d - this.Const.World.Spawn.Troops.DesertDevil.Cost - this.Const.World.Spawn.Troops.Executioner.Cost - this.Const.World.Spawn.Troops.DesertStalker.Cost); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertDevil, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.DesertStalker, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Executioner, true);
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 50 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Gladiator.Cost * 2); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.World.getTime().Days > 150 && this.Const.DLC.Wildmen)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator, true);
					_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator, true);

					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d - this.Const.World.Spawn.Troops.Gladiator.Cost * 4); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
						i = ++i;
					}
				}

			});
		}

		if (_round == 2)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, _d); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Mercenary);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.Const.DLC.Unhold)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Unhold, _d); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Unhold);
						i = ++i;
					}
				}

			});
		}

		if (_round == 3 && this.Const.DLC.Lindwurm)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < this.Math.min(3, _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Lindwurm, _d)); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Lindwurm);
						i = ++i;
					}
				}

			});
		}

		if (_round == 2)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.SandGolemMEDIUM, _d); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.SandGolemMEDIUM);
						i = ++i;
					}
				}

			});
		}

		if (_round == 2)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, _d); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Gladiator);
						i = ++i;
					}
				}

			});
		}

		if (_round == 1 && this.Const.DLC.Unhold)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Spider, _d); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Spider);
						i = ++i;
					}
				}

			});
		}

		if (_round <= 2)
		{
			twists.push({
				R = 10,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, _d); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.NomadOutlaw);
						i = ++i;
					}
				}

			});
		}

		if (_round == 1)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.Serpent, _d); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.Serpent);
						i = ++i;
					}
				}

			});
		}

		if (_round == 1)
		{
			twists.push({
				R = 5,
				function F( _c, _d, _e )
				{
					for( local i = 0; i < _c.getAmountToSpawn(this.Const.World.Spawn.Troops.HyenaHIGH, _d); i = i )
					{
						_c.addToCombat(_e, this.Const.World.Spawn.Troops.HyenaHIGH);
						i = ++i;
					}
				}

			});
		}

		if ("bool" == typeof _index || _index >= 0)
		{
			return {
				I = _index,
				F = twists[_index].F
			};
		}
		else
		{
			local maxR = 0;

			foreach( t in twists )
			{
				maxR = maxR + t.R;
			}

			local r = this.Math.rand(1, maxR);

			foreach( i, t in twists )
			{
				if (r <= t.R)
				{
					return {
						I = i,
						F = t.F
					};
				}
				else
				{
					r = r - t.R;
				}
			}
		}
	}

	function startTournamentRound()
	{
		local p = this.Const.Tactical.CombatInfo.getClone();
		p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
		p.CombatID = "Arena";
		p.TerrainTemplate = "tactical.arena";
		p.LocationTemplate.Template[0] = "tactical.arena_floor";
		p.Music = this.Const.Music.ArenaTracks;
		p.Ambience[0] = this.Const.SoundAmbience.ArenaBack;
		p.Ambience[1] = this.Const.SoundAmbience.ArenaFront;
		p.AmbienceMinDelay[0] = 0;
		p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Arena;
		p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Arena;
		p.IsUsingSetPlayers = true;
		p.IsFleeingProhibited = true;
		p.IsLootingProhibited = true;
		p.IsWithoutAmbience = true;
		p.IsFogOfWarVisible = false;
		p.IsArenaMode = true;
		p.IsAutoAssigningBases = false;
		local bros = this.getBros();

		for( local i = 0; i < bros.len() && i < 5; i = i )
		{
			p.Players.push(bros[i]);
			i = ++i;
		}

		p.Entities = [];
		local baseDifficulty = 45 + 10 * this.m.Flags.get("Round");
		baseDifficulty = baseDifficulty * this.getScaledDifficultyMult();
		local opponents = this.getOpponents(this.m.Flags.get("Round"), this.m.Flags.get("Opponents" + this.m.Flags.get("Round")));
		opponents.F(this, baseDifficulty, p.Entities);

		for( local i = 0; i < p.Entities.len(); i = i )
		{
			p.Entities[i].Faction <- this.getFaction();
			i = ++i;
		}

		this.World.Contracts.startScriptedCombat(p, false, false, false);
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"Equip up to five of your men with arena collars",
					"Enter the arena again to start the first round",
					"Each round will be to the death and you won\'t be able to retreat or loot afterwards",
					"After each round you can elect to drop out for some consolation pay or start the next round right away"
				];
				this.Contract.m.BulletpointsPayment = [
					"Get a famed %prizetype% called %prizename% for winning all three rounds"
				];
				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.Flags.set("Day", this.World.getTime().Days);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Flags.get("Round") > 1 && this.Contract.getBros() == 0)
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsFailure"))
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.World.getTime().Days > this.Flags.get("Day") + 1)
				{
					this.Contract.setScreen("Failure2");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("Round") > 1)
				{
					this.Contract.setScreen("Won" + this.Flags.get("Round"));
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Arena")
				{
					this.Flags.increment("Round");
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Arena")
				{
					this.Flags.set("IsFailure", true);
				}
			}

		});
	}

	function createScreens()
	{
		this.m.Screens.push({
			ID = "Task",
			Title = "At the Arena",
			Text = "",
			Image = "",
			List = [],
			ShowDifficulty = true,
			Options = [
				{
					Text = "{We shall win the grand prize!}",
					function getResult()
					{
						return "Overview";
					}

				},
				{
					Text = "{We are not ready for this.}",
					function getResult()
					{
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						return 0;
					}

				}
			],
			function start()
			{
				this.Text = "[img]gfx/ui/events/event_155.png[/img]Dozens of men mingle about the arena\'s entrance. Some stand stoically, not wishing to give any hint of their capabilities. Others, however, boast and brag with aplomb, either sincerely confident in their martial skills or hoping their bravado masks any holes in their game.\n\n";
				this.Text += "The arena master, typically the most disinterested man you\'ve ever met to have an interesting job, is actually rather lively today. He presents you with a scroll in one hand and three fingers held up in the other.%SPEECH_ON%Three rounds! Three rounds, one after the other and each harder than the last. Win all three with the same five men to earn the grand prize of a famed %prizetype% called %prizename%! It\'sahtournamentah! You want in or not-ah?%SPEECH_OFF%";
				this.Text += "The arena master continues.%SPEECH_ON%When you\'re ready, have the men who\'ll be doing the fighting put on the arena collars we\'ll give you.%SPEECH_OFF%";
			}

		});
		this.m.Screens.push({
			ID = "Overview",
			Title = "Overview",
			Text = "This arena tournament works as follows. Do you agree to the terms?",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We enter the tournament!",
					function getResult()
					{
						for( local i = 0; i < 5; i = i )
						{
							this.World.Assets.getStash().add(this.new("scripts/items/accessory/special/arena_collar_item"));
							i = ++i;
						}

						this.Contract.setState("Running");
						return 0;
					}

				},
				{
					Text = "I\'ll have to think it over.",
					function getResult()
					{
						return 0;
					}

				}
			],
			ShowObjectives = true,
			ShowPayment = true,
			function start()
			{
				this.Contract.m.IsNegotiated = true;
			}

		});
		this.m.Screens.push({
			ID = "Start",
			Title = "At the Arena",
			Text = "[img]gfx/ui/events/event_155.png[/img]{As you wait your turn, the crowd\'s bloodlust crawls through the dark, sheets of dust falling from above, the stomps of feet thunderous. They murmur in anticipation, and roar at killings. The quiet between battles is mere moments, and this silence is snatched away as the rusted gate lurches upward, chains rankling, the crowd abuzz once more. You step out into the light and so thunderous is the noise against your heart it could surely yet spur a dead man forth... | The arena\'s crowd is shoulder to shoulder, most blathering drunk. They scream and shout, their languages a mix of local and foreign, though the appeal to their bloodlust needs little articulation beyond their maddened faces and pumping fists. Now, the %companyname%\'s men will satiate these mad fools... | Cleaners hurry about the arena. They drag away the bodies, collect what\'s worth collecting, and occasionally throw a trophy into the crowds, eliciting a moblike rendition of the arena\'s battles in the stands themselves. The %companyname% is now a part of this affair. | The arena awaits, the crowd alight, and the %companyname%\'s turn to gain glory is at hand! | The crowd booms as the %companyname%\'s men stride into its bloody pit. Despite the mindless bloodlust of the peoples, you can\'t help but feel a beat of pride in your chest, knowing that it is your company ready to put on a show. | The gate rises. Nothing is heard save the rattle of chains, the creak of pulleys, the grunts of slaves at work. When the men of the %companyname% step out of the arena\'s bowels they can hear the crunch of sand underfoot until they come to stand in the center of the pit. A strange voice screams from the tops of the stadium, some lost language beyond your knowing, but the words echo just once before the crowd erupts with cheers and roaring. Now is the time your men shall prove themselves before the watchful eye of the commoner. | The %companyname%\'s business is rarely done before the eyes of those who would prefer themselves distantly separated from such violence. But in the arena, the commoner greedily awaits death and suffering, and it growls with bloodlust as your men enter the pits, and roars as the sellswords draw their weapons and ready for battle. | The arena is shaped like the pit of some sore, its ceiling torn away by the gods, revealing the vanity, bloodlust, and savagery of man. And it is man there, yelling and screaming, and if the blood sprays hit them, they wash their faces in the gore and grin at one another as though it were a joke. They fight one another for trophies and relish in the pain of others. And it is before these peoples that the %companyname% will fight, and for them they shall entertain and entertain well. | The arena\'s crowd is a mash of classes, rich and poor, for only the Viziers separate themselves out into stations above all. Briefly unified, the peoples of %townname% have graciously come together to watch men and monsters murder one another. With pleasure, the %companyname% seeks to do its part. | Boys sitting on the shoulders of fathers, young girls throwing flowers to the gladiators, women fanning themselves, men wondering if they could do it. These are the peoples of the arena - and the rest are all drunk out of their gourd and screaming nonsense. You hope the %companyname% can contribute to at least an hour or two to entertaining this mad lot. | The crowd roars as the %companyname%\'s men step into the pit. One would be dumb to confuse excitement for desire, for as soon as the applause ends there is a smattering of empty beer mugs and rotten tomatoes and the general giggling delight of those watching the matter. You wonder if the %companyname%\'s men are really best spent here, but then think hard on the gold and glory to be won, and that at the end of the day these mongrels in the stands will go home to their shit lives, and you\'ll go home to your shit life as well, but at least your pockets will be a bit deeper.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Let\'s win us that prize!",
					function getResult()
					{
						this.Contract.startTournamentRound();
						return 0;
					}

				},
				{
					Text = "We\'re not doing this. I don\'t want to die!",
					function getResult()
					{
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnArenaCancel);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.Text += "\n\n\n\n\n\nThe following characters will enter the arena:\n\n%bro1name%\n%bro2name%\n%bro3name%\n%bro4name%\n%bro5name%";
			}

		});
		this.m.Screens.push({
			ID = "Won2",
			Title = "At the Arena",
			Text = "[img]gfx/ui/events/event_147.png[/img]{The first of the three battles is over. You\'ll have to make a careful assessment of your men and if they can continue to the next round, which will only be harder than the last. Just as you\'ll find no pride in the grave, there\'s no shame in leaving. You\'d still get some coin, but you\'d also forfeit any chance to win the grand prize.}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "We\'ll win the next round as well!",
					function getResult()
					{
						this.Contract.startTournamentRound();
						return 0;
					}

				},
				{
					Text = "Time for us to drop out of this tournament.",
					function getResult()
					{
						return "DropOut";
					}

				}
			],
			function start()
			{
				if (this.Flags.getAsInt("RewardsApplied") < 2)
				{
					this.Flags.set("RewardsApplied", 2);
					this.World.Statistics.getFlags().increment("ArenaFightsWon", 1);

					if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 10)
					{
						this.updateAchievement("Gladiator", 1, 1);
					}

					this.Contract.updateTraits(this.List);
				}

				this.Contract.m.BulletpointsObjectives = [
					"The next round will start automatically",
					"Each round will be to the death and you won\'t be able to retreat or loot afterwards",
					"After each round you can elect to drop out or start the next round right away"
				];
			}

		});
		this.m.Screens.push({
			ID = "Won3",
			Title = "At the Arena",
			Text = "[img]gfx/ui/events/event_147.png[/img]The penultimate battle is won, leaving you with the choice to drop out now or take on the final fight to win the grand prize.",
			Image = "",
			List = [],
			Options = [
				{
					Text = "On to the final round!",
					function getResult()
					{
						this.Contract.startTournamentRound();
						return 0;
					}

				},
				{
					Text = "Time for us to drop out of this tournament.",
					function getResult()
					{
						return "DropOut";
					}

				}
			],
			function start()
			{
				if (this.Flags.getAsInt("RewardsApplied") < 3)
				{
					this.Flags.set("RewardsApplied", 3);
					this.World.Statistics.getFlags().increment("ArenaFightsWon", 1);

					if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 10)
					{
						this.updateAchievement("Gladiator", 1, 1);
					}

					this.Contract.updateTraits(this.List);
				}
			}

		});
		this.m.Screens.push({
			ID = "Won4",
			Title = "At the Arena",
			Text = "[img]gfx/ui/events/event_147.png[/img]The combat is over, and the dull warbling in your ear is the roar of the crowd, overwhelming all senses in an explosion of celebratory ecstasy. You are but an avatar for the people, a totem through which they can vicariously electrify their own vanity and vacant heroism. Alongside the adoration of the mob, you are rewarded the grand prize: %prizename%!",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Victory!",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess * 2);
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Flags.set("RewardsApplied", 4);
				this.World.Statistics.getFlags().increment("ArenaFightsWon", 1);

				if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 10)
				{
					this.updateAchievement("Gladiator", 1, 1);
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new(this.IO.scriptFilenameByHash(this.Flags.get("PrizeScript")));
				item.setName(this.Flags.get("PrizeName"));
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 12,
					icon = "ui/items/" + item.getIcon(),
					text = "You gain " + item.getName()
				});
				this.Contract.updateTraits(this.List);
			}

		});
		this.m.Screens.push({
			ID = "DropOut",
			Title = "At the Arena",
			Text = "[img]gfx/ui/events/event_147.png[/img]{You decide to depart the tournament and preserve your men to fight another day. No boos or hisses are heard as this is done in the belly of the arena. It is a bureaucratic affair at best, a small exchange of monetary compensation and you are sent on your way. No grief is given, especially not from fellow gladiators who understand the point of the decision better than anyone. And the crowd? They just want blood, they\'ll never even notice which bodies carrying it are gone.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Maybe next time.",
					function getResult()
					{
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				local money = (this.Flags.get("Round") - 1) * 1000;
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "You gain [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] Crowns"
				});
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "At the Arena",
			Text = "[img]gfx/ui/events/event_147.png[/img]{The %companyname%\'s men have been defeated, either dead or, perhaps worse, badly mangled. At least the crowds are happy. In the pits, any showing, even that which ends in demise, is a good showing.}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Disaster!",
					function getResult()
					{
						local roster = this.World.getPlayerRoster().getAll();

						foreach( bro in roster )
						{
							local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

							if (item != null && item.getID() == "accessory.arena_collar")
							{
								bro.getFlags().increment("ArenaFights", 1);
							}
						}

						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Failure2",
			Title = "At the Arena",
			Text = "{[img]gfx/ui/events/event_155.png[/img]The time for your arena match has come and passed, but you didn\'t show up there. Perhaps something more important came up, or perhaps you\'ve just been hiding like cowards. Either way, your reputation will suffer because of this.",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "But...",
					function getResult()
					{
						this.Contract.getHome().removeSituationByID("situation.arena_tournament");
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Collars",
			Title = "At the Arena",
			Text = "{[img]gfx/ui/events/event_155.png[/img]The time for your arena match has come, but none of your men bear the arena collars, and so they aren\'t let in.\n\nYou should decide on who is to fight by equipping them with the arena collars that you\'ve been given, and the match will start once you enter the arena again.",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Oh, right!",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
	}

	function getBros()
	{
		local ret = [];
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && item.getID() == "accessory.arena_collar")
			{
				ret.push(bro);
			}
		}

		return ret;
	}

	function updateTraits( _list )
	{
		local roster = this.World.getPlayerRoster().getAll();
		local n = 0;

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && item.getID() == "accessory.arena_collar")
			{
				local skill;
				bro.getFlags().increment("ArenaFightsWon", 1);
				bro.getFlags().increment("ArenaFights", 1);

				if (bro.getFlags().getAsInt("ArenaFightsWon") == 1)
				{
					skill = this.new("scripts/skills/traits/arena_pit_fighter_trait");
					bro.getSkills().add(skill);
					_list.push({
						id = 10,
						icon = skill.getIcon(),
						text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
					});
				}
				else if (bro.getFlags().getAsInt("ArenaFightsWon") == 5)
				{
					bro.getSkills().removeByID("trait.pit_fighter");
					skill = this.new("scripts/skills/traits/arena_fighter_trait");
					bro.getSkills().add(skill);
					_list.push({
						id = 10,
						icon = skill.getIcon(),
						text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
					});
				}
				else if (bro.getFlags().getAsInt("ArenaFightsWon") == 12)
				{
					bro.getSkills().removeByID("trait.arena_fighter");
					skill = this.new("scripts/skills/traits/arena_veteran_trait");
					bro.getSkills().add(skill);
					_list.push({
						id = 10,
						icon = skill.getIcon(),
						text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
					});
				}
				else if (bro.getFlags().getAsInt("ArenaFightsWon") > 25 && bro.getSkills().hasSkill("trait.arena_veteran"))
				{
					bro.getSkills().removeByID("trait.arena_veteran");

					if (bro.getFlags().getAsInt("ArenaFightsWon") < 50)
					{
						skill = this.new("scripts/skills/traits/arena_champion_trait");
					}
					else
					{
						skill = this.new("scripts/skills/traits/arena_invictus_trait");
					}

					bro.getSkills().add(skill);
					_list.push({
						id = 10,
						icon = skill.getIcon(),
						text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
					});
				}
				else if (bro.getFlags().getAsInt("ArenaFightsWon") == 25)
				{
					bro.getSkills().removeByID("trait.arena_veteran");
					skill = this.new("scripts/skills/traits/arena_champion_trait");
					bro.getSkills().add(skill);
					_list.push({
						id = 10,
						icon = skill.getIcon(),
						text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
					});
				}
				else if (bro.getFlags().getAsInt("ArenaFightsWon") == 50)
				{
					bro.getSkills().removeByID("trait.arena_champion");
					skill = this.new("scripts/skills/traits/arena_invictus_trait");
					bro.getSkills().add(skill);
					_list.push({
						id = 10,
						icon = skill.getIcon(),
						text = bro.getName() + " is now " + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
					});
				}

				n = ++n;
				n = n;
			}

			if (n >= 5)
			{
				break;
			}
		}
	}

	function getAmountToSpawn( _type, _resources, _min = 1, _max = 24 )
	{
		return this.Math.min(_max, this.Math.max(_min, _resources / _type.Cost));
	}

	function addToCombat( _list, _entityType, _champion = false )
	{
		local c = clone _entityType;

		if (c.Variant != 0 && _champion)
		{
			c.Variant = 1;
		}
		else
		{
			c.Variant = 0;
		}

		if (c.Variant != 0 && "NameList" in _entityType)
		{
			c.Name <- this.Const.World.Common.generateName(_entityType.NameList) + (_entityType.TitleList != null ? " " + _entityType.TitleList[this.Math.rand(0, _entityType.TitleList.len() - 1)] : "");
		}

		_list.push(c);
	}

	function getScaledDifficultyMult()
	{
		local p = this.World.State.getPlayer().getStrength();
		p = p / this.World.getPlayerRoster().getSize();
		p = p * 12;
		local s = this.Math.maxf(0.75, 1.0 * this.Math.pow(0.01 * p, 0.95) + this.Math.minf(0.5, this.World.getTime().Days * 0.005));
		local d = this.Math.minf(5.0, s);
		return d * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}

	function setScreenForArena()
	{
		if (!this.m.IsActive)
		{
			return;
		}

		if (this.getBros().len() == 0)
		{
			this.setScreen("Collars");
		}
		else if (this.World.getTime().Days > this.m.Flags.get("Day") + 1)
		{
			this.setScreen("Failure2");
		}
		else
		{
			this.setScreen("Start");
		}
	}

	function prepareBroVariables( _maxNumBros, _vars )
	{
		local currentBro = 1;

		foreach( bro in this.World.getPlayerRoster().getAll() )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && item.getID() == "accessory.arena_collar")
			{
				_vars.push([
					"bro" + currentBro++ + "name",
					" - " + bro.getName()
				]);
			}
		}

		for( local i = currentBro; i <= _maxNumBros; i = ++i )
		{
			_vars.push([
				"bro" + i + "name",
				""
			]);
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"prizename",
			this.m.Flags.get("PrizeName")
		]);
		_vars.push([
			"prizetype",
			this.m.Flags.get("PrizeType")
		]);
		this.prepareBroVariables(5, _vars);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.m.Home.getSprite("selection").Visible = false;
			this.m.Home.getBuilding("building.arena").refreshCooldown();
			local roster = this.World.getPlayerRoster().getAll();

			foreach( bro in roster )
			{
				local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

				if (item != null && item.getID() == "accessory.arena_collar")
				{
					bro.getItems().unequip(item);
				}
			}

			local items = this.World.Assets.getStash().getItems();

			foreach( i, item in items )
			{
				if (item != null && item.getID() == "accessory.arena_collar")
				{
					items[i] = null;
				}
			}
		}

		this.m.Home.removeSituationByID("situation.arena_tournament");
	}

	function isValid()
	{
		return this.Const.DLC.Desert;
	}

	function onSerialize( _out )
	{
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
	}

});

