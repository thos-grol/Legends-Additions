//Background Prices
::mods_hookExactClass("entity/tactical/player", function(o)
{
	o.getTryoutCost = function()
	{
		return 0;
	}

	o.getDailyCost = function()
	{
		if (!("State" in this.World)) return 0;

		local wageMult = this.m.CurrentProperties.DailyWageMult * (this.World.State != null ? this.World.Assets.m.DailyWageMult : 1.0) - (this.World.State != null ? this.World.State.getPlayer().getWageModifier() : 0.0);
		
		local wage = ::Math.max(0, this.m.CurrentProperties.DailyWage * wageMult); 
		wage += 4; //4 is cost of food cost
		if (this.getSkills().getSkillByID("trait.gluttonous") != null) wage += 4;

		return wage;
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
			local item_cost = ::Math.ceil(i.getValue() * 0.75);
			if (i.m.ID in ::Z.Economy.NoSell) item_cost = 0;
			actor.m.HiringCost += item_cost;
		}
	}

	o.onUpdate = function( _properties )
	{
		local actor = this.getContainer().getActor();
		if (this.isBackgroundType(::Const.BackgroundType.ConvertedCultist)) this.m.DailyCost = 4;
		if (this.getID() == "background.legend_vala") this.m.DailyCost = 16;
		if (this.getID() == "background.slave") this.m.DailyCost = 0;
		if (this.getContainer().hasSkill("trait.player")) this.m.DailyCost = 0;

		local injuryMult = 1.0;
		local armorPct = 1.0;

		try
		{
			armorPct = (actor.getArmor(::Const.BodyPart.Head) + actor.getArmor(::Const.BodyPart.Body)) / (actor.getArmorMax(::Const.BodyPart.Head) + actor.getArmorMax(::Const.BodyPart.Body) * 1.0);
		}
		catch(exception){}

		if (actor.getHitpointsPct() <= 0.75 || armorPct < 0.75 || actor.getSkills().query(::Const.SkillType.TemporaryInjury, false, true).len() > 0) injuryMult = 0.25;


		_properties.DailyWage += ::Math.round(this.m.DailyCost * this.m.DailyCostMult * injuryMult);
	}

	// //Wage hike upon reaching level 11
	// function onUpdate( _properties )
	// {
	// 	if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && this.getID() != "background.slave") _properties.XPGainMult *= 0.9;

	// 	if (this.m.DailyCost == 0 || this.getContainer().hasSkill("trait.player")) _properties.DailyWage = 0;
	// 	else
	// 	{
	// 		if (this.getContainer().getActor().getLevel() >= 11 && this.m.DailyCost < 12) this.m.DailyCost = 12;
	// 		if (this.isBackgroundType(::Const.BackgroundType.ConvertedCultist)) this.m.DailyCost = 4;
	// 		_properties.DailyWage += ::Math.round(this.m.DailyCost * this.m.DailyCostMult);
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
		post_create();

	}

	o.post_create <- function()
	{
	}

	//Overwriting legend's mod buyback
	o.getSellPrice <- function()
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

		if (this.m.ID in ::Z.Economy.NoSell) return 0;
		try {
			if (this.m.Rarity != "Uncommon" && this.m.Rarity != "Rare" && this.m.Rarity != "Legendary" && this.m.Rarity != "Mythic") return 0;
		} catch(exception){}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			local mult = this.getSellPriceMult() * ::Const.World.Assets.BaseSellPrice * this.World.State.getCurrentTown().getSellPriceMult();
			try {
				if (this.m.Rarity == "Uncommon") mult *= 0.5;
			} catch(exception){}
			mult = ::Math.minf(::Math.maxf(mult, 0.5), 1.25); //sell price can't be lower than 50% or higher than 125%

			// ::logInfo(this.m.ID);
			// ::logInfo("item.getSellPriceMult() = " + this.getSellPriceMult());
			// ::logInfo("::Const.World.Assets.BaseSellPrice = " + ::Const.World.Assets.BaseSellPrice);
			// ::logInfo("settlement.getSellPriceMult() = " + this.World.State.getCurrentTown().getSellPriceMult());
			// ::logInfo("mult = " + mult_old);
			// ::logInfo("after ::Math.min(::Math.max(mult, 0.5), 1.25) = " + mult);

			return ::Math.floor(this.getValue() * mult);
		}

		return ::Math.floor(this.getValue() * ::Const.World.Assets.BaseSellPrice);
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
			mult = ::Math.maxf(0.75, mult);

			// ::logInfo(this.m.ID);
			// ::logInfo("item.getBuyPriceMult() = " + this.getBuyPriceMult());
			// ::logInfo("item.getPriceMult() = " + this.getPriceMult());
			// ::logInfo("settlement.getBuyPriceMult() = " + this.World.State.getCurrentTown().getBuyPriceMult());
			// ::logInfo("mult = " + mult_old);
			// ::logInfo("after ::Math.max(0.75, mult) = " + mult);

			return ::Math.ceil(this.getValue() *  mult); //buy price can't be lower than 75%
		}

		return ::Math.ceil(this.getValue() * this.getPriceMult());
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
        local p = this.getPriceMult() * this.World.Assets.getSellPriceMult() * 0.2;
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

		if (this.m.ShopSeed != 0) ::Math.seedRandom(this.m.ShopSeed);
		this.m.ShopSeed = ::Math.floor(this.Time.getRealTime() + ::Math.rand());
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
	local result = this.makeTradingDecision(_settlement, (_party.getFlags().has("tier") ? _party.getFlags().getAsInt("tier") : ::Math.rand(1,2) ));
	_party.setOrigin(_settlement);
	_party.getStashInventory().assign(result.Items);
	_party.getFlags().set("CaravanProfit", 3);
	_party.getFlags().set("CaravanInvestment", 0);
	this.logWarning("Exporting " + _party.getStashInventory().getItems().len() + " items (" + result.Value + " crowns), from " + _settlement.getName() + " via a caravan bound for " + _destination.getName() + " town");
}

