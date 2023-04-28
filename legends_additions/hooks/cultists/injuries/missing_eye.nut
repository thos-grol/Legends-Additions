// "injury.missing_eye"
::mods_hookExactClass("skills/injury_permanent/missing_eye_injury", function (o)
{
	o.getNameP <- function() { return "Missing Eye" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.isContent <- function() { return false; }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-50%") + " Ranged Skill"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/vision.png",
			text = ::MSU.Text.colorRed( has ? "-1" : "-2") + " Vision"
		});
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.RangedSkillMult *= has ? 0.9 : 0.5;
		_properties.Vision -= has ? 1 : 2;
	}

	o.onApplyAppearance = function()
	{
		try {
			local sprite = this.getContainer().getActor().getSprite("permanent_injury_4");
			sprite.setBrush("permanent_injury_04");
			sprite.Visible = true;
		} catch(exception) {}
	}
});