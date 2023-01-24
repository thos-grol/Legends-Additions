//"Hyperactive Glands";
//"This character\'s adrenaline and hormonal glands have mutated, causing a constant heightened emotional state. They can mostly keep this under control in camp, but in high-stress situations the effect is much stronger and fills them with an intense, unconsolable rage.";
::mods_hookExactClass("skills/effects/orc_berserker_potion_effect", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Hyperactive Glands";
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
                icon = "ui/icons/special.png",
                text = "This character gains two stacks of Rage each time they take hitpoint damage, and loses one stack at the end of each turn."
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
});