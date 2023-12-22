//Mutated Circulatory System
//This character's body has mutated and propagates poisons and other hazardous substances through the bloodstream much more slowly, allowing them to be disposed of without serious health effects. Curiously, this doesn't seem to affect their ability to get drunk.
::mods_hookExactClass("skills/effects/webknecht_potion_effect", function (o)
{
    o.create = function()
	{
		this.m.ID = "effects.webknecht_potion";
		this.m.Name = "Webknecht";
		this.m.Icon = "skills/status_effect_144.png";
		this.m.IconMini = "status_effect_144_mini";
		this.m.Overlay = "status_effect_144";
        this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

    o.getDescription = function()
	{
		return "This character\'s body has mutated and propagates poisons and other hazardous substances through the bloodstream much more slowly, allowing them to be disposed of without serious health effects. Curiously, this doesn\'t seem to affect their ability to get drunk.\n\nThey've also mutated venom glands, allowing them to spit and poison their weapons.";
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

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Immune to poison effects"
        });

        ret.push({
            id = 11,
            type = "text",
            icon = "ui/icons/special.png",
            text = "Not affected by nighttime penalties"
        });

        if (this.getContainer().getActor().getFlags().has("spider_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_defense.png",
				text = "+" + ::MSU.Text.colorGreen( "15" ) + " Melee Defense"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+" + ::MSU.Text.colorGreen( "20" ) + " Hitpoints"
            });
        }
        else if (this.getContainer().getActor().getFlags().has("spider"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/melee_defense.png",
				text = "+" + ::MSU.Text.colorGreen( "7" ) + " Melee Defense"
            });
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
                text = "+" + ::MSU.Text.colorGreen( "10" ) + " Hitpoints"
            });
        }

        if (this.getContainer().getActor().getFlags().has("spider_8"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Piercing or cutting attacks poison the target with redback venom."
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
        _properties.IsImmuneToPoison = true;
        _properties.IsAffectedByNight = false;

        if (this.getContainer().getActor().getFlags().has("spider_8"))
        {
            _properties.MeleeDefense += 7;
            _properties.Hitpoints += 10;
        }
        else if (this.getContainer().getActor().getFlags().has("spider"))
        {
            _properties.MeleeDefense += 15;
            _properties.Hitpoints += 20;
        }
    }

    o.onTargetHit <- function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
    {
        local actor = this.getContainer().getActor();
        if (_targetEntity.getCurrentProperties().IsImmuneToPoison && !actor.getFlags().has("spider_8")) return;
        if (_damageInflictedHitpoints < ::Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0) return;

        if (!_targetEntity.isAlive()) return;
        if (_targetEntity.getFlags().has("undead")) return;

        if (_skill.m.InjuriesOnBody != ::Const.Injury.PiercingBody && _skill.m.InjuriesOnBody != ::Const.Injury.CuttingBody) return;

        if (!_targetEntity.isHiddenToPlayer())
        {
            if (this.m.SoundOnUse.len() != 0) this.Sound.play(this.m.SoundOnUse[::Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());

            this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
        }

        this.spawnIcon("status_effect_54", _targetEntity.getTile());

        local effect;
        if (actor.getFlags().has("spider_8")) effect = ::new("scripts/skills/effects/legend_redback_spider_poison_effect");
        else effect = ::new("scripts/skills/effects/spider_poison_effect");
        if (actor.getFaction() == ::Const.Faction.Player) effect.setActor(actor);
        _targetEntity.getSkills().add(effect);
    }

    o.onAdded <- function()
	{
		if (!this.m.Container.hasSkill("actives.web_skill"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/web_skill"));
		}
	}

	o.onRemoved <- function()
	{
		this.m.Container.removeByID("actives.web_skill");
	}
});