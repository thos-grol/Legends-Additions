::Z.Perks <- {};
::Z.Perks.addPerk <- function (_actor, _perk, _perk_row)
{
    //if has skill, remove and refund
    if (_actor.getSkills().hasSkill(::Const.Perks.PerkDefObjects[_perk].ID))
    {
        _actor.getSkills().removeByID(::Const.Perks.PerkDefObjects[_perk].ID);
        ++_actor.m.PerkPoints;
    }
    //if perk exists, remove it from the tree
    if (_actor.getBackground().hasPerk(_perk)) _actor.getBackground().removePerk(_perk)

    //add non-refundable version of perk to tree and add the perk to skills
    _actor.getBackground().addPerk(_perk, _perk_row, false);
    _actor.getSkills().add(::new(::Const.Perks.PerkDefObjects[_perk].Script));
}

::Z.Perks.removePerk <- function (_actor, _perk_id, _perk)
{
    //if has skill, remove and refund
    if (_actor.getSkills().hasSkill(_perk_id))
    {
        _actor.getSkills().removeByID(_perk_id);
    }
    //if perk exists, remove it from the tree
    if (_actor.getBackground().hasPerk(_perk)) _actor.getBackground().removePerk(_perk)
}