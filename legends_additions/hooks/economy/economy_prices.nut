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

::mods_hookExactClass("items/item", function(o)
{
    o.getBuyPrice = function()
	{
		if (this.isSold()) return this.getSellPrice();

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
            return this.Math.ceil(this.getValue() * this.Math.max(this.getBuyPriceMult() * this.getPriceMult() * this.World.State.getCurrentTown().getBuyPriceMult(), 0.75) ); //buy price can't be lower than 75%
		}
		else return this.Math.ceil(this.getValue() * this.getPriceMult());
        //FIXME: having workshop in town decreases item prices for that type
	}

	o.getSellPrice = function()
	{
		if (this.isBought()) return this.getBuyPrice();

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local mult = this.getSellPriceMult() * this.Const.World.Assets.BaseSellPrice * this.World.State.getCurrentTown().getSellPriceMult();
            mult = this.Math.min(this.Math.max(mult, 0.5), 1.25); //sell price can't be lower than 50% or higher than 125%
            return this.Math.floor(this.getValue() * mult);
		}
		else return this.Math.floor(this.getValue() * this.Const.World.Assets.BaseSellPrice);
	}
});