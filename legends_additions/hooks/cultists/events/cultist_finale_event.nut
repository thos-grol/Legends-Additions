::mods_hookExactClass("events/events/cultist_finale_event", function (o)
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

		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
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
			if (bro.getBackground().isBackgroundType(this.Const.BackgroundType.ConvertedCultist))
			{
				cultist_candidates.push(bro);

				if ((bestCultist == null || bro.getLevel() > bestCultist.getLevel()) && bro.getBackground().getID() == "background.cultist")
				{
					bestCultist = bro;
				}
			}
			else if (bro.getLevel() >= 11 && !bro.getSkills().hasSkill("trait.player") && !bro.getSkills().hasSkill("trait.player") && !bro.getFlags().get("IsPlayerCharacter"))
			{
				sacrifice_candidates.push(bro);
			}
		}

		if (cultist_candidates.len() <= 5 || bestCultist == null || bestCultist.getLevel() < 11 || sacrifice_candidates.len() == 0)
		{
			return;
		}

		this.m.Cultist = bestCultist;
		this.m.Sacrifice = sacrifice_candidates[this.Math.rand(0, sacrifice_candidates.len() - 1)];
		this.m.Score = 999999;
	}

});

