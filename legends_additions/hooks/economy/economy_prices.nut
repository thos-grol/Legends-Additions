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
});

//Legend's mod has a buyback mod that messed up my hook on item price fns. 
//I had to overwrite the mod's hook with and add in the modified code.
::mods_hookDescendants("items/item", function ( o )
{
	//FIXME: check and handle produce item prices.
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

//Background Prices
::mods_hookExactClass("skills/backgrounds/character_background", function(o)
{
	o.adjustHiringCostBasedOnEquipment = function()
	{
		local actor = this.getContainer().getActor();
		//actor.m.HiringCost = this.Math.floor(this.m.HiringCost + this.Math.pow(this.m.Level - 1, 1.5));
		//TODO: if actor reaches level 11, upgrade his cost tier by 1 or to soldier, whichever one is higher
		local items = actor.getItems().getAllItems();
		local cost = 0;

		foreach( i in items )
		{
			cost = cost + i.getValue();
		}

		actor.m.HiringCost = actor.m.HiringCost + this.Math.ceil(cost * 1.1);
	}

});

::mods_hookExactClass("entity/tactical/player", function(o)
{
	o.getTryoutCost = function()
	{
		return this.Math.max(0, this.Math.ceil(this.m.CurrentProperties.DailyWage));
	}
});