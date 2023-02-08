//"Locking Joints";
//"This character\'s body has mutated such that they can lock their limbs into certain positions almost indefinitely, allowing them to brace against blows while barely breaking a sweat.";
::mods_hookExactClass("skills/effects/skeleton_warrior_potion_effect", function (o)
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
                text = "Reduces the Fatigue cost of the \'Shieldwall\' skill by [color=" + ::Const.UI.Color.PositiveValue + "]" + 100 * (1 - ::Const.Combat.WeaponSpecFatigueMult) + "%[/color]" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
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
        _properties.MeleeDefense += 10;
        _properties.Stamina += 10;
    }
});