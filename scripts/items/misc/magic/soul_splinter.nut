this.soul_splinter <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "magic.soul_splinter";
		this.m.Name = "Soul Splinter";
		this.m.Description = "Fragments of the soul, it looks like the stars are shimmering deep within these stones. An aura of winter is discernable";
		this.m.Icon = "loot/southern_06.png";
		this.m.SlotType = ::Const.ItemSlot.None;
		this.m.ItemType = ::Const.Items.ItemType.Misc | ::Const.Items.ItemType.Loot;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 100;

		this.m.SlotType = ::Const.ItemSlot.Accessory;
		this.m.ItemType = ::Const.Items.ItemType.Accessory;
		this.m.IsAllowedInBag = true;

		this.m.Consumable <- true;
		this.m.Aspect <- "winter";
		this.m.Aspect_Amount <- 2;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/winter.png",
				text = "2 (Winter)"
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		return result;
	}

	function getBuyPrice()
	{
		if (this.m.IsSold)
		{
			return this.getSellPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return ::Math.max(this.getSellPrice(), ::Math.ceil(this.getValue() * 1.5 * this.World.State.getCurrentTown().getBuyPriceMult() * this.World.State.getCurrentTown().getBeastPartsPriceMult()));
		}
		else
		{
			return ::Math.ceil(this.getValue());
		}
	}

	function getSellPrice()
	{
		if (this.m.IsBought)
		{
			return this.getBuyPrice();
		}

		if (("State" in this.World) && this.World.State != null && this.World.State.getCurrentTown() != null)
		{
			return ::Math.floor(this.getValue() * ::Const.World.Assets.BaseLootSellPrice * this.World.State.getCurrentTown().getSellPriceMult() * this.World.State.getCurrentTown().getBeastPartsPriceMult() * ::Const.Difficulty.SellPriceMult[this.World.Assets.getEconomicDifficulty()]);
		}
		else
		{
			return ::Math.floor(this.getValue());
		}
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", ::Const.Sound.Volume.Inventory);
	}

});

