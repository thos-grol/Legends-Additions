this.anguish_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 4,
		HitCounter = 0,
		SpreadingAnguish = false,
		TormentSoul = false
	},
	function create()
	{
		this.m.ID = "effects.anguish";
		this.m.Name = "Anguish";
		this.m.Description = "This character has been cursed with spiritual anguish. They take the damage they deal. If they don't deal more than 15 damage, they will be drained by their anguish.";
		this.m.Icon = "skills/legend_vala_trance_malevolent.png";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "Affected for [color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s).";
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_damageInflictedHitpoints >= 15) this.m.HitCounter += 1;
		local actor = this.getContainer().getActor();
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = _damageInflictedHitpoints;
		if (this.m.TormentSoul) hitInfo.DamageRegular *= 1.5;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		actor.onDamageReceived(actor, this, hitInfo);
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0) this.removeSelf();
		if (this.m.HitCounter == 0)
		{
			local poison = _targetEntity.getSkills().getSkillByID("effects.drained_effect");
			if (poison == null)
			{
				_targetEntity.getSkills().add(this.new("scripts/skills/effects/drained_effect"));
				poison = _targetEntity.getSkills().getSkillByID("effects.drained_effect");
				poison.setActorID(this.getContainer().getActor().getID());
			}
			else
			{
				poison.setActorID(this.getContainer().getActor().getID());
				poison.incrementTime();
			}
		}
		else this.m.HitCounter = 0;

		if (this.m.SpreadingAnguish)
		{
			//Notify in log.
			local a = this.getContainer().getActor();
			local mytile = a.getTile();

			local actors = this.Tactical.Entities.getAllInstances();
			foreach( i in actors )
			{
				foreach( target in i )
				{
					if (target.isAlliedWith(a) && target.getID() != a.getID() && target.getTile().getDistanceTo(mytile) <= 1)
					{
						local effect = target.getSkills().getSkillByID("effects.anguish");
						if (effect != null) continue;
						
						local HIT_CHANCE = getHitchance(target);
						if (this.Math.rand(1, 100) > HIT_CHANCE) continue;

						target.getSkills().add(this.new("scripts/skills/effects/anguish_effect"));
						effect = target.getSkills().getSkillByID("effects.anguish");
						effect.m.SpreadingAnguish = true;
						effect.m.TormentSoul = this.m.TormentSoul;
						effect.m.TurnsLeft = this.m.Duration;
						this.Tactical.EventLog.log("Anguish has spread to " + this.Const.UI.getColorizedEntityName(target) + ".");
					}
				}
			}

		}
	}

	function getHitchance( _targetEntity )
	{
		local WILL = _targetEntity.getBravery();
		if (WILL > 200) return 0;
		else if (WILL > 150) return 25;
		else if (WILL > 100) return 50;
		else return 100;
	}

});

