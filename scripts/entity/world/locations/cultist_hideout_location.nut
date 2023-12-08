this.cultist_hideout_location <- this.inherit("scripts/entity/world/location", {
	m = {},
	function getDescription()
	{
		return "An abandoned homestead with a collapsed roof.";
	}

	function create()
	{
		this.location.create();
		this.m.TypeID = "location.cultist_hideout";
		this.m.LocationType = this.Const.World.LocationType.Lair | this.Const.World.LocationType.Passive;
		this.m.CombatLocation.Template[0] = "tactical.human_camp";
		this.m.CombatLocation.Fortification = this.Const.Tactical.FortificationType.None;
		this.m.CombatLocation.CutDownTrees = true;
		this.m.IsDespawningDefenders = false;
		this.setDefenderSpawnList(this.Const.World.Spawn.CultistDefenderss);
		this.m.Resources = 70;
		this.m.NamedShieldsList = this.Const.Items.NamedBanditShields;
	}

	function onSpawned()
	{
		this.m.Name = this.World.EntityManager.getUniqueLocationName(this.Const.World.LocationNames.Hideout);
		this.location.onSpawned();
	}

	function onDropLootForPlayer( _lootTable )
	{
		this.location.onDropLootForPlayer(_lootTable);
		this.dropMoney(this.Math.rand(0, 75), _lootTable);
		this.dropArmorParts(this.Math.rand(0, 5), _lootTable);
		this.dropAmmo(this.Math.rand(0, 10), _lootTable);
		local treasure = [
			"loot/bead_necklace_item",
			"loot/bead_necklace_item",
			"trade/furs_item"
		];
		this.dropTreasure(1, treasure, _lootTable);
	}

	function onInit()
	{
		this.location.onInit();
		local body = this.addSprite("body");
		body.setBrush("world_homestead_01");
	}

});

