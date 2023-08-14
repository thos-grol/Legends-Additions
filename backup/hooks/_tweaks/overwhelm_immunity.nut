//TODO: change to tag
::mods_hookExactClass("skills/perks/perk_overwhelm", function (o)
{
    local onTargetHit = o.onTargetHit;
    o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
    {
        if (_skill.isRanged()) return;
        if (_targetEntity.getType() == ::Const.EntityType.Lindwurm || _targetEntity.getType() == ::Const.EntityType.LegendStollwurm) return;
        onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
    }

    local onTargetMissed = o.onTargetMissed;
    o.onTargetMissed = function( _skill, _targetEntity )
    {
        if (_skill.isRanged()) return;
        if (_targetEntity.getType() == ::Const.EntityType.Lindwurm || _targetEntity.getType() == ::Const.EntityType.LegendStollwurm) return;
        onTargetMissed(_skill, _targetEntity);
    }
});