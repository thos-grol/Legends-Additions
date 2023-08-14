//"Venom Glands"
//"This character has developed venom glands that allow them to produce poison strong enough to kill any man. Sadly they do not have the fangs of a snake or spider to deliver this venom and have to resort using piercing or cutting weapons to apply it.";
::mods_hookExactClass("skills/effects/serpent_potion_effect", function (o)
{
    local create = o.create;
    o.create = function()
    {
        this.m.ID = "effects.serpent_potion";
		this.m.Name = "Venom Glands";
		this.m.Icon = "skills/status_effect_142.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_142";
		this.m.Type = ::Const.SkillType.StatusEffect | ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
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

        if (this.getContainer().getActor().getFlags().has("serpent"))
        {
            ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/special.png",
                text = "Immune to poison effects"
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
        if (this.getContainer().getActor().getFlags().has("serpent"))
        {
            _properties.IsImmuneToPoison = true;
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
            if (this.m.SoundOnUse.len() != 0) this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());

            this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
        }

        this.spawnIcon("status_effect_54", _targetEntity.getTile());

        local effect;
        if (actor.getFlags().has("spider_8")) effect = ::new("scripts/skills/effects/legend_redback_spider_poison_effect");
        else effect = ::new("scripts/skills/effects/spider_poison_effect");
        if (actor.getFaction() == ::Const.Faction.Player) effect.setActor(actor);
        _targetEntity.getSkills().add(effect);
    }

});

::Const.Strings.PerkDescription.HoldOut = "Keep it together! Reduce the duration of general status effects to " + ::MSU.Text.colorGreen( "1" ) + " turn. +" + ::MSU.Text.colorGreen( "8" ) + " hitpoints.  Raises the chance to survive being struck down from 33% to 66%.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.HoldOut].Tooltip = ::Const.Strings.PerkDescription.HoldOut;

::mods_hookExactClass("skills/effects/spider_poison_effect", function (o)
{
    o.m.Damage = 10;
    o.m.Actor <- null;

    o.setActor <- function( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

    o.getAttacker <- function()
	{
		if (::MSU.isNull(this.m.Actor)) return this.getContainer().getActor();
		if (this.m.Actor.getID() != this.getContainer().getActor().getID())
		{
			if (this.m.Actor.isAlive() && this.m.Actor.isPlacedOnMap()) return this.m.Actor;
		}
		return this.getContainer().getActor();
	}

    o.applyDamage = function()
    {
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("status_effect_54", this.getContainer().getActor().getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.0, this.getContainer().getActor().getPos());
			}

			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.m.Damage;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getAttacker(), this, hitInfo);
		}
	}
});

::mods_hookExactClass("skills/effects/legend_redback_spider_poison_effect", function (o)
{
    o.m.Damage = 20;
    o.m.Actor <- null;

    o.setActor <- function( _a )
	{
		this.m.Actor = ::MSU.asWeakTableRef(_a);
	}

    o.getAttacker <- function()
	{
		if (::MSU.isNull(this.m.Actor)) return this.getContainer().getActor();
		if (this.m.Actor.getID() != this.getContainer().getActor().getID())
		{
			if (this.m.Actor.isAlive() && this.m.Actor.isPlacedOnMap()) return this.m.Actor;
		}
		return this.getContainer().getActor();
	}

    o.applyDamage = function()
    {
        if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("status_effect_54", this.getContainer().getActor().getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.0, this.getContainer().getActor().getPos());
			}

			local timeDamage = this.m.Damage;
			local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = timeDamage;

			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getAttacker(), this, hitInfo);
		}
    }

    o.onAdded = function()
	{
        local actor = this.getContainer().getActor();

        if (!actor.getSkills().hasSkill("effects.stunned") && !actor.getSkills().hasSkill("perk.hold_out") && !actor.getCurrentProperties().IsImmuneToPoison)
        {
            actor.getSkills().add(::new("scripts/skills/effects/stunned_effect"));
            this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " is stunned by redback venom");
        }

        if (actor.getSkills().hasSkill("perk.hold_out"))
        {
            this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + " is too resilient to be stunned by redback venom");
        }

        this.m.TurnsLeft = this.Math.max(2, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		if (actor.getSkills().hasSkill("trait.ailing")) ++this.m.TurnsLeft;
        if (actor.getCurrentProperties().IsImmuneToPoison) this.m.TurnsLeft = 1;
	}
});


::mods_hookExactClass("skills/racial/spider_racial", function (o)
{
    o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < ::Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0) return;
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.getFlags().has("undead")) return;

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned with webknecht venom");
		}

		this.spawnIcon("status_effect_54", _targetEntity.getTile());
		_targetEntity.getSkills().add(::new("scripts/skills/effects/spider_poison_effect"));
	}

});

::mods_hookExactClass("skills/racial/legend_redback_spider_racial", function (o)
{
    o.onTargetHit = function( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints <= ::Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0) return;
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.getFlags().has("undead")) return;

		if (!_targetEntity.isHiddenToPlayer())
		{
			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], ::Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
			}

			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned with redback venom");
		}

		this.spawnIcon("status_effect_54", _targetEntity.getTile());
		_targetEntity.getSkills().add(::new("scripts/skills/effects/legend_redback_spider_poison_effect"));
	}

});

::mods_hookExactClass("skills/perks/perk_coup_de_grace", function(o) {
	o.onAnySkillUsed = function ( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null || !_skill.isAttack())
		{
			return;
		}

		if (_targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
		{
			_properties.DamageTotalMult *= 1.2;
		}

		if (_targetEntity.getSkills().hasSkill("effects.stunned") || _targetEntity.getSkills().hasSkill("effects.net") || _targetEntity.getSkills().hasSkill("effects.sleeping") || _targetEntity.getSkills().hasSkill("effects.debilitated") || _targetEntity.getSkills().hasSkill("effects.web"))
		{
			_properties.DamageTotalMult *= 1.2;
		}
	}
});
