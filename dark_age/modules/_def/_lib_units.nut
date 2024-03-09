::B.Lib.get_ranged_details <- function(_actor)
{
    //default multipliers - unit has 100% melee mult and 50% ranged mult
    local result = {
        melee_mult = 1.0,
        ranged_mult = 0.5,
    };

    //ranged_focus unit has base 50% melee mult and 100% ranged mult
    if (_actor.getSkills().hasSkill("trait._ranged_focus")
        || (!_actor.isPlayerControlled() && _actor.getAIAgent().getProperties().IsRangedUnit)
    )
    {
        result.is_ranged_focus = true;
        result.melee_mult = 0.5;
        result.ranged_mult = 1.0;
    }

    //mastery sets ranged mult to max(0.75, ranged_mult)
    if (_actor.getSkills().hasSkill("perk.mastery.bow")
        || _actor.getSkills().hasSkill("perk.mastery.rangedc"))
    {
        result.is_ranged_focus = true;
        result.ranged_mult = ::Math.max(0.75, result.ranged_mult);
    }

    if (_actor.getSkills().hasSkill("injury.missing_eye"))
            result.ranged_mult *= _actor.getSkills().hasSkill("perk.legend_specialist_cult_armor") ? 0.9 : 0.5;

    local _properties = _actor.getCurrentProperties();
    if (_properties.IsAffectedByInjuries)
    {
        if (::B.Lib.is_injury_applied("injury.grazed_eye_socket"))
            result.ranged_mult *= 0.5;
    }

    if (_properties.IsAffectedByNight)
    {
        if (_actor.getSkills().hasSkill("special.night"))
            result.ranged_mult *= _actor.getSkills().hasSkill("trait.night_owl") ? 0.85 : 0.7;
    }

    if (_properties.IsAffectedByRain)
    {
        if (_actor.getSkills().hasSkill("special.legend_rain"))
            result.ranged_mult *= 0.9;
    }

    return result;
}

::B.Lib.is_injury_applied <- function(_actor, _properties, _id)
{
    local injury = _actor.getSkills().getSkillByID(_id);
    if (injury == null) return false;

    if (!_properties.IsAffectedByFreshInjuries && injury.m.IsFresh) return false;
    return true;
}


//leveling

::B.Lib.level_health <- function( _actor, _times, _stars_min, _stars_max)
{
    local _stars = ::Math.rand(_stars_min, _stars_max);
    local lower = 2;
    local upper = 4;
    if (_stars > 0) lower += 1;
    if (_stars > 1) lower += 1;
    if (_stars > 2) upper += 1;

    for (local i = 0; i < _times; i++)
    {
        local h = ::Math.rand(lower, upper);
        _actor.m.BaseProperties.Hitpoints += h;
        _actor.m.CurrentProperties.Hitpoints += h;
        _actor.m.Hitpoints = _actor.m.BaseProperties.Hitpoints;
        _actor.setHitpoints(_actor.getHitpointsMax());
    }
}

::B.Lib.level_fatigue <- function( _actor, _times, _stars_min, _stars_max)
{
    local _stars = ::Math.rand(_stars_min, _stars_max);
    local lower = 2;
    local upper = 4;
    if (_stars > 0) lower += 1;
    if (_stars > 1) lower += 1;
    if (_stars > 2) upper += 1;

    for (local i = 0; i < _times; i++)
    {
        local b = ::Math.rand(lower, upper);
        _actor.m.BaseProperties.Stamina += b;
        _actor.m.CurrentProperties.Stamina += b;
    }
}

::B.Lib.level_resolve <- function( _actor, _times, _stars_min, _stars_max)
{
    local _stars = ::Math.rand(_stars_min, _stars_max);
    local lower = 2;
    local upper = 4;
    if (_stars > 0) lower += 1;
    if (_stars > 1) lower += 1;
    if (_stars > 2) upper += 1;

    for (local i = 0; i < _times; i++)
    {
        local b = ::Math.rand(lower, upper);
        _actor.m.BaseProperties.Bravery += b;
        _actor.m.CurrentProperties.Bravery += b;
    }
}

::B.Lib.level_initiative <- function( _actor, _times, _stars_min, _stars_max)
{
    local _stars = ::Math.rand(_stars_min, _stars_max);
    local lower = 3;
    local upper = 5;
    if (_stars > 0) lower += 1;
    if (_stars > 1) lower += 1;
    if (_stars > 2) upper += 1;

    for (local i = 0; i < _times; i++)
    {
        local b = ::Math.rand(lower, upper);
        _actor.m.BaseProperties.Initiative += b;
        _actor.m.CurrentProperties.Initiative += b;
    }
}

::B.Lib.level_melee_skill <- function( _actor, _times, _stars_min, _stars_max)
{
    local _stars = ::Math.rand(_stars_min, _stars_max);
    local lower = 1;
    local upper = 3;
    if (_stars > 0) lower += 1;
    if (_stars > 1) lower += 1;
    if (_stars > 2) upper += 1;

    for (local i = 0; i < _times; i++)
    {
        local b = ::Math.rand(lower, upper);
        _actor.m.BaseProperties.MeleeSkill += b;
        _actor.m.CurrentProperties.MeleeSkill += b;
    }
}

::B.Lib.level_strength <- function( _actor, _times, _stars_min, _stars_max)
{
    local _stars = ::Math.rand(_stars_min, _stars_max);
    local lower = 2;
    local upper = 4;
    if (_stars > 0) lower += 1;
    if (_stars > 1) lower += 1;
    if (_stars > 2) upper += 1;

    for (local i = 0; i < _times; i++)
    {
        local b = ::Math.rand(lower, upper);
        _actor.m.BaseProperties.RangedSkill += b;
        _actor.m.CurrentProperties.RangedSkill += b;
    }
}

::B.Lib.level_melee_defense <- function( _actor, _times, _stars_min, _stars_max)
{
    local _stars = ::Math.rand(_stars_min, _stars_max);
    local lower = 1;
    local upper = 3;
    if (_stars > 0) lower += 1;
    if (_stars > 1) lower += 1;
    if (_stars > 2) upper += 1;

    for (local i = 0; i < _times; i++)
    {
        local b = ::Math.rand(lower, upper);
        _actor.m.BaseProperties.MeleeDefense += b;
        _actor.m.CurrentProperties.MeleeDefense += b;
    }
}

::B.Lib.level_ranged_defense <- function( _actor, _times, _stars_min, _stars_max)
{
    local _stars = ::Math.rand(_stars_min, _stars_max);
    local lower = 2;
    local upper = 4;
    if (_stars > 0) lower += 1;
    if (_stars > 1) lower += 1;
    if (_stars > 2) upper += 1;

    for (local i = 0; i < _times; i++)
    {
        local b = ::Math.rand(lower, upper);
        _actor.m.BaseProperties.RangedDefense += b;
        _actor.m.CurrentProperties.RangedDefense += b;
    }
}