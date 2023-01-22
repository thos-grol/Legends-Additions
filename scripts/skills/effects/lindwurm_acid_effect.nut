this.lindwurm_acid_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3,
		LastRoundApplied = 0
	},
	function create()
	{
		this.m.ID = "effects.lindwurm_acid";
		this.m.Name = "Sprayed with Acid";
		this.m.Icon = "skills/status_effect_78.png";
		this.m.IconMini = "status_effect_78_mini";
		this.m.SoundOnUse = [
			"sounds/combat/poison_applied_01.wav",
			"sounds/combat/poison_applied_02.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character has been sprayed with acidic blood, which is now slowly eating away at them for another [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] turn(s).";
	}

	function getTooltip()
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

		local actor = this.getContainer().getActor();
		local head_affected = !actor.getFlags().has("head_immune_to_acid");
		local body_affected = !actor.getFlags().has("body_immune_to_acid");

		if (!actor.getFlags().has("wurm") && (head_affected || body_affected))
		{
			local total = 0;
			if (head_affected) total += (actor.getArmor(this.Const.BodyPart.Head)/actor.getArmorMax(this.Const.BodyPart.Head) < 0.5) ? 10 : 5;
			if (body_affected) total += (actor.getArmor(this.Const.BodyPart.Body)/actor.getArmorMax(this.Const.BodyPart.Body) < 0.5) ? 20.0 : 10.0;
			
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/damage_received.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + total + " health is corroded each turn."
			});
		}

		if (!head_affected)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_head.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]40 head armor is lost each turn"
			});
		}

		if (!body_affected)
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/armor_body.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]40 body armor is lost each turn"
			});
		}

		return ret;
	}

	function resetTime()
	{
		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, this.getContainer().getActor().getPos());
		}
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			local actor = this.getContainer().getActor();
			local head_affected = !actor.getFlags().has("head_immune_to_acid");
			local body_affected = !actor.getFlags().has("body_immune_to_acid");
			local damage_applied = false;
			this.spawnIcon("status_effect_78", actor.getTile());

			if (head_affected)
			{
				local hitInfo = clone this.Const.Tactical.HitInfo;
				if (actor.getFlags().has("wurm")) hitInfo.DamageRegular = 0;
				else hitInfo.DamageRegular = (actor.getArmor(this.Const.BodyPart.Head)/actor.getArmorMax(this.Const.BodyPart.Head) < 0.5) ? 10.0 : 5.0;
				hitInfo.DamageArmor = this.Math.min(actor.getArmor(this.Const.BodyPart.Head), 40.0);
				hitInfo.DamageDirect = 0.0;
				hitInfo.BodyPart = this.Const.BodyPart.Head;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;

				if (hitInfo.DamageArmor > 0 || hitInfo.DamageRegular > 0) damage_applied = true;
				this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			}

			if (body_affected)
			{
				local hitInfo = clone this.Const.Tactical.HitInfo;
				if (actor.getFlags().has("wurm")) hitInfo.DamageRegular = 0;
				else hitInfo.DamageRegular = (actor.getArmor(this.Const.BodyPart.Body)/actor.getArmorMax(this.Const.BodyPart.Body) < 0.5) ? 20.0 : 10.0;
				hitInfo.DamageArmor = this.Math.min(actor.getArmor(this.Const.BodyPart.Body), 40.0);
				hitInfo.DamageDirect = 0.0;
				hitInfo.BodyPart = this.Const.BodyPart.Body;
				hitInfo.BodyDamageMult = 1.0;
				hitInfo.FatalityChanceMult = 0.0;

				if (hitInfo.DamageArmor > 0 || hitInfo.DamageRegular > 0) damage_applied = true;
				this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
			}

			if (damage_applied && !actor.isHiddenToPlayer())
			{
				if (this.m.SoundOnUse.len() != 0)
				{
					this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.2, actor.getPos());
				}

				for( local i = 0; i < this.Const.Tactical.AcidParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.AcidParticles[i].Brushes, this.getContainer().getActor().getTile(), this.Const.Tactical.AcidParticles[i].Delay, this.Const.Tactical.AcidParticles[i].Quantity, this.Const.Tactical.AcidParticles[i].LifeTimeQuantity, this.Const.Tactical.AcidParticles[i].SpawnRate, this.Const.Tactical.AcidParticles[i].Stages);
				}
			}

			if (--this.m.TurnsLeft <= 0)
			{
				this.removeSelf();
			}
		}
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (actor.getType() == this.Const.EntityType.Lindwurm || actor.getType() == this.Const.EntityType.LegendStollwurm) return;

		this.m.TurnsLeft = this.Math.max(1, 3 + actor.getCurrentProperties().NegativeStatusEffectDuration);

		if (this.m.SoundOnUse.len() != 0)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
		}

		for( local i = 0; i < this.Const.Tactical.AcidParticles.len(); i = ++i )
		{
			this.Tactical.spawnParticleEffect(true, this.Const.Tactical.AcidParticles[i].Brushes, actor.getTile(), this.Const.Tactical.AcidParticles[i].Delay, this.Const.Tactical.AcidParticles[i].Quantity, this.Const.Tactical.AcidParticles[i].LifeTimeQuantity, this.Const.Tactical.AcidParticles[i].SpawnRate, this.Const.Tactical.AcidParticles[i].Stages);
		}

		if (!actor.isHiddenToPlayer())
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(actor) + "\'s body has been sprayed with acid");
		}
	}

	function onUpdate( _properties )
	{
	}

	function onTurnEnd()
	{
		this.applyDamage();
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

});

