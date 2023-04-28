::mods_hookExactClass("events/events/dlc4/kings_guard_2_event", function (o)
{

    o.onUpdateScore = function()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidate;

		foreach( bro in brothers )
		{
			if (bro.getDaysWithCompany() >= 30 && bro.getFlags().get("IsKingsGuard"))
			{
				candidate = bro;
				break;
			}
		}

		if (candidate == null)
		{
			return;
		}

		this.m.Dude = candidate;
		this.m.Score = 99999;
	}


});