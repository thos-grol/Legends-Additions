// injury.weakened_heart
::mods_hookExactClass("skills/injury_permanent/weakened_heart_injury", function (o)
{
	o.getNameP <- function() { return "Black Heart" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/health.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-30%") + " Hitpoints"
		});
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.HitpointsMult *= has ? 0.9 : 0.7;
		_properties.IsContentWithBeingInReserve = true;
	}
});