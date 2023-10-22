::B.Lib.level_health <- function( _actor, _times, _stars )
{
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

::B.Lib.level_fatigue <- function( _actor, _times, _stars )
{
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

::B.Lib.level_resolve <- function( _actor, _times, _stars )
{
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

::B.Lib.level_initiative <- function( _actor, _times, _stars )
{
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

::B.Lib.level_melee_skill <- function( _actor, _times, _stars )
{
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

::B.Lib.level_ranged_skill <- function( _actor, _times, _stars )
{
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

::B.Lib.level_melee_defense <- function( _actor, _times, _stars )
{
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

::B.Lib.level_ranged_defense <- function( _actor, _times, _stars )
{
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