::Const.World.Assets.NewCampaignEquipment = [
	// "scripts/items/accessory/bandage_item"
],

::mods_hookExactClass("states/world/asset_manager", function(o)
{
    // local create = o.create;
    o.update = function( _worldState )
    {
		if (this.World.getTime().Days > this.m.LastDayPaid && this.World.getTime().Hours > 8 && this.m.IsConsumingAssets)
		{
			this.m.LastDayPaid = this.World.getTime().Days;

			if (this.m.BusinessReputation > 0) this.m.BusinessReputation = this.Math.max(0, this.m.BusinessReputation + ::Const.World.Assets.ReputationDaily);

			this.World.Retinue.onNewDay();

			if (this.World.Flags.get("IsGoldenGoose") == true)
			{
				this.addMoney(50);
			}

			local roster = this.World.getPlayerRoster().getAll();
			local mood = 0;
			local slaves = 0;
			local nonSlaves = 0;

			if (this.m.Origin.getID() == "scenario.manhunters")
			{
				foreach( bro in roster )
				{
					if (bro.getBackground().getID() == "background.slave")
					{
						slaves = ++slaves;
						slaves = slaves;
					}
					else
					{
						nonSlaves = ++nonSlaves;
						nonSlaves = nonSlaves;
					}
				}
			}

			local items = this.World.Assets.getStash().getItems();

			foreach( item in items )
			{
				if (item == null)
				{
					continue;
				}

				item.onNewDay();
			}

			local companyRep = this.World.Assets.getMoralReputation() / 10;

			//pay bros
			foreach( bro in roster )
			{
				bro.getSkills().onNewDay();
				bro.updateInjuryVisuals();

				if (this.World.Assets.getOrigin().getID() == "scenario.legends_troupe") this.addMoney(10);

				if (bro.getDailyCost() > 0 && this.m.Money < bro.getDailyCost())
				{
					if (bro.getSkills().hasSkill("trait.greedy")) bro.worsenMood(::Const.MoodChange.NotPaidGreedy, "Did not get paid");
					else bro.worsenMood(::Const.MoodChange.NotPaid, "Did not get paid");
				}

				if (this.m.Origin.getID() == "scenario.manhunters" && slaves <= nonSlaves)
				{
					if (bro.getBackground().getID() != "background.slave")
					{
						bro.worsenMood(::Const.MoodChange.TooFewSlaves, "Too few indebted in the company");
					}
				}

				this.m.Money -= bro.getDailyCost();
				mood = mood + bro.getMoodState();
			}

			if (this.World.Retinue.hasFollower("follower.alchemist"))
			{
				local alchemy_ammo = [];
				local alchemy_tools = [];
				local alchemy_potions = [];

				foreach( bro in this.World.getPlayerRoster().getAll() )
				{
					foreach( item in bro.getItems().getAllItems() )
					{
						if (!("m" in item)) continue;
						if ("is_alchemy_ammo" in item.m) alchemy_ammo.push(item);
						else if ("is_alchemy_tool" in item.m) alchemy_ammo.push(item);
						else if ("is_alchemy_potion" in item.m) alchemy_ammo.push(item);
					}
				}

				foreach( item in alchemy_ammo )
				{
					local cost = item.get_refill_cost();
					if (this.m.Money - cost < 0) break;
					item.refill();
					this.m.Money -= cost;
				}

				foreach( item in alchemy_tools )
				{
					local cost = item.get_refill_cost();
					if (this.m.Money - cost < 0) break;
					item.refill();
					this.m.Money -= cost;
				}

				foreach( item in alchemy_potions )
				{
					local cost = item.get_refill_cost();
					if (this.m.Money - cost < 0) break;
					item.refill();
					this.m.Money -= cost;
				}

				alchemy_ammo.clear();
				alchemy_tools.clear();
				alchemy_potions.clear();
			}

			this.Sound.play(::Const.Sound.MoneyTransaction[this.Math.rand(0, ::Const.Sound.MoneyTransaction.len() - 1)], ::Const.Sound.Volume.Inventory);
			this.m.AverageMoodState = this.Math.round(mood / roster.len());
			_worldState.updateTopbarAssets();

			if (this.m.EconomicDifficulty >= 1 && this.m.CombatDifficulty >= 1)
			{
				if (this.World.getTime().Days >= 365)
				{
					this.updateAchievement("Anniversary", 1, 1);
				}
				else if (this.World.getTime().Days >= 100)
				{
					this.updateAchievement("Campaigner", 1, 1);
				}
				else if (this.World.getTime().Days >= 10)
				{
					this.updateAchievement("Survivor", 1, 1);
				}
			}
		}

		if (this.World.getTime().Hours != this.m.LastHourUpdated && this.m.IsConsumingAssets)
		{
			this.m.LastHourUpdated = this.World.getTime().Hours;
			// this.consumeFood();
			local roster = this.World.getPlayerRoster().getAll();
			local campMultiplier = this.isCamping() ? this.m.CampingMult : 1.0;

			foreach( bro in roster )
			{
				local d = bro.getHitpointsMax() - bro.getHitpoints();

				if (bro.getHitpoints() < bro.getHitpointsMax())
				{
					if (bro.getFlags().has("undead"))
					{
						bro.setHitpoints(this.Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + ::Const.World.Assets.HitpointsPerHour / 10 * ::Const.Difficulty.HealMult[this.World.Assets.getEconomicDifficulty()] * this.m.HitpointsPerHourMult));
					}
					else
					{
						bro.setHitpoints(this.Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + ::Const.World.Assets.HitpointsPerHour * ::Const.Difficulty.HealMult[this.World.Assets.getEconomicDifficulty()] * this.m.HitpointsPerHourMult));
					}
				}
			}

			foreach( bro in roster )
			{
				local perkMod = 1.0;

				if (this.m.ArmorParts == 0)
				{
					break;
				}

				if (this.isCamping())
				{
					break;
				}

				local items = bro.getItems().getAllItems();
				local updateBro = false;
				local skills = [
					"perk.legend_tools_spares",
					"perk.legend_tools_drawers"
				];

				foreach( s in skills )
				{
					local skill = bro.getSkills().getSkillByID(s);

					if (skill != null)
					{
						perkMod = perkMod * (1 - skill.getModifier() * 0.01);
					}
				}

				foreach( item in items )
				{
					if (item.getRepair() < item.getRepairMax())
					{
						local d = this.Math.ceil(this.Math.minf(::Const.World.Assets.ArmorPerHour * ::Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult, item.getRepairMax() - item.getRepair()));
						item.onRepair(item.getRepair() + d);
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - d * this.m.ArmorPartsPerArmor * perkMod);
						updateBro = true;
					}

					if (item.getRepair() >= item.getRepairMax())
					{
						item.setToBeRepaired(false, 0);
					}

					if (this.m.ArmorParts == 0)
					{
						break;
					}

					if (updateBro)
					{
						break;
					}
				}

				if (updateBro)
				{
					bro.getSkills().update();
				}
			}

			local items = this.m.Stash.getItems();
			local stashmaxrepairpotential = this.Math.ceil(roster.len() * ::Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult * ::Const.World.Assets.ArmorPerHour);

			foreach( item in items )
			{
				if (this.isCamping())
				{
					break;
				}

				if (this.m.ArmorParts == 0)
				{
					break;
				}

				if (stashmaxrepairpotential <= 0)
				{
					break;
				}

				if (item == null)
				{
					continue;
				}

				if (item.isToBeRepaired())
				{
					if (item.getRepair() < item.getRepairMax())
					{
						local d = this.Math.ceil(this.Math.minf(stashmaxrepairpotential, item.getRepairMax() - item.getRepair()));
						item.onRepair(item.getRepair() + d);
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - d * this.m.ArmorPartsPerArmor);
						stashmaxrepairpotential = stashmaxrepairpotential - d;
					}

					if (item.getRepair() >= item.getRepairMax())
					{
						item.setToBeRepaired(false, 0);
					}
				}
			}

			if (this.World.getTime().Hours % 4 == 0)
			{
				this.checkDesertion();
				local towns = this.World.EntityManager.getSettlements();
				local playerTile = this.World.State.getPlayer().getTile();
				local town;

				foreach( t in towns )
				{
					if (t.getSize() >= 2 && !t.isMilitary() && t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
					{
						town = t;
						break;
					}
				}

				foreach( bro in roster )
				{
					bro.recoverMood();

					if (town != null && bro.getMoodState() <= ::Const.MoodState.Neutral)
					{
						bro.improveMood(::Const.MoodChange.NearCity, "Has enjoyed the visit to " + town.getName());
					}
				}
			}

			_worldState.updateTopbarAssets();
		}

		if (this.World.getTime().Days > this.m.LastDayResourcesUpdated + 7)
		{
			this.m.LastDayResourcesUpdated = this.World.getTime().Days;

			foreach( t in this.World.EntityManager.getSettlements() )
			{
				t.addNewResources();
			}
		}

		local excluded_contracts = [
			"contract.patrol",
			"contract.escort_envoy"
		];
		local activeContract = this.World.Contracts.getActiveContract();

		if (activeContract && this.World.FactionManager.getFaction(activeContract.getFaction()).m.Type == ::Const.FactionType.NobleHouse && excluded_contracts.find(activeContract.m.Type) == null && (activeContract.getActiveState().ID == "Return" || activeContract.m.Type == "contract.big_game_hunt" && activeContract.getActiveState().Flags.get("HeadsCollected") != 0))
		{
			local contract_faction = this.World.FactionManager.getFaction(activeContract.getFaction());
			local towns = contract_faction.getSettlements();

			if (!activeContract.m.Flags.get("UpdatedBulletpoints"))
			{
				activeContract.m.BulletpointsObjectives.pop();

				if (activeContract.m.Type == "contract.big_game_hunt")
				{
					activeContract.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName() + " to get paid");
				}
				else
				{
					activeContract.m.BulletpointsObjectives.push("Return to any town of " + contract_faction.getName());
				}

				activeContract.m.Flags.set("UpdatedBulletpoints", true);

				foreach( town in towns )
				{
					town.getSprite("selection").Visible = true;
				}

				this.World.State.getWorldScreen().updateContract(activeContract);
			}

			foreach( town in towns )
			{
				if (activeContract.isPlayerAt(town))
				{
					activeContract.m.Home = this.WeakTableRef(town);
					break;
				}
			}
		}
	}

	//remove powder ammo from default ammo logic
	o.refillAmmo = function()
	{
		if (this.m.Ammo == 0) return;
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local items = bro.getItems().getAllItems();

			foreach( item in items )
			{
				if ("m" in item && "is_alchemy_ammo" in item.m) continue; //alchemy ammo change

				if (item.isItemType(this.Const.Items.ItemType.Ammo) && item.getAmmo() < item.getAmmoMax())
				{
					local a = this.Math.min(this.m.Ammo, this.Math.ceil(item.getAmmoMax() - item.getAmmo()) * item.getAmmoCost());

					if (this.m.Ammo >= a)
					{
						item.setAmmo(item.getAmmo() + this.Math.ceil(a / item.getAmmoCost()));
						this.m.Ammo -= a;
					}
				}

				if (this.m.Ammo == 0)
				{
					break;
				}
			}
		}

		if (this.World.State.getCurrentTown() != null)
		{
			this.World.State.getTownScreen().updateAssets();
		}
	}

	// disable food
	o.getDailyFoodCost = function(){return 0;}
	o.consumeFood = function(){}
	o.updateFood = function ()
	{
		// 	local items = this.m.Stash.getItems();
		// 	this.m.Food = 0.0;

		// 	foreach( item in items )
		// 	{
		// 		if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
		// 		{
		// 			this.m.Food += item.getAmount();
		// 		}
		// 	}
		this.m.Food = 0.0;
	}

	/////////////

	o.setCampaignSettings = function( _settings )
	{
		this.m.CampaignID = this.Math.max(0, this.Math.rand());
		this.m.Name = this.removeFromBeginningOfText("The ", this.removeFromBeginningOfText("the ", _settings.Name));
		this.m.Banner = _settings.Banner;
		this.m.BannerID = _settings.Banner.slice(_settings.Banner.find("_") + 1).tointeger();
		this.m.CombatDifficulty = _settings.Difficulty;
		this.m.EconomicDifficulty = _settings.EconomicDifficulty;
		this.m.IsIronman = _settings.Ironman;
		this.m.IsPermanentDestruction = _settings.PermanentDestruction;
		this.m.Origin = _settings.StartingScenario;
		this.m.BusinessReputation = 0;
		this.m.SeedString = _settings.Seed;
		this.World.FactionManager.getGreaterEvil().Type = _settings.GreaterEvil;
		this.m.Stash.resize(this.Const.LegendMod.MaxResources[_settings.EconomicDifficulty].Stash);
		this.m.Money = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].Money;
		this.m.Ammo = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].Ammo;
		this.m.ArmorParts = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].ArmorParts;
		this.m.Medicine = this.Const.LegendMod.StartResources[_settings.BudgetDifficulty].Medicine;
		this.m.Stash.clear();
		this.m.Origin.onSpawnAssets();
		local bros = this.World.getPlayerRoster().getAll();

		foreach( bro in bros )
		{
			bro.getBackground().buildDescription(true);
			bro.m.XP = this.Const.LevelXP[bro.m.Level - 1];
			bro.m.Attributes = [];
			bro.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
			bro.getSkills().update();
		}

		this.updateFormation();

		foreach( item in this.Const.World.Assets.NewCampaignEquipment )
		{
			this.m.Stash.add(this.new(item));
		}

		this.updateFood();
		this.m.LastRosterSize = this.World.getPlayerRoster().getSize();
	}


});