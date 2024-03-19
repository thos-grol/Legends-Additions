// injury.traumatized
::mods_hookExactClass("skills/injury_permanent/traumatized_injury", function (o)
{
	o.getNameP <- function() { return "Fanatic" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/bravery.png",
			text = ::MSU.Text.colorRed( has ? "+20%" : "-40%") + " Will"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/initiative.png",
			text = ::MSU.Text.colorRed( has ? "+15%" : "-30%") + " Agility"
		});
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.BraveryMult *= has ? 1.2 : 0.6;
		_properties.InitiativeMult *= has ? 1.15 : 0.7;
		_properties.IsContentWithBeingInReserve = true;
	}
});