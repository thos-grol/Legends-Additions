//Background Prices
::mods_hookExactClass("entity/tactical/player", function(o)
{
	o.getTryoutCost = function()
	{
		return this.Math.max(0, this.Math.ceil(this.m.CurrentProperties.DailyWage));
	}
});

::mods_hookExactClass("skills/backgrounds/character_background", function(o)
{
	o.adjustHiringCostBasedOnEquipment = function()
	{
		local actor = this.getContainer().getActor();
		local items = actor.getItems().getAllItems();
		local id = actor.getBackground().getID();
		
		if (actor.m.HiringCost == 0 && id in ::Z.Backgrounds.Wages) 
			actor.m.HiringCost = ::Z.Backgrounds.Wages[id].HiringCost;
		
		foreach(i in items)
		{
			actor.m.HiringCost += this.Math.ceil(i.getValue() * 0.75);
		}
	}

	// //Wage hike upon reaching level 11
	// function onUpdate( _properties )
	// {
	// 	if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getID() != "background.slave") _properties.XPGainMult *= 0.9;

	// 	if (this.m.DailyCost == 0 || this.getContainer().hasSkill("trait.player")) _properties.DailyWage = 0;
	// 	else
	// 	{
	// 		if (this.getContainer().getActor().getLevel() >= 11 && this.m.DailyCost < 12) this.m.DailyCost = 12;
	// 		if (this.isBackgroundType(this.Const.BackgroundType.ConvertedCultist)) this.m.DailyCost = 4;
	// 		_properties.DailyWage += this.Math.round(this.m.DailyCost * this.m.DailyCostMult);
	// 	}
	// }
});

//Item prices
::mods_hookDescendants("items/item", function (o)
{
    local create = o.create;
	o.create = function()
	{
		create();
		if (this.m.ID in ::Z.Economy.Items)
            this.m.Value = ::Z.Economy.Items[this.m.ID];
	}

	//Overwriting legend's mod buyback
	o.getSellPrice <- function ()
	{
		local originalTime;
		local sellPrice;

		if (::mods_isClass(this, "legend_usable_food") && this.getSpoilInDays() > this.m.GoodForDays)
		{
			originalTime = this.m.BestBefore;
			this.m.BestBefore = 0;
		}
		if (originalTime != null) this.m.BestBefore = originalTime;

		if (this.isBought())
		{
			this.m.IsBought = false;
			sellPrice = this.getBuyPrice();
			this.m.IsBought = true;
			return sellPrice;
		}
		
		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local mult = this.getSellPriceMult() * this.Const.World.Assets.BaseSellPrice * this.World.State.getCurrentTown().getSellPriceMult();
			local mult_old = mult;
			mult = this.Math.minf(this.Math.maxf(mult, 0.5), 1.25); //sell price can't be lower than 50% or higher than 125%

			// ::logInfo(this.m.ID);
			// ::logInfo("item.getSellPriceMult() = " + this.getSellPriceMult());
			// ::logInfo("this.Const.World.Assets.BaseSellPrice = " + this.Const.World.Assets.BaseSellPrice);
			// ::logInfo("settlement.getSellPriceMult() = " + this.World.State.getCurrentTown().getSellPriceMult());
			// ::logInfo("mult = " + mult_old);
			// ::logInfo("after this.Math.min(this.Math.max(mult, 0.5), 1.25) = " + mult);

			return this.Math.floor(this.getValue() * mult);
		}
		
		return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice);
	};

	o.getBuyPrice <- function ()
	{
		if (this.isSold())
		{
			this.m.IsSold = false;
			local sellPrice = this.getSellPrice();
			this.m.IsSold = true;
			return sellPrice;
		}

		local originalTime;
		if (::mods_isClass(this, "legend_usable_food") && this.getSpoilInDays() > this.m.GoodForDays)
		{
			if (this.getSpoilInDays() > this.m.GoodForDays)
			{
				originalTime = this.m.BestBefore;
				this.m.BestBefore = 0;
			}
		}
		if (originalTime != null) this.m.BestBefore = originalTime;

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local mult = this.getBuyPriceMult() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult();
			local mult_old = mult;
			mult = this.Math.maxf(0.75, mult);

			// ::logInfo(this.m.ID);
			// ::logInfo("item.getBuyPriceMult() = " + this.getBuyPriceMult());
			// ::logInfo("item.getPriceMult() = " + this.getPriceMult());
			// ::logInfo("settlement.getBuyPriceMult() = " + this.World.State.getCurrentTown().getBuyPriceMult());
			// ::logInfo("mult = " + mult_old);
			// ::logInfo("after this.Math.max(0.75, mult) = " + mult);

			return this.Math.ceil(this.getValue() *  mult); //buy price can't be lower than 75%
		}
		
		return this.Math.ceil(this.getValue() * this.getPriceMult());
	};
});

