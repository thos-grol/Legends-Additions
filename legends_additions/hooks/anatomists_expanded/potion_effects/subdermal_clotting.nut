//"Subdermal Clotting"
//"When this character\'s skin is broken, a substance is secreted that drastically quickens the blood clotting process in the area. Bleeding wounds are much less harmful as a ret, although some blood loss still occurs.";
::mods_hookExactClass("skills/effects/hyena_potion_effect", function (o)
{
    o.create = function()
	{
		this.m.ID = "effects.hyena_potion";
		this.m.Name = "Subdermal Clotting";
		this.m.Icon = "skills/status_effect_143.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_143";
        this.m.Type = this.Const.SkillType.StatusEffect;
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
            }
        ];

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/health.png",
            text = "Damage received from the Bleeding status effect is reduced by " + ::MSU.Text.colorGreen( "50" ) + "%"
        });

        if (this.getContainer().getActor().getFlags().has("ghoul_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
				text = "+" + ::MSU.Text.colorGreen( "30" ) + " Hitpoints"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+" + ::MSU.Text.colorGreen( "30" ) + " Initiative"
            });
        }
        else
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
				text = "+" + ::MSU.Text.colorGreen( "15" ) + " Hitpoints"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+" + ::MSU.Text.colorGreen( "15" ) + " Initiative"
            });
        }

        ret.push({
            id = 12,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
        });
        return ret;
    }

    o.onUpdate <- function(_properties)
    {
        if (this.getContainer().getActor().getFlags().has("ghoul_8"))
        {
            _properties.Hitpoints += 30;
            _properties.Initiative += 30;
        }
        else
        {
            _properties.Hitpoints += 15;
            _properties.Initiative += 15;
        }
    }

});

