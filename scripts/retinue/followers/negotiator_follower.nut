this.negotiator_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.negotiator";
		this.m.Name = "Anatomist";
		this.m.Description = "The Anatomist is an expert in the study of flesh and bloodlines. From the corpses of monsters, he derive sequences that convey a part of the monster's power to a human.";
		this.m.Image = "ui/campfire/negotiator_01";
		this.m.Cost = 3500;
		this.m.Effects = [
			"Has a 5% chance to extract an extraordinary sequence as a potion when slaying a monster",
			"Unlocks anatomist events"
		];
		this.addRequirement("Slay a monster", function ()
		{
			return ::World.Statistics.getFlags().getAsInt("MonstersSlain") >= 1;
		}, true, function ( _r )
		{
			_r.Count <- 1;
			_r.UpdateText <- function ()
			{
				this.Text = "Slay " + ::Math.min(this.Count, ::World.Statistics.getFlags().getAsInt("MonstersSlain")) + "/" + this.Count + " monsters";
			};
		});
	}

	function onUpdate()
	{
	}

	function onNewDay()
	{
	}

});

