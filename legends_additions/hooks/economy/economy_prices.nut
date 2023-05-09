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

::mods_hookExactClass("items/item", function(o)
{
    o.getBuyPrice = function()
	{
		if (this.isSold()) return this.getSellPrice();

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.max(this.getSellPrice(), this.Math.ceil(this.getValue() * this.getBuyPriceMult() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult() ));
		}
		else return this.Math.ceil(this.getValue() * this.getPriceMult());
	}

	o.getSellPrice = function()
	{
		if (this.isBought()) return this.getBuyPrice();

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return this.Math.floor(this.getValue() * this.getSellPriceMult() * this.Const.World.Assets.BaseSellPrice * this.World.State.getCurrentTown().getSellPriceMult());
		}
		else return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice);
	}
});


//TODO: log price mults and come up with more sane buy sell price formula and figure out why wages are getting fucked up
::mods_hookExactClass("entity/world/settlement", function(o)
{
    o.getPriceMult = function()
	{
		local p;

		if (this.m.Size <= 1)
		{
			p = 0.95 + this.getActiveAttachedLocations().len() * 0.03;
		}
		else if (this.m.Size == 2)
		{
			p = 1.02 + this.getActiveAttachedLocations().len() * 0.03;
		}
		else if (this.m.Size == 3)
		{
			p = 1.1 + this.getActiveAttachedLocations().len() * 0.03;
		}

		return p * this.m.Modifiers.PriceMult;
	}

    //TODO: having workshop in town decreases item prices for that type 
    o.getBuyPriceMult = function()
    {
        local p = this.getPriceMult() * this.World.Assets.getBuyPriceMult();
        local r = this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation();
        ::logInfo("Calculating getBuyPriceMult");
        ::logInfo("p= " + this.getPriceMult() + " * " + this.World.Assets.getBuyPriceMult() + " = " + p);
        ::logInfo("r= " + r);

        if (r < 50)
        {
            local p_old = p;
            p = p + (50.0 - r) * 0.006;
            ::logInfo("p = " + p_old + " + (50.0 - " + r + ") * 0.006 = " + p);
        }
        else if (r > 50)
        {
            local p_old = p;
            p = p - (r - 50.0) * 0.003;
            ::logInfo("p = " + p_old + " - (" + r + " - 50) * 0.003 = " + p);
            
        }

        local p_old = p;
        p = p * this.m.Modifiers.BuyPriceMult;
        ::logInfo("p = " + p_old + " * " + this.m.Modifiers.BuyPriceMult + " = " + p);
        p = this.Math.max(p, 0.75);
        return p;
    }

    o.getSellPriceMult = function()
    {
        local p = this.getPriceMult() * this.World.Assets.getSellPriceMult();
        local r = this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation();

        ::logInfo("Calculating getSellPriceMult");
        ::logInfo("p= " + this.getPriceMult() + " * " + this.World.Assets.getSellPriceMult() + " = " + p);
        ::logInfo("r= " + r);

        if (r < 50)
        {
            local p_old = p;
            p = p - (50.0 - r) * 0.006;
            ::logInfo("p = " + p_old + " - (50.0 - " + r + ") * 0.006 = " + p);
        }
        else if (r > 50)
        {
            p = p + (r - 50.0) * 0.003;
            ::logInfo("p = " + p_old + " + (" + r + " - 50) * 0.003 = " + p);
        }

        local p_old = p;
        p = p * this.m.Modifiers.SellPriceMult;
        ::logInfo("p = " + p_old + " * " + this.m.Modifiers.SellPriceMult + " = " + p);
        p = this.Math.max(this.Math.min(p, 0.5), 1.25);
        return p;
    }
});