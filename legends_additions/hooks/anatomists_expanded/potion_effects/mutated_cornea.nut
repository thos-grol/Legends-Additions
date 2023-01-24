//"Mutated Cornea";
//"This character\'s eyes have been permanently mutated and are now capable of detecting the subtlest movements of wind and air. While minor on its own, this allows them to better predict the trajectory of projectile attacks and better land hits on vulnerable parts of a target.";

::mods_hookExactClass("skills/effects/goblin_overseer_potion_effect", function (o)
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
                icon = "ui/icons/morale.png",
                text = "An additional [color=" + ::Const.UI.Color.PositiveValue + "]15%[/color] of damage ignores armor when using bows or crossbows" + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+10[/color] Ranged Skill"  + "\n[color=" + ::Const.UI.Color.PositiveValue + "]+15[/color] Ranged Defense"
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

    o.onUpdate = function(_properties)
    {
        _properties.IsSharpshooter = true;
        _properties.RangedSkill += 10;
        _properties.RangedDefense += 15;
    }
});

//Modify Ranged Damage
::mods_hookExactClass("skills/actives/aimed_shot", function (o)
{
    local onAnySkillUsed = o.onAnySkillUsed;
    o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
    {
        onAnySkillUsed( _skill, _targetEntity, _properties);
        if (_skill == this && _properties.IsSharpshooter) _properties.DamageDirectMult = 0.15;
    }
});

::mods_hookExactClass("skills/actives/quick_shot", function (o)
{
    local onAnySkillUsed = o.onAnySkillUsed;
    o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
    {
        onAnySkillUsed( _skill, _targetEntity, _properties);
        if (_skill == this && _properties.IsSharpshooter) _properties.DamageDirectMult = 0.15;
    }
});

::mods_hookExactClass("skills/actives/shoot_bolt", function (o)
{
    local onAnySkillUsed = o.onAnySkillUsed;
    o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
    {
        onAnySkillUsed( _skill, _targetEntity, _properties);
        if (_skill == this && _properties.IsSharpshooter) _properties.DamageDirectMult = 0.15;
    }
});

::mods_hookExactClass("skills/actives/shoot_stake", function (o)
{
    local onAnySkillUsed = o.onAnySkillUsed;
    o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
    {
        onAnySkillUsed( _skill, _targetEntity, _properties);
        if (_skill == this && _properties.IsSharpshooter) _properties.DamageDirectMult = 0.15;
    }
});