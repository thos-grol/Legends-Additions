this._flesh_slave <- this.inherit("scripts/skills/skill", {
	m = {
		Master = null,
		IsActivated = false
	},
	function activate()
	{
		this.m.IsActivated = true;
	}

	function setMaster( _p )
	{
		if (_p == null)
		{
			this.m.Master = null;
		}
		else if (typeof _p == "instance")
		{
			this.m.Master = _p;
		}
		else
		{
			this.m.Master = this.WeakTableRef(_p);
		}
	}

	function isAlive()
	{
		return this.getContainer() != null && !this.getContainer().isNull() && this.getContainer().getActor() != null && this.getContainer().getActor().isAlive() && this.getContainer().getActor().getHitpoints() > 0;
	}

	function create()
	{
		this.m.ID = "effects._flesh_slave";
		this.m.Name = "Flesh Slave";
		this.m.KilledString = "Died from taking damage for their master";
		this.m.Icon = "skills/status_effect_84.png";
		this.m.IconMini = "status_effect_84_mini";
		this.m.SoundOnUse = [];
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsHidden = true;
	}

	function getDescription()
	{
		return "This character has been the recipient of compassion.";
	}

	function onRemoved()
	{
		if (this.m.Master != null && !this.m.Master.isNull() && !this.m.Master.getContainer().isNull())
		{
			local master = this.m.Master;
			this.m.Master = null;
			master.setSlave(null);
			master.removeSelf();
			master.getContainer().update();
		}
	}

	function onDeath( _fatalityType )
	{
		this.onRemoved();
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (this.m.IsActivated && (this.m.Master == null || this.m.Master.isNull() || !this.m.Master.isAlive()))
		{
			this.removeSelf();
		}
	}

	//flesh assimilation
	function onTargetKilled( _targetEntity, _skill )
	{
		if (::Math.rand(1,100) > 10) return;

		local actor = this.getContainer().getActor();
		local master = this.m.Master.getContainer().getActor();
		local assimilation = master.getSkills().getSkillByID("perk.research.flesh_assimilation");
		if (assimilation == null) return;

		local flesh_servant = master.getSkills().getSkillByID("actives.spell.flesh_servant_bind");
		if (flesh_servant == null) return;
		if (flesh_servant.m.Absorbed >= 9) return;


		local skills = [];
		local skill_name = null;
		local _targetEntity_skills = _targetEntity.m.Skills.m.Skills
		foreach(skill in _targetEntity_skills)
		{
			if (!skill.isGarbage()
				&& skill.m.ID in ::Z.Map) skills.push(skill.m.ID);
		}

		if (skills.len() == 0) return;

		//TODO: rewrite logic into while loop
		//TODO: zombies need better ai, do not use hand to hand

		for (local i = 0 ; i < 10 ; i++) {
			local id = ::MSU.Array.rand(skills);
			if (actor.getSkills().getSkillByID(id) != null) continue;
			if (!(id in ::Z.Map)) continue;

			::logInfo("Assimilated " + id)

			local skill = ::new(::Z.Map[id]);
			skill_name = skill.m.Name;
			actor.m.Skills.add(skill);
			flesh_servant.m.Skills.push(::new(::Z.Map[id]));
			if (!actor.isHiddenToPlayer() && actor.getTile().IsVisibleForPlayer)
			{
				this.Sound.play("sounds/monster/abomination_hurt.wav", 300.0, actor.getPos());
				::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(actor) + "has assimilated the skill: " + skill_name);
			}
			flesh_servant.m.Absorbed += 1;
			break;
		}


	}

	function applyDamage( _damage )
	{
		local actor = this.getContainer().getActor();
		this.Sound.play("sounds/monster/abomination_hurt.wav", 300.0, actor.getPos());
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = _damage;
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = this.Const.BodyPart.Body;
		hitInfo.BodyDamageMult = 1.0;
		hitInfo.FatalityChanceMult = 0.0;
		actor.onDamageReceived(actor, this, hitInfo);
	}

});

