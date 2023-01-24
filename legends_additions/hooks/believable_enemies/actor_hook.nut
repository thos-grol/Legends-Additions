::mods_hookExactClass("entity/tactical/actor", function(o) {

    o.level_health <- function( times, stars )
	{
        local lower = 2
        local upper = 4
        if (stars > 0) lower += 1
        if (stars > 1) lower += 1
        if (stars > 2) upper += 1

        for (local i = 0; i < times; i++)
        {
            this.m.BaseProperties.Hitpoints += this.Math.rand(lower, upper);
        }
	}

    o.level_fatigue <- function( times, stars )
	{
        local lower = 2
        local upper = 4
        if (stars > 0) lower += 1
        if (stars > 1) lower += 1
        if (stars > 2) upper += 1

        for (local i = 0; i < times; i++)
        {
            this.m.BaseProperties.Stamina += this.Math.rand(lower, upper);
        }
	}

    o.level_resolve <- function( times, stars )
	{
        local lower = 2
        local upper = 4
        if (stars > 0) lower += 1
        if (stars > 1) lower += 1
        if (stars > 2) upper += 1

        for (local i = 0; i < times; i++)
        {
            this.m.BaseProperties.Bravery += this.Math.rand(lower, upper);
        }
	}

    o.level_initiative <- function( times, stars )
	{
        local lower = 3
        local upper = 5
        if (stars > 0) lower += 1
        if (stars > 1) lower += 1
        if (stars > 2) upper += 1

        for (local i = 0; i < times; i++)
        {
            this.m.BaseProperties.Initiative += this.Math.rand(lower, upper);
        }
	}

    o.level_melee_skill <- function( times, stars )
	{
        local lower = 1
        local upper = 3
        if (stars > 0) lower += 1
        if (stars > 1) lower += 1
        if (stars > 2) upper += 1

        for (local i = 0; i < times; i++)
        {
            this.m.BaseProperties.MeleeSkill += this.Math.rand(lower, upper);
        }
	}

    o.level_ranged_skill <- function( times, stars )
	{
        local lower = 2
        local upper = 4
        if (stars > 0) lower += 1
        if (stars > 1) lower += 1
        if (stars > 2) upper += 1

        for (local i = 0; i < times; i++)
        {
            this.m.BaseProperties.RangedSkill += this.Math.rand(lower, upper);
        }
	}

    o.level_melee_defense <- function( times, stars )
	{
        local lower = 1
        local upper = 3
        if (stars > 0) lower += 1
        if (stars > 1) lower += 1
        if (stars > 2) upper += 1

        for (local i = 0; i < times; i++)
        {
            this.m.BaseProperties.MeleeDefense += this.Math.rand(lower, upper);
        }
	}

    o.level_ranged_defense <- function( times, stars )
	{
        local lower = 2
        local upper = 4
        if (stars > 0) lower += 1
        if (stars > 1) lower += 1
        if (stars > 2) upper += 1

        for (local i = 0; i < times; i++)
        {
            this.m.BaseProperties.RangedDefense += this.Math.rand(lower, upper);
        }
	}
});