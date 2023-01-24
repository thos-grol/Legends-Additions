//"Reactive Leg Muscles";
//"This character\'s legs have been mutated, allowing them to make swift, complex movements more smoothly and with greater rapidity. When at rest, the muscles can still occasionally be seen twitching underneath the skin.";
::mods_hookExactClass("skills/effects/goblin_grunt_potion_effect", function(o) {
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
                icon = "ui/icons/action_points.png",
                text = "The Action Point costs of the Rotation and Footwork skills are reduced to [color=" + ::Const.UI.Color.PositiveValue + "]2[/color]"
            },
            {
                id = 12,
                type = "text",
                icon = "ui/icons/fatigue.png",
                text = "The Fatigue costs of the Rotation and Footwork skills are reduced by [color=" + ::Const.UI.Color.PositiveValue + "]50%[/color]" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+5[/color] Initiative"
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
        _properties.Initiative += 5;
    }

});
