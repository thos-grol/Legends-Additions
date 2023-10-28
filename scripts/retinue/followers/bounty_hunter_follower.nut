this.bounty_hunter_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.bounty_hunter";
		this.m.Name = "The Bounty Hunter";
		this.m.Description = "The Bounty Hunter has a pocket full of contracts on the most dangerous individuals. He knows how to get them from hiding and will pay handsomely for any bounty fulfilled.";
		this.m.Image = "ui/campfire/bounty_hunter_01";
		this.m.Cost = 50;
		this.m.Effects = [
			"Increases the chance of encountering champions by 5%",
			"Pays between 10 - 50 crowns for every champion slain"
		];
	}

	function isValid()
	{
		return ::Const.DLC.Wildmen;
	}

	function onUpdate()
	{
		if ("ChampionChanceAdditional" in this.World.Assets.m)
		{
			this.World.Assets.m.ChampionChanceAdditional = 5;
		}
	}

	function onChampionKilled( _champion )
	{
		if (this.Tactical.State.getStrategicProperties() == null || !this.Tactical.State.getStrategicProperties().IsArenaMode)
		{
			this.World.Assets.addMoney(::Math.rand(10, 50));
		}
	}

	function getNumberOfNamedItems()
	{
		local n = 0;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && (item.isItemType(::Const.Items.ItemType.Named) || item.isItemType(::Const.Items.ItemType.Legendary)) && item.getID() != "armor.head.fangshire")
			{
				n = ++n;
				n = n;
			}
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);

			if (item != null && (item.isItemType(::Const.Items.ItemType.Named) || item.isItemType(::Const.Items.ItemType.Legendary)))
			{
				n = ++n;
				n = n;
			}

			item = bro.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

			if (item != null && item != "-1" && (item.isItemType(::Const.Items.ItemType.Named) || item.isItemType(::Const.Items.ItemType.Legendary)))
			{
				n = ++n;
				n = n;
			}

			item = bro.getItems().getItemAtSlot(::Const.ItemSlot.Head);

			if (item != null && (item.isItemType(::Const.Items.ItemType.Named) || item.isItemType(::Const.Items.ItemType.Legendary)) && item.getID() != "armor.head.fangshire")
			{
				n = ++n;
				n = n;
			}

			item = bro.getItems().getItemAtSlot(::Const.ItemSlot.Body);

			if (item != null && (item.isItemType(::Const.Items.ItemType.Named) || item.isItemType(::Const.Items.ItemType.Legendary)))
			{
				n = ++n;
				n = n;
			}

			for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = i )
			{
				local item = bro.getItems().getItemAtBagSlot(i);

				if (item != null && (item.isItemType(::Const.Items.ItemType.Named) || item.isItemType(::Const.Items.ItemType.Legendary)))
				{
					n = ++n;
					n = n;
				}

				i = ++i;
			}
		}

		return n;
	}

});

