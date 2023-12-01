this.surgeon_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.surgeon";
		this.m.Name = "Anatomist";
		this.m.Description = "The Anatomist is an expert in the study of flesh and bloodlines. From the corpses of monsters, he derive sequences that convey a part of the monster's power to a human.";
		this.m.Image = "ui/campfire/surgeon_01";
		this.m.Cost = 1000;
		this.m.Effects = [
			"Unlocks anatomist events",
			"5% chance to extract the divine source from monsters as an extraordinary sequence",
			"+200% heal speed (Base 50%, so about 100%)",
			"Every man without a permanent injury is guaranteed to survive an otherwise fatal blow",
			"Every injury takes one less day to heal",
		];
	}

	function onUpdate()
	{
		if ("IsSurvivalGuaranteed" in this.World.Assets.m)
		{
			this.World.Assets.m.IsSurvivalGuaranteed = true;
		}

		if ("HitpointsPerHourMult" in this.World.Assets.m)
		{
			this.World.Assets.m.HitpointsPerHourMult *= 2.0;
		}
	}

});

