this.surgeon_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.surgeon";
		this.m.Name = "Triage Table";
		this.m.Description = "Having an area set up and ready to treat the worst injuries could be the hair between life and death for the company. Maybe even yourself...one day.";
		this.m.Image = "ui/campfire/legend_surgeon_01";
		this.m.Cost = 1750;
		this.m.Effects = [
			"Makes every man without a permanent injury guaranteed to survive an otherwise fatal blow",
			"Makes every injury take one less day to heal"
		];
		this.addSkillRequirement("Have someone with the Field Triage perk. Guaranteed on Monks and Nuns", [
			"perk.legend_field_triage",
			"background.legend_companion_melee",
			"background.legend_companion_ranged"
		]);
	}

	function onUpdate()
	{
		if ("IsSurvivalGuaranteed" in this.World.Assets.m)
		{
			this.World.Assets.m.IsSurvivalGuaranteed = true;
		}
	}

});

