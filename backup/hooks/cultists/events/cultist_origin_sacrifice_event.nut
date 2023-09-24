::mods_hookExactClass("events/events/dlc4/cultist_origin_sacrifice_event", function(o) {
    o.onUpdateScore = function()
	{
		if (!::Const.DLC.Wildmen) return;
		if (this.World.getTime().Days <= 5) return;
		if (this.World.Assets.getOrigin().getID() != "scenario.cultists") return;
		

		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() < 3) return;
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("background.cultist_magister") || bro.getSkills().hasSkill("background.cultist_darksoul"))
			{
				continue;
			}

			candidates.push(bro);
		}

		if (candidates.len() < 3) return;
		candidates.sort(function ( _a, _b )
		{
			if (_a.getXP() < _b.getXP())
			{
				return -1;
			}
			else if (_a.getXP() > _b.getXP())
			{
				return 1;
			}

			return 0;
		});
		this.m.Sacrifice1 = candidates[0];
		this.m.Sacrifice2 = candidates[1];
		this.m.Score = 500 + (this.World.getTime().Days - this.m.LastTriggeredOnDay) * 100;
	}
});