::mods_hookExactClass("entity/world/settlement", function(o)
{
    o.getPriceMult = function()
	{
		local p;
        switch(this.m.Size)
		{
            case 2:
                p = 1.02 + this.getActiveAttachedLocations().len() * 0.03;
                break;
            case 3:
                p = 1.1 + this.getActiveAttachedLocations().len() * 0.03;
                break;
            default:
                p = 0.95 + this.getActiveAttachedLocations().len() * 0.03;
                break;
		}
		return p * this.m.Modifiers.PriceMult;
	}

    
    o.getBuyPriceMult = function()
    {
        local p = this.getPriceMult() * this.World.Assets.getBuyPriceMult();
		local r = this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation();

		if (r < 50) p = p + (50.0 - r) * 0.006;
		else if (r > 50) p = p - (r - 50.0) * 0.003;

		local barterMult = this.World.State.getPlayer().getBarterMult();
		if (this.m.Modifiers.BuyPriceMult - barterMult >= 0.01) p = p * (this.m.Modifiers.BuyPriceMult - barterMult);
		return p;
    }

    o.getSellPriceMult = function()
    {
        local p = this.getPriceMult() * this.World.Assets.getSellPriceMult();
		local r = this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation();

		if (r < 50) p = p - (50.0 - r) * 0.006;
		else if (r > 50) p = p + (r - 50.0) * 0.003;

		return p * (this.m.Modifiers.SellPriceMult + this.World.State.getPlayer().getBarterMult());
    }

	o.updateShop = function( _force = false )
	{
		local daysPassed = (this.Time.getVirtualTimeF() - this.m.LastShopUpdate) / this.World.getTime().SecondsPerDay;

		if (!_force && this.m.LastShopUpdate != 0 && daysPassed < 3)
		{
			this.updateImportedProduce();
			this.removeZeroCostItems();
			return;
		}

		if (this.m.ShopSeed != 0) this.Math.seedRandom(this.m.ShopSeed);
		this.m.ShopSeed = this.Math.floor(this.Time.getRealTime() + this.Math.rand());
		this.m.LastShopUpdate = this.Time.getVirtualTimeF();

		foreach( building in this.m.Buildings )
		{
			if (building != null)
			{
				building.onUpdateShopList();

				if (building.getStash() != null)
				{
					foreach( s in this.m.Situations )
					{
						s.onUpdateShop(building.getStash());
					}
				}
			}
		}

		this.updateImportedProduce();
		this.removeZeroCostItems();
	}

	o.removeZeroCostItems <- function()
	{
		foreach( building in this.m.Buildings )
		{
			if (building == null) continue;
			local stash = building.getStash();
			if (stash == null) continue;
			local items = stash.getItems();
			if (items == null) continue;

			for( local i = items.len() - 1; i >= 0; i -= 1 )
			{
				local item = items[i];
				if (item == null) continue;

				local id = item.m.ID;
				if (id in ::Z.Economy.Items && ::Z.Economy.Items[id] == 0)
					stash.removeByIndex(i);
			}
		}

	}
});

//Caravan Budgets
::Const.World.Common.WorldEconomy.setupTrade = function ( _party, _settlement, _destination, _fixedBudget = -1, _minBudget = -1, _maxBudget = -1 )
{
	local budget = _fixedBudget != -1 ? _fixedBudget : this.calculateTradingBudget(_settlement, _minBudget, _maxBudget);
	budget = ::Math.round(budget / 10);
	local result = this.makeTradingDecision(_settlement, budget);
	local finance = this.getExpectedFinancialReport(_settlement);
	_settlement.addResources(-finance.Investment);
	_party.setOrigin(_settlement);
	_party.getStashInventory().assign(result.Items);
	_party.getFlags().set("CaravanProfit", finance.Profit);
	_party.getFlags().set("CaravanInvestment", finance.Investment);
	this.logWarning("Exporting " + _party.getStashInventory().getItems().len() + " items (" + result.Value + " crowns), focusinng on trading \'" + result.Decision + "\', investing " + finance.Investment + " resources," + " from " + _settlement.getName() + " via a caravan bound for " + _destination.getName() + " town");
}