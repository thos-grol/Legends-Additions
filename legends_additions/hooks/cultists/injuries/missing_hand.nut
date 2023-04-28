// "injury.missing_hand"
::mods_hookExactClass("skills/injury_permanent/missing_hand_injury", function (o)
{
	o.getNameP <- function() { return "Grasp of Hadar" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.isContent <- function() { return false; }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		if (has)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Eldritch blast can now be toggled between pulling and pushing."
			});
		}
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		// local has = this.has_penance();
		// _properties.MeleeDefenseMult *= has ? 0.9 : 0.6;
		// _properties.RangedDefenseMult *= has ? 0.9 : 0.6;
		// _properties.InitiativeMult *= has ? 0.9 : 0.6;
		// _properties.IsContentWithBeingInReserve = true;
	}
});