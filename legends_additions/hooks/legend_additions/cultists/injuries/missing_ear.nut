// "injury.missing_ear"
::mods_hookExactClass("skills/injury_permanent/missing_ear_injury", function (o)
{
	o.getNameP <- function() { return "Missing Ear" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.isContent <- function() { return false; }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::MSU.Text.colorRed( has ? "-5%" : "-10%") + " Initiative"
		});
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.InitiativeMult *= has ? 0.95 : 0.9;
	}
});