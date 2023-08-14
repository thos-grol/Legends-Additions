//"injury.maimed_foot"
::mods_hookExactClass("skills/injury_permanent/maimed_foot_injury", function (o)
{
	o.getNameP <- function() { return "Warped Knee" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/action_points.png",
			text = "[color=" + ::Const.UI.Color.NegativeValue + "]1[/color] Additional Action Point per tile moved"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-20%") + " Initiative"
		});
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.MovementAPCostAdditional += 1;
		_properties.InitiativeMult *= has ? 0.9 : 0.8;
		_properties.IsContentWithBeingInReserve = true;
	}
});