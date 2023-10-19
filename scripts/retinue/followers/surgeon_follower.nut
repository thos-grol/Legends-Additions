this.surgeon_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.surgeon";
		this.m.Name = "Anatomist";
		this.m.Description = "The Anatomist is an expert in the study of flesh and bloodlines. From the corpses of monsters, he derive sequences that convey a part of the monster's power to a human.";
		this.m.Image = "ui/campfire/surgeon_01";
		this.m.Cost = 1750;
		this.m.Effects = [
			"Has a 5% chance to extract an extraordinary sequence as a potion when slaying a monster",
			"Unlocks anatomist events"
		];
		this.addRequirement("Slay a monster", function ()
		{
			if (!::World.Statistics.getFlags().has("MonstersSlain")) return false;
			return ::World.Statistics.getFlags().getAsInt("MonstersSlain") >= 1;
		}, true, function ( _r )
		{
			_r.Count <- 1;
			_r.UpdateText <- function ()
			{
				local monsters_slain = (!::World.Statistics.getFlags().has("MonstersSlain") ? 0 : ::World.Statistics.getFlags().getAsInt("MonstersSlain"));
				this.Text = "Slay " + ::Math.min(this.Count, monsters_slain) + "/" + this.Count + " monsters";
			};
		});
	}

	function onUpdate()
	{
		if ("IsSurvivalGuaranteed" in this.World.Assets.m)
		{
			this.World.Assets.m.IsSurvivalGuaranteed = true;
		}
	}

});

