::Z.Log.Color <- {};
::Z.Log.Color.BloodRed <- "#900C3F";
::Z.Log.Color.NiceGreen <- "#229954";

// function getColorizedEntityName( _entity )
// 	{
// 		if (_entity.isPlayerControlled() || _entity.getFaction() == this.Const.Faction.PlayerAnimals)
// 		{
// 			return "[color=#1e468f]" + _entity.getName() + "[/color]";
// 		}
// 		else
// 		{
// 			return "[color=#8f1e1e]" + _entity.getName() + "[/color]";
// 		}
// 	}

//HELPER FNS

::Z.Log.display_basic <- function(_user, _targetEntity, _skill_name)
{
    return ::Const.UI.getColorizedEntityName(_user) + " [" + _skill_name + "]" + _targetEntity != null ? " " + ::Const.UI.getColorizedEntityName(_targetEntity): "";
}

::Z.Log.display_result <- function(_result_string, is_good)
{
    return ::MSU.Text.color(is_good ? ::Z.Log.Color.NiceGreen : ::Z.Log.Color.BloodRed, " " + "[" + _result_string + "]" + " ");
}

::Z.Log.display_chance <- function(rolled, toHit)
{
    return " » (" + rolled + " vs " + ::Math.min(95, ::Math.max(5, toHit))+ ")";
}

//FNS

::Z.Log.next_round <- function(_turn)
{
    ::Tactical.EventLog.logEx("\n\n=== Round " + _turn + " ===\n\n");
};

::Z.Log.next_turn <- function()
{
    ::Tactical.EventLog.logEx("\n");
};

::Z.Log.skill <- function(_user, _targetEntity, _skill_name, rolled, toHit, _result_string, is_good=true, is_showing_chance=true)
{
    ::Tactical.EventLog.logEx(::Z.Log.display_basic(_user, _targetEntity, _skill_name) + ::Z.Log.display_result(_result_string, is_good) + is_showing_chance ? ::Z.Log.display_chance(rolled, toHit) : "");
};

::Z.Log.damage_armor <- function(_targetEntity, _target, _cur, _prev, _damage)
{
    ::Tactical.EventLog.logEx("=== [" + ::Const.UI.getColorizedEntityName(_targetEntity) + "]" + "[" + _target + "]" + _cur == 0 ? ::MSU.Text.color(::Z.Log.Color.BloodRed, "[DESTROYED]") : "" + " ~ " + ::MSU.Text.color(::Z.Log.Color.BloodRed, _prev) + " » " + ::MSU.Text.color(::Z.Log.Color.BloodRed, _cur) + " ([b]" + ::MSU.Text.color(::Z.Log.Color.BloodRed, _damage) + "[/b])");
};

::Z.Log.damage_body <- function(_targetEntity, _target, _cur, _prev, _damage)
{
    ::Tactical.EventLog.logEx("=== [" + ::Const.UI.getColorizedEntityName(_targetEntity) + "]" + "[" + _target + "]" + _cur == 0 ? ::MSU.Text.color(::Z.Log.Color.BloodRed, "[KILLED]") : "" + " ~ " + ::MSU.Text.color(::Z.Log.Color.BloodRed, _prev) + " » " + ::MSU.Text.color(::Z.Log.Color.BloodRed, _cur) + " ([b]" + ::MSU.Text.color(::Z.Log.Color.BloodRed, _damage) + "[/b])");
};

::Z.Log.suffer_injury <- function(_targetEntity, _injury)
{
    ::Tactical.EventLog.logEx("=== [" + ::Const.UI.getColorizedEntityName(_targetEntity) + "] suffers " + "[" + ::MSU.Text.color(::Z.Log.Color.BloodRed, _injury) + "]");
};

::Z.Log.hair_armor <- function()
{
    ::Tactical.EventLog.logEx("=== [" + ::MSU.Text.colorRed("Hair Armor") + "] nullified direct damage.");
};

::Z.Log.nine_lives <- function(_targetEntity)
{
    ::Tactical.EventLog.logEx("=== [" + ::Const.UI.getColorizedEntityName(_targetEntity) + "] triggers [" + ::MSU.Text.colorRed("Nine Lives") + "]");
};