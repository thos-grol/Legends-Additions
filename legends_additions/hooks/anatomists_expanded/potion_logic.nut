//give sickness when consuming potions
::mods_hookExactClass("items/misc/anatomist/anatomist_potion_item", function (o)
{
    local onUse = o.onUse;
    o.onUse = function( _actor, _item = null )
    {
        if (!_actor.getFlags().has("SequencesUsed"))
        {
            _actor.getFlags().add("SequencesUsed", 0)
        }
        _actor.getFlags().increment("SequencesUsed", 1);

        //give sickness
        this.Sound.play("sounds/combat/drink_0" + this.Math.rand(1, 3) + ".wav", ::Const.Sound.Volume.Inventory);
        if (!_actor.getSkills().hasSkill("injury.sickness"))
        {
            _actor.getSkills().add(::new("scripts/skills/injury/sickness_injury"));
        }
        _actor.getSkills().getSkillByID("injury.sickness").addHealingTime(_actor.getFlags().getAsInt("ActiveMutations") * 3);

        //play screaming sounds
        if (_actor.getGender() == 1)
        {
            this.Sound.play("sounds/humans/legends/woman_death_0" + this.Math.rand(1, 8) + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/humans/legends/woman_flee_0" + this.Math.rand(1, 6) + ".wav", ::Const.Sound.Volume.Inventory);
        }
        else
        {
            this.Sound.play("sounds/humans/2/human_death_01" + ".wav", ::Const.Sound.Volume.Inventory);
            this.Sound.play("sounds/humans/2/human_flee_01" + ".wav", ::Const.Sound.Volume.Inventory);
        }
        return true;
    }
});

//mutation logic - if too many sequences, brother will die
::LA.doMutation <- function (_actor, _flag)
{
    local time = 0.0;
    if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
        time = this.World.State.getCombatStartTime();
    else time = this.Time.getVirtualTimeF();

    _actor.getFlags().increment("PotionsUsed", 1);
    _actor.getFlags().set("PotionLastUsed", time);

    //if upgrading a sequence
    if (_actor.getFlags().has(_flag)) return;

    local num_mutations = _actor.getFlags().getAsInt("ActiveMutations");
    if (num_mutations < 1)
    {
        _actor.getFlags().increment("ActiveMutations");
        return;
    }

    if (this.World.Assets.getOrigin().getID() == "scenario.anatomists" && num_mutations < 2 && _actor.getSkills().getSkillByID("perk.hold_out") != null)
    {
        _actor.getFlags().increment("ActiveMutations");
        return;
    }

    _actor.getItems().transferToStash(this.World.Assets.getStash());
    _actor.getSkills().onDeath(::Const.FatalityType.None);
    this.World.Statistics.addFallen(_actor, "Their mutations went out of control.");
    this.World.getPlayerRoster().remove(_actor);
}

::LA.addPerk <- function (_actor, _perk_id, _perk_location, _perk, _perk_row)
{
    //if has skill, remove and refund
    if (_actor.getSkills().hasSkill(_perk_id))
    {
        _actor.getSkills().removeByID(_perk_id);
        ++_actor.m.PerkPoints;
    }
    //if perk exists, remove it from the tree
    if (_actor.getBackground().hasPerk(_perk)) _actor.getBackground().removePerk(_perk)

    //add non-refundable version of perk to tree and add the perk to skills
    _actor.getBackground().addPerk(_perk, _perk_row, false);
    _actor.getSkills().add(::new(_perk_location));
}

::LA.removePerk <- function (_actor, _perk_id, _perk)
{
    //if has skill, remove and refund
    if (_actor.getSkills().hasSkill(_perk_id))
    {
        _actor.getSkills().removeByID(_perk_id);
    }
    //if perk exists, remove it from the tree
    if (_actor.getBackground().hasPerk(_perk)) _actor.getBackground().removePerk(_perk)
}