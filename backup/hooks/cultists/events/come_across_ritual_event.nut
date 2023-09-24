::mods_hookExactClass("events/events/come_across_ritual_event", function (o)
{
	o.onUpdateScore = function()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days <= 200)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 11 && (bro.getBackground().isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(::Const.BackgroundType.Cultist)))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		if (candidates.len() != 0)
		{
			this.m.Cultist = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 999998;
	}

});

