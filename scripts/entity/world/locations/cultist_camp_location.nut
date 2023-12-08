this.cultist_camp_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "A fortified wooden encampment used by outlaws to stash their loot, rest in between raids and play drinking games.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.cultist_camp";
		this.m.LocationType = this.Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.human_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.Palisade;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(this.Const.World.Spawn.CultistDefenders);
		this.m.Resources = 180;
		this.m.NamedShieldsList = this.Const.Items.NamedBanditShields;
	}

	function onSpawned()
	{
		this.m.Name = "Cultist Encampment";
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(50, 125), _lootTable);
		this.dropArmorParts(this.Math.rand(5, 10), _lootTable);
		this.dropAmmo(this.Math.rand(0, 15), _lootTable);
		this.dropMedicine(this.Math.rand(0, 5), _lootTable);
		local treasure = [
			"loot/bead_necklace_item",
			"loot/bead_necklace_item",
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

	function onInit()
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

