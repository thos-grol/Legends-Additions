this.getroottable().anatomists_expanded.hook_mutations <- function ()
{
    //sickness logic
    ::mods_hookExactClass("items/misc/anatomist/anatomist_potion_item", function (o)
	{
		local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function( _actor, _item = null )
		{
            if (!_actor.getFlags().has("SequencesUsed"))
            {
                _actor.getFlags().add("SequencesUsed", 0)
            }
            _actor.getFlags().increment("SequencesUsed", 1);

            //give sickness
            this.Sound.play("sounds/combat/drink_0" + this.Math.rand(1, 3) + ".wav", this.Const.Sound.Volume.Inventory);
            if (!_actor.getSkills().hasSkill("injury.sickness"))
            {
                _actor.getSkills().add(this.new("scripts/skills/injury/sickness_injury"));
            }
            _actor.getSkills().getSkillByID("injury.sickness").addHealingTime(_actor.getFlags().getAsInt("ActiveMutations") * 3);

            //play screaming sounds
            if (_actor.getGender() == 1)
            {
                this.Sound.play("sounds/humans/legends/woman_death_0" + this.Math.rand(1, 8) + ".wav", this.Const.Sound.Volume.Inventory);
                this.Sound.play("sounds/humans/legends/woman_flee_0" + this.Math.rand(1, 6) + ".wav", this.Const.Sound.Volume.Inventory);
            }
            else
            {
                this.Sound.play("sounds/humans/2/human_death_01" + ".wav", this.Const.Sound.Volume.Inventory);
                this.Sound.play("sounds/humans/2/human_flee_01" + ".wav", this.Const.Sound.Volume.Inventory);
            }
            return true;
		}
	});
};

this.getroottable().anatomists_expanded.doInjuries <- function (_actor, _flag)
{    
    local time = 0.0;
    if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
    {
        time = this.World.State.getCombatStartTime();
    }
    else
    {
        time = this.Time.getVirtualTimeF();
    }
    _actor.getFlags().increment("PotionsUsed", 1);
    _actor.getFlags().set("PotionLastUsed", time);
    
    //if upgrading a sequence
    if (_actor.getFlags().has(_flag))
    {
        return;
    }

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

    _actor.getFlags().increment("ActiveMutations");

    local potential = [];
    local injuries = this.Const.Injury.Permanent;
    local numPermInjuries = 0;

    foreach( inj in injuries )
    {
        if (inj.ID == "injury.legend_scarred_injury" || inj.ID == "injury.missing_finger")
        {
            continue;
        }
        else if (inj.ID == "injury.broken_elbow_joint" && _actor.getSkills().getSkillByID("trait.legend_prosthetic_forearm") != null)
        {
            continue;
        }
        else if (inj.ID == "injury.broken_knee" && _actor.getSkills().getSkillByID("trait.legend_prosthetic_leg") != null)
        {
            continue;
        }
        else if (inj.ID == "injury.maimed_foot" && _actor.getSkills().getSkillByID("trait.legend_prosthetic_foot") != null)
        {
            continue;
        }
        else if (inj.ID == "injury.missing_ear" && _actor.getSkills().getSkillByID("trait.legend_prosthetic_ear") != null)
        {
            continue;
        }
        else if (inj.ID == "injury.missing_eye" && _actor.getSkills().getSkillByID("trait.legend_prosthetic_eye") != null)
        {
            continue;
        }
        else if (inj.ID == "injury.missing_hand" && _actor.getSkills().getSkillByID("trait.legend_prosthetic_hand") != null)
        {
            continue;
        }
        else if (inj.ID == "injury.missing_nose" && _actor.getSkills().getSkillByID("trait.legend_prosthetic_nose") != null)
        {
            continue;
        }
        else if (inj.ID == "injury.legend_burned_injury")
        {
            if (_actor.getSkills().getSkillByID(inj.ID) != null)
            {
                numPermInjuries = ++numPermInjuries;
                numPermInjuries = numPermInjuries;
                continue;
            }

            local isBurned = false;

            foreach( b in this.Const.Injury.Burning )
            {
                if (_actor.getSkills().getSkillByID(b.ID)  != null)
                {
                    isBurned = true;
                    break;
                }
            }

            if (isBurned)
            {
                potential.push(inj);
            }
        }
        else if (_actor.getSkills().getSkillByID(inj.ID) == null)
        {
            potential.push(inj);
        }
        else
        {
            numPermInjuries = ++numPermInjuries;
            numPermInjuries = numPermInjuries;
        }
    }

    if (potential.len() > 0)
    {
        local inj_index = this.Math.rand(0, potential.len() - 1);
        local skill = this.new("scripts/skills/" + potential[inj_index].Script);
        _actor.getSkills().add(skill);
        if (potential.len() > 1)
        {
            potential.remove(inj_index);
            inj_index = this.Math.rand(0, potential.len() - 1);
            skill = this.new("scripts/skills/" + potential[inj_index].Script);
            _actor.getSkills().add(skill);
        }
        if (potential.len() > 1)
        {
            potential.remove(inj_index);
            inj_index = this.Math.rand(0, potential.len() - 1);
            skill = this.new("scripts/skills/" + potential[inj_index].Script);
            _actor.getSkills().add(skill);
        }
    }
    
    if (_actor.getFlags().getAsInt("SequencesUsed") > 6)
    {
        _actor.getItems().transferToStash(this.World.Assets.getStash());
        _actor.getSkills().onDeath(this.Const.FatalityType.None);
        this.World.Statistics.addFallen(_actor, "Their mutations went out of control.");
        this.World.getPlayerRoster().remove(_actor);
    }
    
}