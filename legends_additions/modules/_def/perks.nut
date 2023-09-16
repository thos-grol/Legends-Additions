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

::Z.Perks.getTreeFromItem <- function (_item)
{
    if (_item.isItemType(::Const.Items.ItemType.Shield)) return ::Const.Perks.ShieldTree.Tree;
    else if (_item.m.ID == "tool.throwing_net") return ::Const.Perks.BeastClassTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Flail)) return ::Const.Perks.FlailTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Hammer)) return ::Const.Perks.HammerTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Axe)) return ::Const.Perks.AxeTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Cleaver)) return ::Const.Perks.CleaverTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Sword) && _item.isItemType(::Const.Items.ItemType.TwoHanded))
        return ::Const.Perks.GreatSwordTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Sword)) return ::Const.Perks.SwordTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Dagger)) return ::Const.Perks.DaggerTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Polearm)) return ::Const.Perks.PolearmTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Spear)) return ::Const.Perks.SpearTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Crossbow)) return ::Const.Perks.CrossbowTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Bow)) return ::Const.Perks.BowTree.Tree;
    else if (_item.isWeaponType(::Const.Items.WeaponType.Sling)) return ::Const.Perks.SlingTree.Tree;
    else return ::Const.Perks.MaceTree.Tree;
}