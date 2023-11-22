this.spell_mark_of_decay <- this.inherit("scripts/skills/_magic_active", {
	m = {},
	function create()
	{
		this.m.ID = "actives.spell.mark_of_decay";
		this.m.Name = "Mark of Decay";
		this.m.Description = "";
		this.m.Icon = "skills/mark_of_decay.png";
		this.m.IconDisabled = "skills/mark_of_decay_bw.png";
		this.m.Overlay = "active_26";
		this.m.SoundOnHit = [
			"sounds/enemies/necromancer_01.wav",
			"sounds/enemies/necromancer_02.wav",
			"sounds/enemies/necromancer_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsShowingProjectile = false;
		this.m.IsUsingHitchance = false;

		this.m.Aspect = "winter";
		this.m.ManaCost = 0;
		this.m.Cooldown_Max = 1;
		this.m.Cooldown = 1;

		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 4;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile)
			&& !this.m.Container.getActor().isAlliedWith(_targetTile.getEntity());
	}

	function cast( _user, _targetTile )
	{
		if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			::Z.Log.display_basic(_user, null, this.m.Name, _user.getFaction() == this.Const.Faction.Player || _user.getFaction() == this.Const.Faction.PlayerAnimals);

		for( local i = 1; i <= 5; i++ )
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 200 * i, this.spawn_particles.bindenv(this), {
				Skill = this,
				User = _user,
				TargetTile = _user.getTile()
			});
		}

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1200, this.curse.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
		return true;
	}

	//Helper

	function curse(tag)
	{
		local target = tag.TargetTile.getEntity();

		//Decay
		if (target.getSkills().getSkillByID("perk.meditation.omen_of_decay") == null)
		{
			local decay = ::new("scripts/skills/effects/decay_effect");
			decay.setActor(tag.User);
			if (tag.User.getSkills().getSkillByID("perk.meditation.omen_of_decay") != null)
				decay.setDamage((tag.User.getFlags().has("decay_bonus") ? tag.User.getFlags().getAsInt("decay_bonus") + 5 : 5));
			target.getSkills().add(decay);
		}
		

		//Mark of Decay
		local effect = target.getSkills().getSkillByID("effects.mark_of_decay");
		if (effect == null)
		{
			effect = ::new("scripts/skills/effects/mark_of_decay");
			target.getSkills().add(effect);
		}
		else effect.reset();
		effect.setActor(tag.User);
		if (tag.User.getSkills().getSkillByID("perk.meditation.omen_of_decay") != null)
			effect.setBonus((tag.User.getFlags().has("decay_bonus") ? tag.User.getFlags().getAsInt("decay_bonus") : 0));

		if (tag.User.getSkills().getSkillByID("perk.research.rotten_offering") != null)
			effect.m.RottenOffering = true;

		//FEATURE_0: HOME change vfx
		::Tactical.spawnSpriteEffect("effect_skull_03", this.createColor("#ffffff"), tag.TargetTile, 0, 40, 1.0, 0.25, 0, 400, 300);
		//FEATURE_0: HOME play sound fx
	}

	function spawn_particles(tag)
	{
		if (!tag.TargetTile.IsVisibleForPlayer) return;

		if (::Const.Tactical.RaiseUndeadParticles.len() != 0)
		{
			for( local i = 0; i < ::Const.Tactical.RaiseUndeadParticles.len(); i = i )
			{
				this.Tactical.spawnParticleEffect(true, ::Const.Tactical.RaiseUndeadParticles[i].Brushes, tag.TargetTile, ::Const.Tactical.RaiseUndeadParticles[i].Delay, ::Const.Tactical.RaiseUndeadParticles[i].Quantity, ::Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, ::Const.Tactical.RaiseUndeadParticles[i].SpawnRate, ::Const.Tactical.RaiseUndeadParticles[i].Stages);
				i = ++i;
			}
		}
	}

	function loadAI()
	{
		local actor = this.getContainer().getActor();
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.SpellMarkOfDecay) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_spell_mark_of_decay"));
			agent.finalizeBehaviors();
		}
	}

});

