::Z.Perks.Destiny <- {
    "perk.fresh_and_furious" : 0,
    "perk.indomitable" : 0,
    "perk.inspiring_presence" : 0,
    "perk.legend_blend_in" : 0,
    "perk.legend_escape_artist" : 0,
    "perk.legend_mind_over_body" : 0,
    "perk.legend_muscularity" : 0,
    "perk.legend_perfect_focus" : 0,
    "perk.overwhelm" : 0,
    "perk.vengeance" : 0,
};

::Z.Perks.Stance <- {
    "perk.stance.executioner": "perk.mastery.axec",
};

::Z.Perks.Proficiency <- {
    "perk.mastery.axe" : 0,
    "perk.mastery.cleaver" : 0,
    "perk.mastery.dagger" : 0,
    "perk.mastery_fist" : 0,
    "perk.mastery.flail" : 0,
    "perk.mastery.hammer" : 0,
    "perk.mastery.mace" : 0,
    "perk.mastery.polearm" : 0,
    "perk.mastery.spear" : 0,
    "perk.mastery.sword" : 0,
    "perk.mastery.bow" : 0,
    "perk.mastery.crossbow" : 0,
    "perk.legend_mastery_slings" : 0,
};


::Z.Perks.add <- function (_actor, _perk, _perk_row)
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

::Z.Perks.remove <- function (_actor, _perk)
{
    //if has skill, remove and refund
    if (_actor.getSkills().hasSkill(::Const.Perks.PerkDefObjects[_perk].ID))
    {
        _actor.getSkills().removeByID(::Const.Perks.PerkDefObjects[_perk].ID);
    }
    //if perk exists, remove it from the tree
    if (_actor.getBackground().hasPerk(_perk)) _actor.getBackground().removePerk(_perk)
}

::Z.Perks.tree <- function (_item)
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

::Z.Perks.isProficiency <- function (_id)
{
    return _id in ::Z.Perks.Proficiency;
}

::Z.Perks.isDestiny <- function (_id)
{
    return _id in ::Z.Perks.Destiny;
}

::Z.Perks.isStance <- function (_id)
{
    return _id in ::Z.Perks.Stance;
}

::Z.Perks.verifyStance <- function (_actor, _id)
{
    return _actor.getSkills().hasSkill(::Z.Perks.Stance[_id]);
}