//"Hyperactive Tissue Growth";
//"This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal. Deep injuries heal much faster than normal as a ret. They also seem to have developed a strong taste for red meat, but that\'s probably unrelated.";
::mods_hookExactClass("skills/effects/nachzehrer_potion_effect", function (o)
{
    
    local getDescription = o.getDescription;
    o.getDescription = function()
    {
        return "This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal and they gain the speed of nachzehrer. Deep injuries heal much faster than normal as a ret. They also seem to have developed a hunger for red meat, but that\'s probably unrelated.";
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
        
        if (this.getContainer().getActor().getFlags().has("ghoul_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/days_wounded.png",
                text = "Reduces the time it takes to heal from any injury by one day, down to a mininum of one day."
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 20 + "[/color] Initiative"
            });
        }
        else
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/days_wounded.png",
                text = "Reduces the time it takes to heal from any injury by one day, down to a mininum of one day."
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Initiative"
            });
        }
        
        ret.push({
            id = 12,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
        });
        return ret;
    }

    o.onUpdate <- function(_properties)
    {
        if (this.getContainer().getActor().getFlags().has("ghoul_8"))
        {
            _properties.Initiative += 20;
        }
        else
        {
            _properties.Initiative += 10;
        }
        
    }

});