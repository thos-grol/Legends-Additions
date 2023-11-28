::mods_hookExactClass("entity/world/locations/orc_settlement_location", function(o) {
	o.getDescription = function()
	{
		return "A large and foul-smelling sea of tents, with a warlord\'s tent and throne-room in the middle, the largest of all. It\'s home to a whole tribe until they move on to hunt and raid elsewhere.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.orc_settlement";
		this.m.LocationType = ::Const.World.LocationType.Lair | ::Const.World.LocationType.Mobile;
		this.m.CombatLocation.Template[0] = "tactical.orc_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.setDefenderSpawnList(::Const.World.Spawn.OrcBoss);
		this.m.Resources = 350;
		this.m.NamedWeaponsList = ::Const.Items.NamedOrcWeapons;
		this.m.NamedShieldsList = ::Const.Items.NamedOrcShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(::Const.World.LocationNames.OrcCamp);
		this.location.onSpawned();
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		local treasure = [
			"trade/furs_item",
			"trade/furs_item",
			"trade/furs_item",
			"trade/furs_item",
			"trade/uncut_gems_item",
		];

		if (::Const.DLC.Unhold)
		{
			treasure.extend(treasure);
			treasure.extend(treasure);
			treasure.extend(treasure);
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
		this.dropTreasure(this.Math.rand(1, 3), treasure, _lootTable);
	}

	o.onInit = function()
	{
		this.location.onInit();
		this.setVisibleInFogOfWar(true);
		local body = this.addSprite("body");
		body.setBrush("world_orc_camp_02");
	}

	o.onSerialize = function( _out )
	{
		this.location.onSerialize(_out);
	}

	o.onDeserialize = function( _in )
	{
		this.location.onDeserialize(_in);
	}

});

