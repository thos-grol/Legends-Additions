//"Venom Glands"
//"This character has developed venom glands that allow them to produce poison strong enough to kill any man. Sadly they do not have the fangs of a snake or spider to deliver this venom and have to resort using piercing or cutting weapons to apply it.";
::mods_hookExactClass("skills/effects/serpent_potion_effect", function (o)
{
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Name = "Venom Glands";
    }

    local getDescription = o.getDescription;
    o.getDescription = function()
    {
        return "This character has developed venom glands that allow them to produce poison strong enough to kill any man. Sadly they do not have the fangs of a snake or spider to deliver this venom and have to resort using piercing or cutting weapons to apply it.";
    }

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
            }
        ];

        if (this.getContainer().getActor().getFlags().has("spider_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Piercing or cutting attacks poison the target with redback venom."
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 30 + "[/color] Initiative"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_skill.png",
                text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Melee Skill"
            });
        }
        else
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Piercing or cutting attacks poison the target."
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/initiative.png",
                text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Initiative"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_skill.png",
                text = "+[color=" + ::Const.UI.Color.PositiveValue + "]" + 5 + "[/color] Melee Skill"
            });
        }
        
        ret.push({
            id = 12,
            type = "hint",
            icon = "ui/tooltips/warning.png",
            text = "Mutations of another sequence may cause this character's genes to spiral out of control, killing them in the process"
        });

        return ret;
    }

    o.onUpdate = function(_properties)
    {
        if (this.getContainer().getActor().getFlags().has("spider_8"))
        {
            _properties.Initiative += 30;
            _properties.MeleeSkill += 15;
        }
        else
        {
            _properties.Initiative += 15;
            _properties.MeleeSkill += 5;
        }

    }

    o.onTargetHit <- function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
    {
        if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < ::Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0) return;

        if (!_targetEntity.isAlive()) return;
        if (_targetEntity.getFlags().has("undead")) return;

        if (_skill.m.InjuriesOnBody != ::Const.Injury.PiercingBody && _skill.m.InjuriesOnBody != ::Const.Injury.CuttingBody) return;

        if (!_targetEntity.isHiddenToPlayer())
        {
            if (this.m.SoundOnUse.len() != 0) this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
            
            this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
        }

        this.spawnIcon("status_effect_54", _targetEntity.getTile());

        if (this.getContainer().getActor().getFlags().has("spider_8"))
        {
            local poison = _targetEntity.getSkills().getSkillByID("effects.legend_redback_spider_poison");
            if (!_targetEntity.getSkills().hasSkill("effects.stunned") && !_targetEntity.getCurrentProperties().IsImmuneToStun)
            {
                _targetEntity.getSkills().add(::new("scripts/skills/effects/stunned_effect"));
                this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " is stunned");
            }

            if (poison == null) _targetEntity.getSkills().add(::new("scripts/skills/effects/legend_redback_spider_poison_effect"));
            else poison.resetTime();
        }
        else
        {
            local poison = _targetEntity.getSkills().getSkillByID("effects.spider_poison");
            if (poison == null) _targetEntity.getSkills().add(::new("scripts/skills/effects/spider_poison_effect"));
            else poison.resetTime();
        }

        
    }
    
});