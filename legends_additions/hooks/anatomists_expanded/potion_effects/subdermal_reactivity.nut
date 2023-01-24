//"Subdermal Reactivity";
//"It\'s just a flesh wound! This character\'s subdermal flesh has mutated and automatically reacts to sudden trauma, lessening the chance to suffer injuries in battle.";
::mods_hookExactClass("skills/effects/wiederganger_potion_effect", function (o)
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
            },
            {
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "The threshold to sustain injuries on getting hit is increased by [color=" + ::Const.UI.Color.PositiveValue + "]33%[/color]" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
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

    local onUpdate = o.onUpdate;
    o.onUpdate = function(_properties)
    {
        onUpdate(_properties);
        _properties.Hitpoints += 10;
    }
});