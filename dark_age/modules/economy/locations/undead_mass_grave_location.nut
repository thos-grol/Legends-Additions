::mods_hookExactClass("entity/world/locations/undead_mass_grave_location", function(o) {
	o.getDescription = function()
	{
		return "The sad remains of a merciless battle, an epidemic or other catastrophe. The survivors dug a large hole and piled all the corpses into it to get rid of them quickly.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.undead_mass_grave";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.ruins";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.CombatLocation.ForceLineBattle = true;
		this.m.CombatLocation.AdditionalRadius = 5;
		this.setDefenderSpawnList(::Const.World.Spawn.UndeadArmy);
		this.m.NamedWeaponsList = ::Const.Items.NamedUndeadWeapons;
		this.m.NamedShieldsList = ::Const.Items.NamedUndeadShields;
		this.m.Resources = 200;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.MassGrave);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(::Math.rand(50, 125), _lootTable);
		this.dropArmorParts(::Math.rand(0, 40), _lootTable);
		this.dropAmmo(::Math.rand(0, 20), _lootTable);
		local treasure = [
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item",
			"loot/golden_chalice_item",
			"loot/ancient_gold_coins_item"
		];

		if (::Const.DLC.Unhold)
		{
			treasure.extend(treasure);
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

		this.dropTreasure(::Math.rand(0, 1), treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		local isSouthern = this.getTile().Type == ::Const.World.TerrainType.Desert || this.getTile().Type == ::Const.World.TerrainType.Steppe || this.getTile().Type == ::Const.World.TerrainType.Oasis || this.getTile().TacticalType == ::Const.World.TerrainTacticalType.DesertHills;

		if (isSouthern && ::Const.DLC.Desert)
		{
			body.setBrush("world_mass_grave_02");
			this.m.CombatLocation.Template[0] = "tactical.southern_ruins";
		}
		else
		{
			body.setBrush("world_mass_grave_01");
		}
	}

});

