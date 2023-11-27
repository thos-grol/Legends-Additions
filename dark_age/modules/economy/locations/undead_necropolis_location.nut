::mods_hookExactClass("entity/world/locations/undead_necropolis_location", function(o) {
	o.getDescription = function()
	{
		return "Once a thriving human settlement, this place has been defiled and fallen into ruin, turned into a necropolis of the undead. Waves of walking corpses pour forth to spread terror and fear in the surrounding lands.";
	}

	o.setSprite = function( _s )
	{
		this.m.SettlementSprite = _s;
		this.getSprite("body").setBrush(this.m.SettlementSprite + "_undead");
		this.getSprite("lighting").setBrush(this.m.SettlementSprite + "_undead_lights");
	}

	o.setName = function( _n )
	{
		this.m.SettlementName = _n;
		this.world_entity.setName("Ruins of " + _n);
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.undead_necropolis";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.ruins";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		local r = this.Math.rand(1, 3);
		this.setDefenderSpawnList(::Const.World.Spawn.UndeadScourge);
		this.m.Resources = 350;
		this.m.NamedWeaponsList = ::Const.Items.NamedUndeadWeapons;
		this.m.NamedShieldsList = ::Const.Items.NamedUndeadShields;
	}

	o.onSpawned = function()
	{
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(200, 500), _lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/white_pearls_item",
			"loot/golden_chalice_item",
			"loot/gemstones_item",
			"loot/ancient_gold_coins_item",
			"loot/jeweled_crown_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/white_pearls_item",
			"loot/golden_chalice_item",
			"loot/gemstones_item",
			"loot/ancient_gold_coins_item",
			"loot/jeweled_crown_item",
			"loot/ancient_gold_coins_item",
			"loot/ornate_tome_item",
			"misc/legend_ancient_scroll_item"
		], _lootTable);
	}

	o.onCombatLost = function()
	{
		this.getTile().spawnDetail(this.m.SettlementSprite + "_ruins", ::Const.World.ZLevel.Object - 3, 0, false);
		this.World.EntityManager.onWorldEntityDestroyed(this, true);
		this.world_entity.onCombatLost();
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		local light = this.addSprite("lighting");
		this.setSpriteColorization("lighting", false);
		light.IgnoreAmbientColor = true;
		light.Alpha = 0;
		this.registerThinker();
	}

	o.onFinish = function()
	{
		this.location.onFinish();
		this.unregisterThinker();
	}

	o.onUpdate = function()
	{
		local lighting = this.getSprite("lighting");

		if (lighting.IsFadingDone)
		{
			if (lighting.Alpha == 0 && this.World.getTime().TimeOfDay >= 4 && this.World.getTime().TimeOfDay <= 7)
			{
				local insideScreen = this.World.getCamera().isInsideScreen(this.getPos(), 0);

				if (insideScreen)
				{
					lighting.fadeIn(5000);
				}
				else
				{
					lighting.Alpha = 255;
				}
			}
			else if (lighting.Alpha != 0 && this.World.getTime().TimeOfDay >= 0 && this.World.getTime().TimeOfDay <= 3)
			{
				local insideScreen = this.World.getCamera().isInsideScreen(this.getPos(), 0);

				if (insideScreen)
				{
					lighting.fadeOut(4000);
				}
				else
				{
					lighting.Alpha = 0;
				}
			}
		}
	}

	o.onSerialize = function( _out )
	{
		this.location.onSerialize(_out);
		_out.writeString(this.m.SettlementName);
		_out.writeString(this.m.SettlementSprite);
	}

	o.onDeserialize = function( _in )
	{
		this.location.onDeserialize(_in);
		this.m.SettlementName = _in.readString();
		this.m.SettlementSprite = _in.readString();
	}

});

