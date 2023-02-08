//"Subdermal Stitching";
//"This character\'s skin and subdermal tissue has mutated and will rapidly stitch itself back together. The effect is most pronounced on small puncture wounds, where the flesh can seal the wound from all directions evenly.";
::mods_hookExactClass("skills/effects/honor_guard_potion_effect", function (o)
{
    o.create = function()
	{
		this.m.ID = "effects.honor_guard_potion";
		this.m.Name = "Subdermal Stitching";
		this.m.Icon = "skills/status_effect_132.png";
		this.m.IconMini = "status_effect_132_mini";
		this.m.Overlay = "status_effect_132";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

    o.getTooltip = function()
    {
        local ret = [
            {
                id = 1,
                type = "title",
                text = this.getName()
            },
            {
                id = 2,
                type = "description",
                text = this.getDescription()
            },
            {
                id = 11,
                type = "text",
                icon = "ui/icons/morale.png",
                text = "This character takes between [color=" + ::Const.UI.Color.PositiveValue + "]25%[/color] and [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color] less damage from piercing attacks, such as those from bows or spears" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
            },
            {
                id = 12,
                type = "hint",
                icon = "ui/tooltips/warning.png",
                text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
            }
        ];
        return ret;
    }

    o.onUpdate <- function(_properties)
    {
        _properties.Hitpoints += 10;
    }

});