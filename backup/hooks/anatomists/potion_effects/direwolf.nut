::mods_hookExactClass("skills/effects/direwolf_potion_effect", function(o) {

	o.create = function()
	{
		this.m.ID = "effects.direwolf_potion";
		this.m.Name = "Direwolf";
		this.m.Icon = "skills/status_effect_139.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_139";
        this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	o.getDescription = function()
	{
		return this.getContainer().getActor().getFlags().has("werewolf_8") ? "This character counts as a direwolf in skill checks, and does half of missing health as increased damage. Not affected by night time penalties." : "This character counts as a direwolf in skill checks. Not affected by night time penalties.";
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

		local is8 = isWerewolf8();
		if (is8)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::MSU.Text.colorGreen( 15 ) + "% chance to unleash a howl when attacking that boosts morale and gives killing frenzy to all allied direwolves."
			});

			local dmg = getAdditionalDamage();
			if (dmg > 0)
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Attacks do " + ::MSU.Text.colorRed( dmg ) + " more damage"
				});
			}
		}
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "+" + ::MSU.Text.colorGreen( is8 ? 15 : 7 ) + " Fatigue Recovery"
		});
		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/health.png",
			text = "+" + ::MSU.Text.colorGreen( is8 ? 30 : 15 ) + " Hitpoints"
		});

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
		local is8 = isWerewolf8();
		_properties.FatigueRecoveryRate += is8 ? 10 : 5;
		_properties.Hitpoints += is8 ? 30 : 15;
		_properties.IsAffectedByNight = false;

		if (!is8) return;
		local dmg = getAdditionalDamage();
		if (dmg <= 0) return;
		_properties.DamageRegularMin += dmg;
		_properties.DamageRegularMax += dmg;
	}

	o.onAnySkillExecuted <- function( _skill, _targetTile, _targetEntity, _forFree )
    {
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("werewolf_8")) return;
        if (!_skill.isAttack() || _skill.isRanged() || _targetEntity == null || _targetEntity.isAlliedWith(actor) || !::Tactical.TurnSequenceBar.isActiveEntity(actor)) return;
		if (::Math.rand(1, 100) > 15) return;

		this.result <- {
			Self = actor,
			Skill = this
		};
		this.Sound.play("sounds/enemies/werewolf_howl.wav", ::Const.Sound.Volume.Actor);
		this.Tactical.queryActorsInRange(actor.getTile(), 1, 6, this.raiseMorale, this.result); //buff allies
		raiseMorale(actor, this.result); //Also buff self
    }

	o.raiseMorale <- function( target, tag )
	{
		if (target.getFaction() != tag.Self.getFaction() || !target.getFlags().has("werewolf")) return;
		
		target.setMoraleState(::Math.min(::Const.MoraleState.Confident, target.getMoraleState() + 1))
		tag.Skill.spawnIcon("status_effect_06", target.getTile());

		local effect = target.getSkills().getSkillByID("effects.killing_frenzy");
		if (effect != null) effect.resetTime();
		else target.getSkills().add(::new("scripts/skills/effects/killing_frenzy_effect"));
	}

	o.isWerewolf8 <- function() { return this.getContainer().getActor().getFlags().has("werewolf_8");}
	o.onTargetMissed = function(_skill, _targetEntity){}
	o.onTargetHit = function(_skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor){}
	o.onTargetKilled = function(_targetEntity, _skill){}

	o.getAdditionalDamage <- function() 
	{ 
		local healthMissing = this.getContainer().getActor().getHitpointsMax() - this.getContainer().getActor().getHitpoints();
		return ::Math.floor(healthMissing * 0.5);
	}
});
