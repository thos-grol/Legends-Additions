this.bandit_thug_potioned <- this.inherit("scripts/entity/tactical/enemies/bandit_thug", {
	m = {},
	function create()
	{
		this.bandit_thug.create();
		this.m.Name = "Thug Bodyguard";
	}

	function onInit()
	{
		this.bandit_thug.onInit();
		this.makeMiniboss();
		local potions = [
			"direwolf",
			"ghoul",
			"spider"
		]
		this.add_potion(::MSU.Array.rand(potions), false);
	}

});

