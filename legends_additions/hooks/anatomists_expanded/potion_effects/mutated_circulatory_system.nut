//Mutated Circulatory System
//This character's body has mutated and propagates poisons and other hazardous substances through the bloodstream much more slowly, allowing them to be disposed of without serious health effects. Curiously, this doesn't seem to affect their ability to get drunk.
::mods_hookExactClass("skills/effects/webknecht_potion_effect", function (o)
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

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Immune to poison effects"
        });

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Not affected by nighttime penalties"
        });

        if (this.getContainer().getActor().getFlags().has("spider_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_defense.png",
				text = "+" + ::MSU.Text.colorGreen( "15" ) + " Melee Defense"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+" + ::MSU.Text.colorGreen( "20" ) + " Hitpoints"
            });
        }
        else if (this.getContainer().getActor().getFlags().has("spider"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_defense.png",
				text = "+" + ::MSU.Text.colorGreen( "7" ) + " Melee Defense"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+" + ::MSU.Text.colorGreen( "10" ) + " Hitpoints"
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
        _properties.IsImmuneToPoison = true;
        _properties.IsAffectedByNight = false;

        if (this.getContainer().getActor().getFlags().has("spider_8"))
        {
            _properties.MeleeDefense += 7;
            _properties.Hitpoints += 10;
        }
        else if (this.getContainer().getActor().getFlags().has("spider"))
        {
            _properties.MeleeDefense += 15;
            _properties.Hitpoints += 20;
        }
    }
});