::mods_hookExactClass("entity/world/locations/bandit_ruins_location", function(o) {
	o.getDescription = function()
	{
		local isSouthern = this.getTile().Type == this.Const.World.TerrainType.Desert || this.getTile().Type == this.Const.World.TerrainType.Steppe || this.getTile().Type == this.Const.World.TerrainType.Oasis || this.getTile().TacticalType == this.Const.World.TerrainTacticalType.DesertHills;

		if (isSouthern)
		{
			return "These ancient ruins cast their shadows far over the surrounding sands.";
		}
		else
		{
			return "A once proud fortress now lying in ruins.";
		}
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.bandit_ruins";
		this.m.LocationType = this.Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.ruins";
		this.m.CombatLocation.Template[1] = "tactical.human_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.WallsAndPalisade;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = false;
		this.setDefenderSpawnList(this.Const.World.Spawn.BanditDefenders);
		this.m.Resources = 150;
		this.m.NamedShieldsList = this.Const.Items.NamedBanditShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.Ruins);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(100, 300), _lootTable);
		this.dropArmorParts(this.Math.rand(5, 25), _lootTable);
		this.dropAmmo(this.Math.rand(0, 40), _lootTable);
		this.dropMedicine(this.Math.rand(0, 3), _lootTable);
		local treasure = [
			"loot/signet_ring_item",
			"trade/amber_shards_item",
			"trade/cloth_rolls_item",
			"trade/salt_item"
		];

		if (this.Const.DLC.Unhold)
		{
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.extend(treasure);

			if (!::Legends.Mod.ModSettings.getSetting("UnlayeredArmor").getValue())
			{
				treasure.push("legend_armor/armor_upgrades/legend_metal_plating_upgrade");
				treasure.push("legend_armor/armor_upgrades/legend_metal_pauldrons_upgrade");
				treasure.push("legend_armor/armor_upgrades/legend_mail_patch_upgrade");
				treasure.push("legend_armor/armor_upgrades/legend_leather_shoulderguards_upgrade");
				treasure.push("legend_armor/armor_upgrades/legend_leather_neckguard_upgrade");
				treasure.push("legend_armor/armor_upgrades/legend_joint_cover_upgrade");
				treasure.push("legend_armor/armor_upgrades/legend_heraldic_plates_upgrade");
				treasure.push("legend_armor/armor_upgrades/legend_double_mail_upgrade");
			}
			else
			{
				treasure.push("armor_upgrades/metal_plating_upgrade");
				treasure.push("armor_upgrades/metal_pauldrons_upgrade");
				treasure.push("armor_upgrades/mail_patch_upgrade");
				treasure.push("armor_upgrades/leather_shoulderguards_upgrade");
				treasure.push("armor_upgrades/leather_neckguard_upgrade");
				treasure.push("armor_upgrades/joint_cover_upgrade");
				treasure.push("armor_upgrades/heraldic_plates_upgrade");
				treasure.push("armor_upgrades/double_mail_upgrade");
			}
		}

		this.dropFood(this.Math.rand(1, 3), [
			"bread_item",
			"beer_item",
			"dried_fruits_item",
			"ground_grains_item",
			"roots_and_berries_item",
		], _lootTable);
		this.dropTreasure(1, treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		local isSouthern = this.getTile().Type == this.Const.World.TerrainType.Desert || this.getTile().Type == this.Const.World.TerrainType.Steppe || this.getTile().Type == this.Const.World.TerrainType.Oasis || this.getTile().TacticalType == this.Const.World.TerrainTacticalType.DesertHills;

		if (isSouthern)
		{
			body.setBrush("world_desert_ruins_0" + this.Math.rand(1, 2));

			if (this.Const.DLC.Desert)
			{
				this.m.CombatLocation.Template[0] = "tactical.southern_ruins";
			}
		}
		else
		{
			body.setBrush("world_ruins_0" + this.Math.rand(1, 3));
		}
	}

});

