//"injury.collapsed_lung_part"
//"Partly Collapsed Lung"
//"A part of the lung has died, making it very hard for this character to catch breath."
//"ui/injury/injury_permanent_icon_05.png"
::mods_hookExactClass("skills/injury_permanent/collapsed_lung_part_injury", function (o)
{
	o.getNameP <- function() { return "Reshaped Lung" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-40%") + " Max Fatigue"
		});
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.StaminaMult *= has ? 0.9 : 0.6;
		_properties.IsContentWithBeingInReserve = true;
	}

});