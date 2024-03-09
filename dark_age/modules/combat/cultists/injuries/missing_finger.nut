// injury.missing_finger
::mods_hookExactClass("skills/injury_permanent/missing_finger_injury", function (o)
{
	o.getNameP <- function() { return "Finger of Death" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.isContent <- function() { return false; }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		if (!has)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]-5%[/color] Skill"
			});
		}
		else
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Eldritch blast now has a 44% chance to drain enemies"
			});
		}
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.MeleeSkillMult *= has ? 1.0 : 0.95;
	}
});