::mods_hookExactClass("entity/tactical/actor", function(o) {

    o.level_health <- function( times, stars )
	{
        local lower = 2;
        local upper = 4;
        if (stars > 0) lower += 1;
        if (stars > 1) lower += 1;
        if (stars > 2) upper += 1;

        for (local i = 0; i < times; i++)
        {
            local h = this.Math.rand(lower, upper);
            this.m.BaseProperties.Hitpoints += h;
            this.m.CurrentProperties.Hitpoints += h;
            this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
            this.setHitpoints(this.getHitpointsMax());
        }
	}

    o.level_fatigue <- function( times, stars )
	{
        local lower = 2;
        local upper = 4;
        if (stars > 0) lower += 1;
        if (stars > 1) lower += 1;
        if (stars > 2) upper += 1;

        for (local i = 0; i < times; i++)
        {
            local b = this.Math.rand(lower, upper);
            this.m.BaseProperties.Stamina += b;
            this.m.CurrentProperties.Stamina += b;
        }
	}

    o.level_resolve <- function( times, stars )
	{
        local lower = 2;
        local upper = 4;
        if (stars > 0) lower += 1;
        if (stars > 1) lower += 1;
        if (stars > 2) upper += 1;

        for (local i = 0; i < times; i++)
        {
            local b = this.Math.rand(lower, upper);
            this.m.BaseProperties.Bravery += b;
            this.m.CurrentProperties.Bravery += b;
        }
	}

    o.level_initiative <- function( times, stars )
	{
        local lower = 3;
        local upper = 5;
        if (stars > 0) lower += 1;
        if (stars > 1) lower += 1;
        if (stars > 2) upper += 1;

        for (local i = 0; i < times; i++)
        {
            local b = this.Math.rand(lower, upper);
            this.m.BaseProperties.Initiative += b;
            this.m.CurrentProperties.Initiative += b;
        }
	}

    o.level_melee_skill <- function( times, stars )
	{
        local lower = 1;
        local upper = 3;
        if (stars > 0) lower += 1;
        if (stars > 1) lower += 1;
        if (stars > 2) upper += 1;

        for (local i = 0; i < times; i++)
        {
            local b = this.Math.rand(lower, upper);
            this.m.BaseProperties.MeleeSkill += b;
            this.m.CurrentProperties.MeleeSkill += b;
        }
	}

    o.level_ranged_skill <- function( times, stars )
	{
        local lower = 2;
        local upper = 4;
        if (stars > 0) lower += 1;
        if (stars > 1) lower += 1;
        if (stars > 2) upper += 1;

        for (local i = 0; i < times; i++)
        {
            local b = this.Math.rand(lower, upper);
            this.m.BaseProperties.RangedSkill += b;
            this.m.CurrentProperties.RangedSkill += b;
        }
	}

    o.level_melee_defense <- function( times, stars )
	{
        local lower = 1;
        local upper = 3;
        if (stars > 0) lower += 1;
        if (stars > 1) lower += 1;
        if (stars > 2) upper += 1;

        for (local i = 0; i < times; i++)
        {
            local b = this.Math.rand(lower, upper);
            this.m.BaseProperties.MeleeDefense += b;
            this.m.CurrentProperties.MeleeDefense += b;
        }
	}

    o.level_ranged_defense <- function( times, stars )
	{
        local lower = 2;
        local upper = 4;
        if (stars > 0) lower += 1;
        if (stars > 1) lower += 1;
        if (stars > 2) upper += 1;

        for (local i = 0; i < times; i++)
        {
            local b = this.Math.rand(lower, upper);
            this.m.BaseProperties.RangedDefense += b;
            this.m.CurrentProperties.RangedDefense += b;
        }
	}
});