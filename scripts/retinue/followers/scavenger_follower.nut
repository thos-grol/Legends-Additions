this.scavenger_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.scavenger";
		this.m.Name = "Scavenger\'s Cart";
		this.m.Description = "While mundane, the act of taking everything not nailed down after a battle can save a lot of money later down the road. Comes with pliars to open deathgrips.";
		this.m.Image = "ui/campfire/legend_scavenger_01";
		this.m.Cost = 1500;
		this.m.Effects = [
			"Recovers a part of all ammo you use during battle",
			"Recovers tools and supplies from every armor destroyed by you during battle"
		];
		this.addSkillRequirement("Have at least one of the following backgrounds: Beggar, Cripple, Refugee, Slave", [
			"background.beggar",
			"background.cripple",
			"background.refugee",
			"background.slave",
			"background.female_beggar",
			"background.legend_commander_beggar",
			"background.legend_commander_beggar_female",
			"background.legend_commander_beggar_op",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	function onUpdate()
	{
		if ("IsRecoveringAmmo" in this.World.Assets.m)
		{
			this.World.Assets.m.IsRecoveringAmmo = true;
		}

		if ("IsRecoveringArmor" in this.World.Assets.m)
		{
			this.World.Assets.m.IsRecoveringArmor = true;
		}
	}

});

