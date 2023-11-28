::mods_hookExactClass("entity/world/locations/goblin_outpost_location", function(o) {
	o.getDescription = function()
	{
		return "A defensible outpost erected by goblins.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.goblin_outpost";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.goblin_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.WallsAndPalisade;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(::Const.World.Spawn.GoblinBoss);
		this.m.Resources = 200;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.GoblinBase);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(5, 15), _lootTable);
		this.dropAmmo(this.Math.rand(30, 60), _lootTable);
		this.dropMedicine(this.Math.rand(0, 5), _lootTable);
		local treasure = [
			"loot/goblin_minted_coins_item",
			"loot/signet_ring_item"
		];

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

