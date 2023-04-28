//"injury.missing_nose"
::mods_hookExactClass("skills/injury_permanent/missing_nose_injury", function (o)
{
	o.getNameP <- function() { return "Eldritch Nose" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.isContent <- function() { return false; }
	o.getTooltipHelper <- function( has )
	{
        local ret = [];
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = ::MSU.Text.colorRed( has ? "-5%" : "-10%") + " Max Fatigue"
		});
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.StaminaMult *= has ? 0.95 : 0.9;
	}

	o.onApplyAppearance = function()
	{
		try {
			local sprite = this.getContainer().getActor().getSprite("permanent_injury_3");
			sprite.setBrush("permanent_injury_03");
			sprite.Visible = true;
		} catch(exception) {}
	}

});