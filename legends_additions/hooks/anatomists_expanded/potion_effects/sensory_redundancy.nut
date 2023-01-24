//"Sensory Redundancy";
//"This character\'s body has mutated to develop a number of redundant synapses, allowing them to maintain a degree of control over sight, hearing, and muscle control even when struck with debilitating blows.";
::mods_hookExactClass("skills/effects/orc_warrior_potion_effect", function (o)
{
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

        if (this.getContainer().getActor().getFlags().has("orc_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "[color=" + ::Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+20[/color] Hitpoints"
            });
        }
        else
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "[color=" + ::Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
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

    local onUpdate = o.onUpdate;
    o.onUpdate = function(_properties)
    {
        onUpdate(_properties);
        if (this.getContainer().getActor().getFlags().has("orc_8"))
        {
            _properties.Hitpoints += 20;
        }
        else
        {
            _properties.Hitpoints += 10;
        }
    }
});