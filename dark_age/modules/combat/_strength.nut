::mods_hookExactClass("entity/world/player_party", function (o)
{
    o.updateStrength = function()
	{
		this.m.Strength = 0.0;
		local roster = this.World.getPlayerRoster().getAll();

		if (roster.len() > this.World.Assets.getBrothersScaleMax())
		{
			roster.sort(this.onLevelCompare);
		}

		if (roster.len() < this.World.Assets.getBrothersScaleMin())
		{
			this.m.Strength += 10.0 * (this.World.Assets.getBrothersScaleMin() - roster.len());
		}

		if (this.World.Assets.getOrigin() == null)
		{
			this.m.Strength * 0.8;
			return;
		}

		local broScale = 1.0;

		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			broScale = 0.66;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.lone_wolf")
		{
			broScale = 1.66;
		}

		local zombieSummonLevel = 0;
		local skeletonSummonLevel = 0;
		local count = 0;

		foreach( i, bro in roster )
		{
			if (i >= 25)
			{
				break;
			}

			if (bro.getSkills().hasSkill("perk.legend_pacifist"))
			{
				continue;
			}

			if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_high"))
			{
				zombieSummonLevel = 7;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_med"))
			{
				zombieSummonLevel = 5;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_zombie_low"))
			{
				zombieSummonLevel = 2;
			}

			if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_high"))
			{
				skeletonSummonLevel = 7;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_med"))
			{
				skeletonSummonLevel = 5;
			}
			else if (bro.getSkills().hasSkill("perk.legend_spawn_skeleton_low"))
			{
				skeletonSummonLevel = 2;
			}

			local brolevel = bro.getLevel();

			// if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
			// {
			// 	this.m.Strength += (3 + (brolevel / 4 + (brolevel - 1)) * 1.5) * broScale;
			// }
			// else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Normal)
			// {
			// 	this.m.Strength += (10 + (brolevel / 2 + (brolevel - 1)) * 2) * broScale;
			// }
			// else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Hard)
			// {
			// 	this.m.Strength += (6 + count / 2 + (brolevel / 2 + this.pow(brolevel, 1.2))) * broScale;
			// }
			// else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Legendary)
			// {
			// 	this.m.Strength += (count + (brolevel + this.pow(brolevel, 1.2))) * broScale;
			// }

            this.m.Strength += (10 + (brolevel / 2 + (brolevel - 1)) * 2) * broScale;

			local mainhand = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);
			local offhand = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			local body = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
			local head = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
			local mainhandvalue = 0;
			local offhandvalue = 0;
			local bodyvalue = 0;
			local headvalue = 0;

			if (mainhand != null)
			{
				mainhandvalue = mainhandvalue + mainhand.getSellPrice() / 1000;
			}

			if (offhand != null)
			{
				offhandvalue = offhandvalue + offhand.getSellPrice() / 1000;
			}

			if (body != null)
			{
				bodyvalue = bodyvalue + body.getSellPrice() / 1000;
			}

			if (head != null)
			{
				headvalue = headvalue + head.getSellPrice() / 1000;
			}

			local gearvalue = mainhandvalue + offhandvalue + bodyvalue + headvalue;
			this.m.Strength += gearvalue;
			count++;
		}
	}
});