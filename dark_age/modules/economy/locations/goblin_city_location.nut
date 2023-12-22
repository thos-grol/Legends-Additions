::mods_hookExactClass("entity/world/locations/goblin_city_location", function(o) {
	o.getDescription = function()
	{
		return "A great goblin city nested into the remains of an ancient fortress. Protected by dark and towering walls, it is host to a standing army of vicious greenskins.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.goblin_city";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Unique;
		this.m.CombatLocation.Template[0] = "tactical.goblin_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsDespawningDefenders = false;
		this.m.VisibilityMult = 0.8;
		this.m.Resources = 500;
		local dateToSkip = 0;

		switch(this.World.Assets.getCombatDifficulty())
		{
		case ::Const.Difficulty.Easy:
			dateToSkip = 400;
			break;

		case ::Const.Difficulty.Normal:
			dateToSkip = 300;
			break;

		case ::Const.Difficulty.Hard:
			dateToSkip = 200;
			break;

		case ::Const.Difficulty.Legendary:
			dateToSkip = 100;
			break;
		}

		if (this.World.getTime().Days >= dateToSkip)
		{
			local bonus = ::Math.min(1, ::Math.floor(this.World.getTime().Days - dateToSkip));
			this.m.Resources += bonus;
		}
	}

	o.onSpawned = function()
	{
		this.m.Name = "Rul\'gazhix";
		this.location.onSpawned();

		for( local i = 0; i < 16; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.GoblinSkirmisher
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 6; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.GoblinAmbusher
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.GoblinOverseer
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.GoblinShaman
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 11; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.GoblinWolfrider
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 7; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.GoblinAmbusher
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 1; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.GoblinOverseer
			}, false);
			i = ++i;
		}

		for( local i = 0; i < 2; i = i )
		{
			::Const.World.Common.addTroop(this, {
				Type = ::Const.World.Spawn.Troops.GoblinShaman
			}, false);
			i = ++i;
		}
	}

	o.onBeforeCombatStarted = function()
	{
		this.location.onBeforeCombatStarted();
		local dateToSkip = 0;
		local toSpawn = 47;

		switch(this.World.Assets.getCombatDifficulty())
		{
		case ::Const.Difficulty.Easy:
			dateToSkip = 400;
			break;

		case ::Const.Difficulty.Normal:
			dateToSkip = 300;
			break;

		case ::Const.Difficulty.Hard:
			dateToSkip = 200;
			break;

		case ::Const.Difficulty.Legendary:
			dateToSkip = 100;
			break;
		}

		if (this.World.getTime().Days >= dateToSkip)
		{
			local bonus = ::Math.min(1, ::Math.floor((this.World.getTime().Days - dateToSkip) / 20));
			toSpawn = toSpawn + bonus;
		}

		for( local added = 0; this.m.Troops.len() < toSpawn;  )
		{
			local r = ::Math.rand(1, 3);

			if (r == 1)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.GoblinSkirmisher
				}, false);
			}
			else if (r == 2)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.GoblinAmbusher
				}, false);
			}
			else if (r == 3)
			{
				::Const.World.Common.addTroop(this, {
					Type = ::Const.World.Spawn.Troops.GoblinWolfrider
				}, false);
			}

			added = ++added;
			added = added;

			if (added >= 3)
			{
				break;
			}
		}
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(::Math.rand(0, 20), _lootTable);
		this.dropAmmo(::Math.rand(25, 100), _lootTable);
		this.dropMedicine(::Math.rand(0, 10), _lootTable);

		local treasure = [
			"loot/goblin_minted_coins_item",
			"loot/signet_ring_item"
		];
		treasure.push("misc/scroll");
		treasure.push("misc/tome");
		treasure.push("misc/potion_of_oblivion_item");
		this.dropTreasure(::Math.rand(2, 3), treasure, _lootTable);

		_lootTable.push(::Const.World.Common.pickHelmet([
			[
				1,
				"legendary/emperors_countenance"
			]
		]));
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_goblin_camp_04");
	}

});

