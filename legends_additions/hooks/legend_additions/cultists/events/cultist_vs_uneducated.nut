//changed the cooldown of cultist conversion to a week. Made the event more common
::mods_hookExactClass("events/events/cultist_vs_uneducated_event", function (o)
{
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = 7 * this.World.getTime().SecondsPerDay;
		this.logInfo("ccc: " + this.m.Cooldown + "days");
	}

	o.onUpdateScore = function()
	{
		this.logInfo("Confirming cooldown for cultist vs uneducated was changed: " + this.m.Cooldown + "days");
		if (this.World.Assets.getOrigin().getID() == "scenario.cultists") return;

		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() < 4) return;

		local cultist_candidates = [];
		local uneducated_candidates = [];

		foreach( bro in brothers )
		{
			local bg = bro.getBackground();
			if (bro.getFlags().get("IsSpecial")) continue;
			if (bg.getID() == "background.slave") continue;

			if (bg.isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bg.isBackgroundType(::Const.BackgroundType.Cultist))
			{
				cultist_candidates.push(bro);
			}
			else if (bg.isBackgroundType(::Const.BackgroundType.Lowborn) && !bro.getSkills().hasSkill("trait.bright")
				|| bg.isBackgroundType(::Const.BackgroundType.Noble) && bro.getSkills().hasSkill("trait.dumb")
				|| bro.getSkills().hasSkill("injury.brain_damage"))
			{
				if (bg.getID() != "background.legend_commander_berserker"
					&& bg.getID() != "background.legend_berserker"
					&& bg.getID() != "background.legend_donkey_background")
				{
					uneducated_candidates.push(bro);
				}
			}
		}

		if (cultist_candidates.len() == 0 || uneducated_candidates.len() == 0) return;

		this.m.Cultist = ::MSU.Array.rand(cultist_candidates);
		this.m.Uneducated = ::MSU.Array.rand(uneducated_candidates);
		this.m.Score = cultist_candidates.len() * 10;
	}
});

::mods_hookExactClass("events/events/dlc4/cultist_origin_vs_uneducated_event", function (o)
{
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.Cooldown = 7 * this.World.getTime().SecondsPerDay;
	}

	o.onUpdateScore = function()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.cultists") return;

		local brothers = this.World.getPlayerRoster().getAll();
		if (brothers.len() < 4) return;

		local cultist_candidates = [];
		local uneducated_candidates = [];

		foreach( bro in brothers )
		{
			local bg = bro.getBackground();
			if (bro.getFlags().get("IsSpecial")) continue;
			if (bg.getID() == "background.slave") continue;

			if (bg.isBackgroundType(::Const.BackgroundType.ConvertedCultist) || bg.isBackgroundType(::Const.BackgroundType.Cultist))
			{
				cultist_candidates.push(bro);
			}
			else if (bg.isBackgroundType(::Const.BackgroundType.Lowborn) && !bro.getSkills().hasSkill("trait.bright")
				|| bg.isBackgroundType(::Const.BackgroundType.Noble) && bro.getSkills().hasSkill("trait.dumb")
				|| bro.getSkills().hasSkill("injury.brain_damage"))
			{
				if (bg.getID() != "background.legend_commander_berserker"
					&& bg.getID() != "background.legend_berserker"
					&& bg.getID() != "background.legend_donkey_background")
				{
					uneducated_candidates.push(bro);
				}
			}
		}

		if (cultist_candidates.len() == 0 || uneducated_candidates.len() == 0) return;

		this.m.Cultist = ::MSU.Array.rand(cultist_candidates);
		this.m.Uneducated = ::MSU.Array.rand(uneducated_candidates);
		this.m.Score = cultist_candidates.len() * 15;
	}
});