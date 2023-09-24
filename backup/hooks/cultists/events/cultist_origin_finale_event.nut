::mods_hookExactClass("events/events/dlc4/cultist_origin_finale_event", function (o)
{
	
	o.onUpdateScore = function()
	{
		if (!::Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days <= 150)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 12)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local sacrifice_candidates = [];
		local cultist_candidates = [];
		local bestCultist;

		foreach( bro in brothers )
		{
			if (bro.getBackground().isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bro.getBackground().isBackgroundType(::Const.BackgroundType.Cultist))
			{
				cultist_candidates.push(bro);

				if ((bestCultist == null || bro.getLevel() > bestCultist.getLevel()) && bro.getBackground().getID() == "background.cultist")
				{
					bestCultist = bro;
				}

				if (bro.getLevel() >= 11)
				{
					sacrifice_candidates.push(bro);
				}
			}
		}

		if (cultist_candidates.len() <= 5 || bestCultist == null || bestCultist.getLevel() < 11 || sacrifice_candidates.len() < 2)
		{
			return;
		}

		for( local i = 0; i < sacrifice_candidates.len(); i = i )
		{
			if (bestCultist.getID() == sacrifice_candidates[i].getID())
			{
				sacrifice_candidates.remove(i);
				break;
			}

			i = ++i;
		}

		this.m.Cultist = bestCultist;
		this.m.Sacrifice = sacrifice_candidates[this.Math.rand(0, sacrifice_candidates.len() - 1)];
		this.m.Score = 999999;
	}

});

