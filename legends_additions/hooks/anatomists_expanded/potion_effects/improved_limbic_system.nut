//"Improved Limbic System";
//"This character\'s limbic system has been altered with an additional substance that allows them to sustain particularly strenuous anaerobic activity for longer. Their skin seems vaguely greener than you remember, too, but you\'re sure that\'s a coincidence.";
::mods_hookExactClass("skills/effects/orc_warlord_potion_effect", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Improved Limbic System";
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
                icon = "ui/icons/fatigue.png",
                text = "Using orc weapons no longer imposes additional fatigue costs" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
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
        _properties.Stamina += 10;
    }
});