::Const.World.Common.WorldEconomy.makeTradingDecision = function( _settlement, _budget )
{
	local result = this.fillWithBreads(_settlement, _budget);
	result.Items.sort(function ( _item1, _item2 )
	{
		if (_item1.getValue() > _item2.getValue()) return -1;
		else if (_item1.getValue() < _item2.getValue()) return 1;
		else return 0;
	});
	return result;
}

::Const.World.Common.WorldEconomy.fillWithBreads = function( _settlement, _budget, _target = null, _isFull = false )
{
	local _tier = _budget;
	if (_target == null)
	{
		_target = {
			Items = [],
			Value = 0,
		};
	}

	local options = [
		"trade_goods",
		"trade_goods",
		"melee_weapons",
		"armor",
		"misc"
	];

	foreach( building in _settlement.getBuildings() )
	{
		if (building.getStash() == null) continue;
		if (building.getID() == "building.weaponsmith")
		{
			options.push("melee_weapons");
			options.push("melee_weapons");
			continue;
		}

		if (building.getID() == "building.fletcher")
		{
			options.push("ranged_weapons");
			options.push("ranged_weapons");
			options.push("ranged_weapons");
			continue;
		}

		if (building.getID() == "building.armorsmith")
		{
			options.push("armor");
			options.push("armor");
			continue;
		}
	}

	local decision = ::MSU.Array.rand(options);

	local _min = 0;
	local _max = 0;
	if (_tier > 3)
	{
		_max += 2;
		_min += 2;
	}

	local amount = ::Math.rand(::Z.Economy.CaravanTable[decision].Min + _min, ::Z.Economy.CaravanTable[decision].Max + _max);
	if (decision == "trade_goods") amount = ::Z.Economy.CaravanTable[decision].Max + _max;

	for( local i = 0; i < amount; i = ++i )
	{
		local item;
		if (i == 0 && _tier == 4) item = ::new(::MSU.Array.rand(::Z.Economy.CaravanTable[decision].TableRare));
		else item = ::new(::MSU.Array.rand(::Z.Economy.CaravanTable[decision].Table));

		_target.Items.push(item);
		_target.Value += item.getValue();
		::logInfo(item.m.Name);
	}

	return _target;
}

