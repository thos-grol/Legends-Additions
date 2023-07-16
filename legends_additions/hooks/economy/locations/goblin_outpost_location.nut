::mods_hookExactClass("entity/world/locations/goblin_outpost_location", function(o) {
	o.getDescription = function()
	{
		return "A defensible outpost erected by goblins.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.goblin_outpost";
		this.m.LocationType = this.Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.goblin_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.WallsAndPalisade;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(this.Const.World.Spawn.GoblinBoss);
		this.m.Resources = 200;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.GoblinBase);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(0, 50), _lootTable);
		this.dropArmorParts(this.Math.rand(5, 15), _lootTable);
		this.dropAmmo(this.Math.rand(30, 60), _lootTable);
		this.dropMedicine(this.Math.rand(0, 5), _lootTable);
		local treasure = [
			"trade/salt_item",
			"trade/amber_shards_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/ancient_gold_coins_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			
			"loot/goblin_minted_coins_item",
			"loot/goblin_rank_insignia_item"
		];

		if (this.Const.DLC.Unhold)
		{
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.extend(treasure);

			treasure.push("legend_armor/armor_upgrades/legend_metal_plating_upgrade");
			treasure.push("legend_armor/armor_upgrades/legend_metal_pauldrons_upgrade");
			treasure.push("legend_armor/armor_upgrades/legend_mail_patch_upgrade");
			treasure.push("legend_armor/armor_upgrades/legend_leather_shoulderguards_upgrade");
			treasure.push("legend_armor/armor_upgrades/legend_leather_neckguard_upgrade");
			treasure.push("legend_armor/armor_upgrades/legend_joint_cover_upgrade");
			treasure.push("legend_armor/armor_upgrades/legend_heraldic_plates_upgrade");
			treasure.push("legend_armor/armor_upgrades/legend_double_mail_upgrade");
		}

		this.dropFood(this.Math.rand(3, 5), [
			"strange_meat_item",
			"roots_and_berries_item",
			
		], _lootTable);
		this.dropTreasure(this.Math.rand(1, 2), treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		this.setVisibleInFogOfWar(true);
		local body = this.addSprite("body");
		body.setBrush("world_goblin_camp_03");
	}

});

