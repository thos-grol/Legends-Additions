// "Broken Knee"
// "injury.broken_knee"
// "This character took something to the knee, and it never fully healed. Lunging forward or dodging can be painful, and it lacks any grace."
// "ui/injury/injury_permanent_icon_11.png";
::mods_hookExactClass("skills/injury_permanent/broken_knee_injury", function (o)
{
	o.getNameP <- function() { return "Warped Knee" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-40%") + " Melee Defense"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-40%") + " Ranged Defense"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::MSU.Text.colorRed( has ? "-20%" : "-40%") + " Initiative"
		});
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.MeleeDefenseMult *= has ? 0.9 : 0.6;
		_properties.RangedDefenseMult *= has ? 0.9 : 0.6;
		_properties.InitiativeMult *= has ? 0.8 : 0.6;
		_properties.IsContentWithBeingInReserve = true;
	}
});