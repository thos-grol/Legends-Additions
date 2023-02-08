
::Const.Tactical.Actor.Lindwurm = {
    XP = 800,
    ActionPoints = 7,
    Hitpoints = 1100,
    Bravery = 250,
    Stamina = 400,
    MeleeSkill = 80,
    RangedSkill = 0,
    MeleeDefense = 10,
    RangedDefense = -10,
    Initiative = 80,
    FatigueEffectMult = 1.0,
    MoraleEffectMult = 1.0,
    FatigueRecoveryRate = 30,
    Armor = [
        300,
        500
    ]
};

::mods_hookExactClass("entity/tactical/enemies/lindwurm", function (o)
{
    local onInit = o.onInit;
    o.onInit = function()
    {
        onInit();
        this.m.Skills.add(::new("scripts/skills/passives/dragons_might"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel"));

    }
});

::mods_hookExactClass("skills/racial/lindwurm_racial", function (o)
{
    o.onDamageReceived = function(_attacker, _damageHitpoints, _damageArmor)
    {
        if (_damageHitpoints <= 5) return;
        local _actor = this.getContainer().getActor();
        local targets = [_attacker];

        if (_damageHitpoints >= 50)
        {
            targets = [];
            local mytile = _tag.User.getTile();
            local actors = this.Tactical.Entities.getAllInstances();

            foreach( i in actors )
            {
                foreach( a in i )
                {
                    if (a.getID() != _actor.getID() && a.getTile().getDistanceTo(mytile) < 3) targets.append(a);
                }
            }

        }

        foreach(target in targets)
        {
            if (target == null || !target.isAlive()) continue;
            if (target.getTile().getDistanceTo(_actor.getTile()) >= 3) continue;
            if (target.getFlags().has("lindwurm")) continue;
            if (target.getFlags().has("body_immune_to_acid") && target.getFlags().has("head_immune_to_acid")) continue;

            local poison = target.getSkills().getSkillByID("effects.lindwurm_acid");
            if (poison == null) target.getSkills().add(::new("scripts/skills/effects/lindwurm_acid_effect"));
            else poison.resetTime();
            this.spawnIcon("status_effect_78", target.getTile());
        }
    }
});