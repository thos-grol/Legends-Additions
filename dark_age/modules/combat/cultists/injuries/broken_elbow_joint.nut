// "Broken Elbow Joint"
// "injury.broken_elbow_joint"
// "A broken elbow that never fully healed hinders all movement of the arm and severely reduces combat effectiveness."
// "ui/injury/injury_permanent_icon_08.png";
::mods_hookExactClass("skills/injury_permanent/broken_elbow_joint_injury", function (o)
{
	o.getNameP <- function() { return "Warped Elbow Joint" }
	o.getTooltip = function() { return this.permanent_injury.getTooltip() }
	o.getTooltipHelper <- function( has )
	{
		local ret = [];
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-20%") + " Melee Skill"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/ranged_skill.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-20%") + " Ranged Skill"
		});
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = ::MSU.Text.colorRed( has ? "-10%" : "-30%") + " Melee Defense"
		});
		return ret;
	}

	o.onUpdate = function( _properties )
	{
		local has = this.has_penance();
		_properties.MeleeSkillMult *= has ? 0.9 : 0.8;
		_properties.RangedSkillMult *= has ? 0.9 : 0.8;
		_properties.MeleeDefenseMult *= has ? 0.9 : 0.7;
		_properties.IsContentWithBeingInReserve = true;
	}

});