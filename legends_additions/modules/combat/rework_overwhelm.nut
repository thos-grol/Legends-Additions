//Provides overwhelm immunity to tagged enemies.

::Const.Strings.PerkDescription.Overwhelm = "Overwhelm the enemy with the speed of your attacks."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n• Every attack, hit or miss, against an opponent that acts after you in the current round, inflict the \'Overwhelmed\' status effect which lowers both Melee Skill and Ranged Skill by [color=" + this.Const.UI.Color.NegativeValue + "]5%[/color] for one turn."
+ "\n• The effect stacks with each attack, and can be applied to multiple targets at once with a single attack."
+ "\n• Some targets such as big monsters are immune to being overwhelmed.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Overwhelm].Tooltip = ::Const.Strings.PerkDescription.Overwhelm;

::mods_hookExactClass("skills/perks/perk_overwhelm", function (o)
{
    local onTargetHit = o.onTargetHit;
    o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
    {
        if (_skill.isRanged()) return;
        if (_targetEntity.getFlags().has("immunity_overwhelm")) return;
        onTargetHit(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor);
    }

    local onTargetMissed = o.onTargetMissed;
    o.onTargetMissed = function( _skill, _targetEntity )
    {
        if (_skill.isRanged()) return;
        if (_targetEntity.getFlags().has("immunity_overwhelm")) return;
        onTargetMissed(_skill, _targetEntity);
    }
});