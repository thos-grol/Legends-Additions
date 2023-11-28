::mods_hookExactClass("entity/world/locations/nomad_ruins_location", function(o) {
	o.getDescription = function()
	{
		return "These ancient ruins cast their shadows far over the surrounding sands.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.nomad_ruins";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.southern_ruins";
		this.m.CombatLocation.Template[1] = "tactical.desert_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.Walls;
		this.m.CombatLocation.CutDownTrees = false;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.setDefenderSpawnList(::Const.World.Spawn.NomadDefenders);
		this.m.Resources = 150;
		this.m.NamedShieldsList = ::Const.Items.NamedSouthernShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.AncientRuins);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(50, 125), _lootTable);
		this.dropArmorParts(this.Math.rand(5, 10), _lootTable);
		this.dropAmmo(this.Math.rand(0, 20), _lootTable);
		this.dropMedicine(this.Math.rand(0, 3), _lootTable);
		local treasure = [
			"loot/bead_necklace_item",
			"loot/bead_necklace_item",
			"loot/signet_ring_item"
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

			treasure.push("misc/legend_ancient_scroll_item");
			treasure.push("misc/tome");
		}
		this.dropTreasure(this.Math.rand(1, 2), treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_desert_ruins_0" + this.Math.rand(1, 2));
	}

});

