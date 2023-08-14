::mods_hookExactClass("states/world/asset_manager", function(o)
{ 
    local create = o.create; 
    o.update = function( _worldState ) 
    {
		if (this.World.getTime().Days > this.m.LastDayPaid && this.World.getTime().Hours > 8 && this.m.IsConsumingAssets)
		{
			this.m.LastDayPaid = this.World.getTime().Days;

			if (this.m.BusinessReputation > 0) this.m.BusinessReputation = this.Math.max(0, this.m.BusinessReputation + this.Const.World.Assets.ReputationDaily);
			
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

			foreach( bro in roster )
			{
				bro.getSkills().onNewDay();
				bro.updateInjuryVisuals();

				if (this.World.Assets.getOrigin().getID() == "scenario.legends_troupe")
				{
					this.addMoney(10);
				}

				if (bro.getDailyCost() > 0 && this.m.Money < bro.getDailyCost())
				{
					if (bro.getSkills().hasSkill("trait.greedy"))
					{
						bro.worsenMood(this.Const.MoodChange.NotPaidGreedy, "Did not get paid");
					}
					else
					{
						bro.worsenMood(this.Const.MoodChange.NotPaid, "Did not get paid");
					}
				}

				if (this.m.IsUsingProvisions && this.m.Food < bro.getDailyFood())
				{
					if (bro.getSkills().hasSkill("trait.spartan"))
					{
						bro.worsenMood(this.Const.MoodChange.NotEatenSpartan, "Went hungry");
					}
					else if (bro.getSkills().hasSkill("trait.gluttonous"))
					{
						bro.worsenMood(this.Const.MoodChange.NotEatenGluttonous, "Went hungry");
					}
					else
					{
						bro.worsenMood(this.Const.MoodChange.NotEaten, "Went hungry");
					}
				}

				if (this.m.Origin.getID() == "scenario.manhunters" && slaves <= nonSlaves)
				{
					if (bro.getBackground().getID() != "background.slave")
					{
						bro.worsenMood(this.Const.MoodChange.TooFewSlaves, "Too few indebted in the company");
					}
				}

				this.m.Money -= bro.getDailyCost();
				mood = mood + bro.getMoodState();
			}

			this.Sound.play(this.Const.Sound.MoneyTransaction[this.Math.rand(0, this.Const.Sound.MoneyTransaction.len() - 1)], this.Const.Sound.Volume.Inventory);
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
			this.consumeFood();
			local roster = this.World.getPlayerRoster().getAll();
			local campMultiplier = this.isCamping() ? this.m.CampingMult : 1.0;

			foreach( bro in roster )
			{
				local d = bro.getHitpointsMax() - bro.getHitpoints();

				if (bro.getHitpoints() < bro.getHitpointsMax())
				{
					if (bro.getFlags().has("undead"))
					{
						bro.setHitpoints(this.Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + this.Const.World.Assets.HitpointsPerHour / 10 * this.Const.Difficulty.HealMult[this.World.Assets.getEconomicDifficulty()] * this.m.HitpointsPerHourMult));
					}
					else
					{
						bro.setHitpoints(this.Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + this.Const.World.Assets.HitpointsPerHour * this.Const.Difficulty.HealMult[this.World.Assets.getEconomicDifficulty()] * this.m.HitpointsPerHourMult));
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
						local d = this.Math.ceil(this.Math.minf(this.Const.World.Assets.ArmorPerHour * this.Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult, item.getRepairMax() - item.getRepair()));
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
			local stashmaxrepairpotential = this.Math.ceil(roster.len() * this.Const.Difficulty.RepairMult[this.World.Assets.getEconomicDifficulty()] * this.m.RepairSpeedMult * this.Const.World.Assets.ArmorPerHour);

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

					if (town != null && bro.getMoodState() <= this.Const.MoodState.Neutral)
					{
						bro.improveMood(this.Const.MoodChange.NearCity, "Has enjoyed the visit to " + town.getName());
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

		if (activeContract && this.World.FactionManager.getFaction(activeContract.getFaction()).m.Type == this.Const.FactionType.NobleHouse && excluded_contracts.find(activeContract.m.Type) == null && (activeContract.getActiveState().ID == "Return" || activeContract.m.Type == "contract.big_game_hunt" && activeContract.getActiveState().Flags.get("HeadsCollected") != 0))
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
});