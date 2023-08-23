::Z.Log.Color <- {};
::Z.Log.Color.BloodRed <- "#900C3F";

::Z.Log.shot_astray <- function(_user, _targetEntity, _skill_name, rolled, toHit)
{
    ::Tactical.EventLog.logEx(_user + " [" + _skill_name + "] " + _targetEntity + ::MSU.Text.color(::Z.Log.Color.BloodRed, " [Astray]\t") + "(" + rolled + " vs " + ::Math.min(95, ::Math.max(5, toHit))+ ")");
};

::Z.Log.melee_hit <- function(_user, _targetEntity, _skill_name, rolled, toHit)
{
    ::Tactical.EventLog.logEx(_user + " [" + _skill_name + "] " + _targetEntity + ::MSU.Text.colorGreen(" [HIT] » ") + "(" + rolled + " vs " + ::Math.min(95, ::Math.max(5, toHit))+ ")");
};

::Z.Log.melee_miss <- function(_user, _targetEntity, _skill_name, rolled, toHit)
{
    ::Tactical.EventLog.logEx(_user + " [" + _skill_name + "] " + _targetEntity + ::MSU.Text.color(::Z.Log.Color.BloodRed, " [MISS] » ") + "(" + rolled + " vs " + ::Math.min(95, ::Math.max(5, toHit))+ ")");
};

::Z.Log.hair_armor <- function()
{
    ::Tactical.EventLog.logEx("=== [" + ::MSU.Text.colorRed("Hair Armor") + "] nullified direct damage.");
};

//TODO: remove "Invalid Target"
//TODO: log helper skill that indents log on end turn or unit.
//TODO: denote new global turn