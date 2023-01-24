//"Shock Absorbant Wrists";
//"This character\'s wrists have mutated in such a way that the they dampen the initial shock of opposing forces. In more practical terms, they reduce the protective qualities of an enemy\'s armor when struck. They can also make some pretty outlandish shadow puppets.";
::mods_hookExactClass("skills/effects/orc_young_potion_effect", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Shock Absorbant Wrists";
    }

    local getDescription = o.getDescription;
    o.getDescription = function()
    {
        return "This character\'s wrists have mutated in such a way that the they dampen the initial shock of opposing forces. In more practical terms, this lets them hit harder. They can also make some pretty outlandish shadow puppets.";
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

        if (this.getContainer().getActor().getFlags().has("orc_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_skill.png",
                text = "Attacks do [color=" + ::Const.UI.Color.PositiveValue + "]+20%[/color] additional damage"
            });
        }
        else
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_skill.png",
                text = "Attacks do [color=" + ::Const.UI.Color.PositiveValue + "]+10%[/color] additional damage"
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

    o.onUpdate = function(_properties)
    {
        if (this.getContainer().getActor().getFlags().has("orc_8"))
        {
            _properties.DamageTotalMult *= 1.2;
        }
        else
        {
            _properties.DamageTotalMult *= 1.10;
        }
    }
});