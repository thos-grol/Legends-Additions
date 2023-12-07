this.blacksmith_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.blacksmith";
		this.m.Name = "Blacksmith";
		this.m.Description = "Mercenaries are good at getting arms and armor destroyed, but not at maintaining them. A good blacksmith will take care of this tedious task quickly and efficiently, and can mend even equipment otherwise thought lost... and also crafted famed pieces of equipment";
		this.m.Image = "ui/campfire/blacksmith_01";
		this.m.Cost = 500;
		this.m.Effects = [
			"+200% repair speed (Base 75%, so about 150%)",
			"Saves all gear even if they are broken or lost in battle",
			"Unlocks weapon crafting recipes. Check the crafting tent for details (WIP)",
		];
	}

	function onUpdate()
	{
		this.follower.onUpdate();

		if ("RepairSpeedMult" in this.World.Assets.m)
		{
			this.World.Assets.m.RepairSpeedMult *= 2.0;
		}

		if ("IsBlacksmithed" in this.World.Assets.m)
		{
			this.World.Assets.m.IsBlacksmithed = true;
		}


	}

});

