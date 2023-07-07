::mods_hookExactClass("entity/world/locations/bandit_camp_location", function(o) {
	o.getDescription = function()
	{
		return "A fortified base used by outlaws to stash their loot, rest in between raids and play drinking games.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.bandit_camp";
		this.m.LocationType = this.Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.human_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.Palisade;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(this.Const.World.Spawn.BanditDefenders);
		this.m.Resources = 180;
		this.m.NamedShieldsList = this.Const.Items.NamedBanditShields;
		//Changes
		this.m.Flags.add("ID", this.Math.rand(1, 100000));
		//TODO: create bandit gangs with archetypes
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.BanditCamp);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(200, 500), _lootTable);
		this.dropArmorParts(this.Math.rand(15, 30), _lootTable);
		this.dropAmmo(this.Math.rand(0, 30), _lootTable);
		this.dropMedicine(this.Math.rand(0, 5), _lootTable);
		local treasure = [
			"trade/furs_item",
			"trade/copper_ingots_item",
			"trade/cloth_rolls_item",
			"trade/salt_item",
			"trade/amber_shards_item",
			"trade/iron_ingots_item",
			"trade/tin_ingots_item",
			"trade/gold_ingots_item",
			"loot/silverware_item",
			"loot/silver_bowl_item",
			"loot/signet_ring_item"
		];

		if (this.Const.DLC.Unhold)
		{
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

		this.dropFood(this.Math.rand(2, 4), [
			"bread_item",
			"beer_item",
			"dried_fruits_item",
			"ground_grains_item",
			"roots_and_berries_item",
			"mead_item",
			
			
		], _lootTable);
		this.dropTreasure(this.Math.rand(1, 2), treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		local isOnSteppe = this.getTile().Type == this.Const.World.TerrainType.Steppe;

		for( local i = 0; i != 6; i = i )
		{
			if (this.getTile().hasNextTile(i) && this.getTile().getNextTile(i).Type == this.Const.World.TerrainType.Steppe)
			{
				isOnSteppe = true;
				break;
			}

			i = ++i;
		}

		if (isOnSteppe)
		{
			body.setBrush("world_bandit_camp_steppe_01");
		}
		else
		{
			body.setBrush("world_bandit_camp_01");
		}
	}

});

