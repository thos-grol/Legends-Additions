this.getroottable().Const.LegendMod.hookContract <- function ()
{
	::mods_hookDescendants("contracts/contract", function ( o )
	{
		local onClear = o.onClear;
		o.onClear = function ()
		{
			if (this.isActive())
			{
				local contract_faction = this.World.FactionManager.getFaction(this.getFaction());
				local towns = contract_faction.getSettlements();

				foreach( town in towns )
				{
					town.getSprite("selection").Visible = false;
				}
			}

			onClear();
		};
	});
	::mods_hookBaseClass("contracts/contract", function ( o )
	{
		while (!("EmployerID" in o.m))
		{
			o = o[o.SuperName];
		}

		o.m.Category <- "";
		o.m.Description <- "";
		o.create = function ()
		{
			local r;

			if (this.World.getTime().Days < 5)
			{
				r = this.Math.rand(1, 30);
			}
			else if (this.World.getTime().Days < 10)
			{
				r = this.Math.rand(1, 75);
			}
			else
			{
				r = this.Math.rand(1, 100);
			}

			if (r <= 30)
			{
				this.m.DifficultyMult = this.Math.rand(70, 85) * 0.01;
			}
			else if (r <= 75)
			{
				this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
			}
			else if (r <= 95)
			{
				this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
			}
			else
			{
				this.m.DifficultyMult = this.Math.rand(145, 165) * 0.01;
			}

			this.m.PaymentMult = this.Math.rand(90, 110) * 0.01;
			this.m.Flags = this.new("scripts/tools/tag_collection");
			this.m.TempFlags = this.new("scripts/tools/tag_collection");
			this.createStates();
			this.createScreens();
		};
		o.getDescription <- function ()
		{
			return this.m.Description;
		};

		o.spawnEnemyPartyAtBase = function( _factionType, _resources )
		{
			local myTile = this.World.State.getPlayer().getTile();
			local enemyBase = this.World.FactionManager.getFactionOfType(_factionType).getNearestSettlement(myTile);
			local party;

			if (_factionType == this.Const.FactionType.Bandits)
			{
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(enemyBase.getTile(), "Brigands", false, this.Const.World.Spawn.BanditRaiders, _resources);
				party.setDescription("A rough and tough band of brigands out to hunt for food.");
				party.setFootprintType(this.Const.World.FootprintsType.Brigands);
				party.getLoot().Money = this.Math.rand(0, 50);
				party.getLoot().ArmorParts = this.Math.rand(0, 10);
				party.getLoot().Medicine = this.Math.rand(0, 2);
				party.getLoot().Ammo = this.Math.rand(0, 10);
				local r = this.Math.rand(1, 6);

				if (r == 1)
				{
					party.addToInventory("supplies/bread_item");
				}
				else if (r == 2)
				{
					party.addToInventory("supplies/roots_and_berries_item");
				}
				else if (r == 3)
				{
					party.addToInventory("supplies/dried_fruits_item");
				}
				else if (r == 4)
				{
					party.addToInventory("supplies/ground_grains_item");
				}
				else if (r == 5)
				{
					party.addToInventory("supplies/pickled_mushrooms_item");
				}
			}
			else if (_factionType == this.Const.FactionType.Goblins)
			{
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).spawnEntity(enemyBase.getTile(), "Goblin Raiders", false, this.Const.World.Spawn.GoblinRaiders, _resources);
				party.setDescription("A band of mischievous goblins, small but cunning and not to be underestimated.");
				party.setFootprintType(this.Const.World.FootprintsType.Goblins);
				party.getLoot().ArmorParts = this.Math.rand(0, 10);
				party.getLoot().Medicine = this.Math.rand(0, 2);
				party.getLoot().Ammo = this.Math.rand(0, 15);
			}
			else if (_factionType == this.Const.FactionType.Orcs)
			{
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).spawnEntity(enemyBase.getTile(), "Orc Marauders", false, this.Const.World.Spawn.OrcRaiders, _resources);
				party.setDescription("A band of menacing orcs, greenskinned and towering any man.");
				party.setFootprintType(this.Const.World.FootprintsType.Orcs);
				party.addToInventory("supplies/strange_meat_item");
			}
			else if (_factionType == this.Const.FactionType.Undead)
			{
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).spawnEntity(enemyBase.getTile(), "Undead", false, this.Const.World.Spawn.UndeadArmy, _resources);
				party.setDescription("A legion of walking dead, back to claim from the living what was once theirs.");
				party.setFootprintType(this.Const.World.FootprintsType.Undead);
			}
			else if (_factionType == this.Const.FactionType.Zombies)
			{
				party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).spawnEntity(enemyBase.getTile(), "Undead", false, this.Const.World.Spawn.Necromancer, _resources);
				party.setDescription("Something seems wrong.");
				party.setFootprintType(this.Const.World.FootprintsType.Undead);
			}

			party.getSprite("banner").setBrush(enemyBase.getBanner());
			this.m.UnitsSpawned.push(party.getID());
			return party;
		}

		local onDeserialize = o.onDeserialize;
		o.onDeserialize = function ( _in )
		{
			onDeserialize(_in);

			if (this.m.Flags.get("UpdatedBulletpoints"))
			{
				local contract_faction = this.World.FactionManager.getFaction(this.getFaction());
				local towns = contract_faction.getSettlements();
				this.m.BulletpointsObjectives.pop();

				if (this.m.Type == "contract.big_game_hunt")
				{
					this.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName() + " to get paid");
				}
				else
				{
					this.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName());
				}

				foreach( town in towns )
				{
					town.getSprite("selection").Visible = true;
				}

				this.World.State.getWorldScreen().updateContract(this);
			}
		};
		local getOnCompletion = o.m.Payment.getOnCompletion;
		o.m.Payment.getOnCompletion = function ()
		{
			local val = getOnCompletion();
			return this.Math.max(this.Const.Difficulty.MinPayments[this.World.Assets.getEconomicDifficulty()], val);
		};
		local getPerCount = o.m.Payment.getPerCount;
		o.m.Payment.getPerCount = function ()
		{
			local val = getPerCount();
			return this.Math.max(this.Const.Difficulty.MinHeadPayments[this.World.Assets.getEconomicDifficulty()], val);
		};
		o.getScaledDifficultyMult = function ()
		{
			local s = this.Math.maxf(0.75, 0.94 * this.Math.pow(0.01 * this.World.State.getPlayer().getStrength(), 0.89));
			local d = this.Math.minf(5.0, s);
			return d * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
		};
		o.getPaymentMult = function ()
		{
			local repDiffMult = this.Math.pow(this.getScaledDifficultyMult(), 0.5);
			local broMult = this.World.State.getPlayer().getBarterMult();
			return (this.m.PaymentMult + broMult) * (this.m.DifficultyMult * repDiffMult) * this.World.Assets.m.ContractPaymentMult;
		};
		o.addUnitsToEntity = function ( _entity, _partyList, _resources )
		{
			local p;

			if (typeof _partyList == "table")
			{
				p = this.Const.World.Common.buildDynamicTroopList(_partyList, _resources);
			}
			else
			{
				local total_weight = 0;
				local potential = [];

				foreach( party in _partyList )
				{
					if (party.Cost < _resources * 0.7)
					{
						continue;
					}

					if (party.Cost > _resources)
					{
						break;
					}

					potential.push(party);
					total_weight = total_weight + party.Cost;
				}

				if (potential.len() == 0)
				{
					local best;
					local bestCost = 9000;

					foreach( party in _partyList )
					{
						if (this.Math.abs(_resources - party.Cost) <= bestCost)
						{
							best = party;
							bestCost = this.Math.abs(_resources - party.Cost);
						}
					}

					p = best;
				}
				else
				{
					local pick = this.Math.rand(1, total_weight);

					foreach( party in potential )
					{
						if (pick <= party.Cost)
						{
							p = party;
							break;
						}

						pick = pick - party.Cost;
					}
				}
			}

			local troopMbMap = {};

			foreach( t in p.Troops )
			{
				local key = "Enemy" + t.Type.ID;

				if (!(key in troopMbMap))
				{
					troopMbMap[key] <- this.Const.LegendMod.GetFavEnemyBossChance(t.Type.ID);
				}

				local mb = troopMbMap[key];

				if (this.getDifficultyMult() >= 1.45)
				{
					mb = mb + 15;
				}
				else if (this.getDifficultyMult() >= 1.15)
				{
					mb = mb + 5;
				}
				else if (this.getDifficultyMult() >= 0.85)
				{
					mb = mb + 0;
				}
				else
				{
					mb = mb + -99;
				}

				for( local i = 0; i != t.Num; i = i )
				{
					this.Const.World.Common.addTroop(_entity, t, false, mb);
					i = ++i;
				}
			}

			if (_entity.isLocation())
			{
				_entity.resetDefenderSpawnDay();
			}

			_entity.updateStrength();
		};
		o.getUIMiddleOverlay = function ()
		{
			if (("ShowDifficulty" in this.m.ActiveScreen) && this.m.ActiveScreen.ShowDifficulty)
			{
				switch(this.getDifficulty())
				{
					case "F":
						return {
							Image = "ui/images/difficulty_F.png",
							IsProcedural = false
						};

					case "E":
						return {
							Image = "ui/images/difficulty_E.png",
							IsProcedural = false
						};

					case "D":
						return {
							Image = "ui/images/difficulty_D.png",
							IsProcedural = false
						};

					case "C":
						return {
							Image = "ui/images/difficulty_C.png",
							IsProcedural = false
						};

					case "B":
						return {
							Image = "ui/images/difficulty_B.png",
							IsProcedural = false
						};

					case "A":
						return {
							Image = "ui/images/difficulty_A.png",
							IsProcedural = false
						};

					case "S":
						return {
							Image = "ui/images/difficulty_S.png",
							IsProcedural = false
						};
				}

				return {
					Image = "ui/images/difficulty_C.png",
					IsProcedural = false
				};
			}
			else
			{
				return null;
			}
		};
		o.getUIDifficultySmall = function ()
		{
			switch(this.getDifficulty())
			{
				case "F":
					return "ui/icons/difficulty_F";

				case "E":
					return "ui/icons/difficulty_E";

				case "D":
					return "ui/icons/difficulty_D";

				case "C":
					return "ui/icons/difficulty_C";

				case "B":
					return "ui/icons/difficulty_B";

				case "A":
					return "ui/icons/difficulty_A";

				case "S":
					return "ui/icons/difficulty_S";

			}

			return "ui/icons/difficulty_C";
		};
		o.getDifficulty <- function ()
		{
			if (!this.m.Flags.has("Rating")) return "D";
			return this.m.Flags.get("Rating");
		};
		o.resolveSituation = function ( _situationInstance, _settlement, _list = null )
		{
			if (_situationInstance == 0 || _settlement == null || typeof _settlement == "instance" && _settlement.isNull())
			{
				return 0;
			}

			local s = _settlement.getSituationByInstance(_situationInstance);
			local ret = _situationInstance;

			if (s != null)
			{
				if (::Legends.Mod.ModSettings.getSetting("WorldEconomy").getValue())
				{
					ret = _settlement.resolveSituationByInstance(_situationInstance);
				}
				else
				{
					ret = _settlement.removeSituationByInstance(_situationInstance);
				}
			}

			if (_list != null && s != null && !_settlement.hasSituation(s.getID()))
			{
				_list.push({
					id = 10,
					icon = s.getIcon(),
					text = s.getRemovedString(_settlement.getName())
				});
			}

			return ret;
		};
		o.buildText <- function ( _text )
		{
			local brothers = this.World.getPlayerRoster().getAll();
			local brother1 = this.Math.rand(0, brothers.len() - 1);
			local brother2 = this.Math.rand(0, brothers.len() - 1);

			if (brothers.len() >= 2)
			{
				while (brother1 == brother2)
				{
					brother2 = this.Math.rand(0, brothers.len() - 1);
				}
			}

			if (brothers.len() < 2)
			{
				brother1 = "unknown";
				brother2 = "unknown";
			}
			else
			{
				brother1 = brothers[brother1].getName();
				brother2 = brothers[brother2].getName();
			}

			local villages = this.World.EntityManager.getSettlements();
			local randomTown;

			do
			{
				randomTown = villages[this.Math.rand(0, villages.len() - 1)].getNameOnly();
			}
			while (randomTown == null || randomTown == this.m.Home.getNameOnly());

			local text;
			local vars = [
				[
					"SPEECH_ON",
					"\n\n[color=#bcad8c]\""
				],
				[
					"SPEECH_START",
					"[color=#bcad8c]\""
				],
				[
					"SPEECH_OFF",
					"\"[/color]\n\n"
				],
				[
					"companyname",
					this.World.Assets.getName()
				],
				[
					"randomname",
					this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
				],
				[
					"randomnoble",
					this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
				],
				[
					"randombrother",
					brother1
				],
				[
					"randombrother2",
					brother2
				],
				[
					"randomtown",
					randomTown
				],
				[
					"reward_completion",
					this.m.Payment.getOnCompletion()
				],
				[
					"reward_advance",
					this.m.Payment.getInAdvance()
				],
				[
					"reward_count",
					this.m.Payment.getPerCount()
				],
				[
					"employer",
					this.m.EmployerID != 0 ? this.Tactical.getEntityByID(this.m.EmployerID).getName() : ""
				],
				[
					"faction",
					this.World.FactionManager.getFaction(this.m.Faction).getName()
				],
				[
					"townname",
					this.m.Home.getName()
				],
				[
					"produce",
					this.m.Home.getProduceAsString()
				],
				[
					"origin",
					this.m.Origin.getName()
				],
				[
					"maxcount",
					this.m.Payment.MaxCount
				]
			];
			this.onPrepareVariables(vars);
			vars.push([
				"reward",
				this.m.Payment.getOnCompletion() + this.m.Payment.getInAdvance()
			]);
			return this.buildTextFromTemplate(_text, vars);
		};
		o.getUICategoryIcon <- function ()
		{
			local c = this.getCategory();
			return c == "" ? "" : this.Const.Contracts.ContractCategoryIconMap[c];
		};
		o.getCategory <- function ()
		{
			if (this.getFaction() > 0 && this.World.FactionManager.getFaction(this.getFaction()).getType() == this.Const.FactionType.Settlement && (this.m.Category == "" || this.m.Category == null))
			{
				::Legends.Mod.Debug.printWarning("Contract Overhaul: Missing Category for settlement contract: " + this.getName(), ::Const.LegendMod.Debug.Flags.ContractCategories);
			}

			return this.m.Category;
		};
		o.setCategory <- function ( _c )
		{
			this.m.Category = _c;
		};
	});
	delete this.Const.LegendMod.hookContract;
};

