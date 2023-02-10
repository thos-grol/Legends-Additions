//"Elasticized Sinew";
//"This character\'s muscles have mutated and respond differently to movement impulses. It is much less fatiguing to interrupt or stop mid-motion as a consequence, making it much easier to recover from errant or blocked attacks.";
::mods_hookExactClass("skills/effects/direwolf_potion_effect", function(o) {

	o.create = function()
	{
		this.m.ID = "effects.direwolf_potion";
		this.m.Name = "Direwolf";
		this.m.Icon = "skills/status_effect_139.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_139";
        this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	o.getDescription = function()
	{
		if (this.getContainer().getActor().getFlags().has("werewolf_8"))
		{
			return "This character counts as a direwolf in skill checks, and does half of missing health as increased damage. Not affected by night time penalties.";
		}
		else
		{
			return "This character counts as a direwolf in skill checks. Not affected by night time penalties.";
		}

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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Not affected by nighttime penalties"
			}
		];

		if (this.getContainer().getActor().getFlags().has("werewolf_8"))
		{
			local healthMissing = this.getContainer().getActor().getHitpointsMax() - this.getContainer().getActor().getHitpoints();
			local additionalDamage = this.Math.floor(healthMissing * 0.5);
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Attacks do " + ::MSU.Text.colorRed( additionalDamage ) + " more damage"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::MSU.Text.colorGreen( 15 ) + "% chance to unleash a howl when attacking that boosts morale and gives killing frenzy to all allied direwolves."
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "+" + ::MSU.Text.colorGreen( 4 ) + " Action Points"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "+" + ::MSU.Text.colorGreen( 10 ) + " Fatigue Recovery"
			});
			ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
				text = "+" + ::MSU.Text.colorGreen( "30" ) + " Hitpoints"
            });
		}
		else
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "+" + ::MSU.Text.colorGreen( 2 ) + " Action Points"
			});
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "+" + ::MSU.Text.colorGreen( 5 ) + " Fatigue Recovery"
			});
			ret.push({
                id = 11,
                type = "text",
                icon = "ui/icons/health.png",
				text = "+" + ::MSU.Text.colorGreen( "15" ) + " Hitpoints"
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

	o.onUpdate <- function(_properties)
	{
		if (this.getContainer().getActor().getFlags().has("werewolf_8"))
		{
			_properties.FatigueRecoveryRate += 10;
			_properties.ActionPoints += 4;
			_properties.Hitpoints += 30;
		}
		else
		{
			_properties.FatigueRecoveryRate += 5;
			_properties.ActionPoints += 2;
			_properties.Hitpoints += 15;
		}

		_properties.IsAffectedByNight = false;

		if (this.getContainer().getActor().getFlags().has("werewolf_8"))
		{
			local healthMissing = this.getContainer().getActor().getHitpointsMax() - this.getContainer().getActor().getHitpoints();
			local additionalDamage = this.Math.floor(healthMissing * 0.5);

			if (additionalDamage > 0)
			{
				_properties.DamageRegularMin += additionalDamage;
				_properties.DamageRegularMax += additionalDamage;
			}
		}
	}

	o.raiseMorale <- function( _actor, _tag )
	{
		if (_actor.getFaction() == _tag.Self.getFaction() && _actor.getFlags().has("werewolf"))
		{
			_actor.setMoraleState(this.Math.min(::Const.MoraleState.Confident, _actor.getMoraleState() + 1))
			_tag.Skill.spawnIcon("status_effect_06", _actor.getTile());

			local effect = _actor.getSkills().getSkillByID("effects.killing_frenzy");
			if (effect != null) effect.resetTime();
			else _actor.getSkills().add(::new("scripts/skills/effects/killing_frenzy_effect"));
		}
	}

	o.onAnySkillExecuted <- function( _skill, _targetTile, _targetEntity, _forFree )
    {
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("werewolf_8")) return;
        if (!_skill.isAttack() || _skill.isRanged() || _targetEntity == null || _targetEntity.isAlliedWith(actor) || !::Tactical.TurnSequenceBar.isActiveEntity(actor))
        {
            return;
        }

		if (this.Math.rand(1, 100) <= 15)
		{
			this.result <- {
				Self = actor,
				Skill = this
			};
			this.Sound.play("sounds/enemies/werewolf_howl.wav", ::Const.Sound.Volume.Actor);
			this.Tactical.queryActorsInRange(actor.getTile(), 1, 6, this.raiseMorale, this.result);

			//Also buff self
			actor.setMoraleState(this.Math.min(::Const.MoraleState.Confident, actor.getMoraleState() + 1))
			local effect = actor.getSkills().getSkillByID("effects.killing_frenzy");
			if (effect != null) effect.resetTime();
			else actor.getSkills().add(::new("scripts/skills/effects/killing_frenzy_effect"));
		}
    }

	o.onTargetMissed = function(_skill, _targetEntity){}
	o.onTargetHit = function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor){}
	o.onTargetKilled = function(_targetEntity, _skill){}
});
