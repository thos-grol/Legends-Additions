//this function imprints the living's information on the corpse for use
::Z.Lib.imprint_corpse <- function(_actor, _tile)
{
    local corpse = _tile.Properties.get("Corpse");

    corpse.Skills <- [];
    corpse.BaseProperties <- {};
    // corpse.FleshNotAllowed <- true; //this marker determines if raising flesh is disallowed

    local skills = _actor.m.Skills.m.Skills
    foreach(skill in skills)
    {
        if (!skill.isGarbage()) corpse.Skills.push(skill);
    }

    corpse.BaseProperties["Bravery"] <- _actor.m.BaseProperties.Bravery;
    corpse.BaseProperties["Initiative"] <- _actor.m.BaseProperties.Initiative;
    corpse.BaseProperties["MeleeSkill"] <- _actor.m.BaseProperties.MeleeSkill;
    corpse.BaseProperties["MeleeSkill"] <- _actor.m.BaseProperties.MeleeSkill;
    corpse.BaseProperties["RangedSkill"] <- _actor.m.BaseProperties.RangedSkill;
    corpse.BaseProperties["MeleeDefense"] <- _actor.m.BaseProperties.MeleeDefense;
    corpse.BaseProperties["RangedDefense"] <- _actor.m.BaseProperties.RangedDefense;
}