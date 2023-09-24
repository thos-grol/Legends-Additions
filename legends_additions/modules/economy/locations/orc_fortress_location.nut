::mods_hookExactClass("entity/world/locations/orc_fortress_location", function(o) {
	o.getDescription = function()
	{
		return "A mighty fortress made from massive iron wood logs and covered in tribal paintings of war. The bloodthirsty shouts of orcs echoing behind the walls can be heard from afar.";
	}

	o.create = function()
	{
		this.location.create();
		this.m.TypeID = "location.orc_fortress";
		this.m.LocationType = ::Const.World.LocationType.Lair;
		this.m.CombatLocation.Template[0] = "tactical.orc_camp";
		this.m.CombatLocation.Fortification = ::Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsShowingDefenders = false;
		this.m.IsShowingBanner = true;
		this.m.IsDespawningDefenders = false;
		this.m.Resources = 500;
		this.m.NamedWeaponsList = ::Const.Items.NamedOrcWeapons;
		this.m.NamedShieldsList = ::Const.Items.NamedOrcShields;
	}

	o.onSpawned = function()
	{
		this.m.Name = "Fortress of the Warlord";
		this.location.onSpawned();

		for( local i = 0; i < 16; i = i )
		{
			::Const.World.Common.addTroop(this, ::Const.World.Spawn.Troops.OrcYoung, false);
			i = ++i;
		}

		for( local i = 0; i < 8; i = i )
		{
			::Const.World.Common.addTroop(this, ::Const.World.Spawn.Troops.OrcBerserker, false);
			i = ++i;
		}

		for( local i = 0; i < 15; i = i )
		{
			::Const.World.Common.addTroop(this, ::Const.World.Spawn.Troops.OrcWarrior, false);
			i = ++i;
		}

		for( local i = 0; i < 3; i = i )
		{
			::Const.World.Common.addTroop(this, ::Const.World.Spawn.Troops.OrcWarlord, false);
			i = ++i;
		}
	}

	o.onDropLootForPlayer = function( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropArmorParts(this.Math.rand(25, 50), _lootTable);
		this.dropMedicine(this.Math.rand(0, 6), _lootTable);
		this.dropFood(this.Math.rand(4, 8), [
			"strange_meat_item"
		], _lootTable);
		this.dropTreasure(this.Math.rand(3, 4), [
			"trade/furs_item",
			"trade/furs_item",
			"trade/uncut_gems_item",
			"trade/dies_item",
			"loot/white_pearls_item"
		], _lootTable);
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
		body.setBrush("world_orc_camp_04");
	}

});

