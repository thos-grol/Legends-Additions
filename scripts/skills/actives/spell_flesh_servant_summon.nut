this.spell_flesh_servant_summon <- this.inherit("scripts/skills/_magic_active", {
	m = {
		Used = false,
	},
	function create()
	{
		this.m.ID = "actives.spell.flesh_servant_summon";
		this.m.Name = "Summon Flesh Servant";
		this.m.Description = "Summon your loyal servant...";
		this.m.Icon = "skills/raisedead2.png"; //FEATURE_0: HOME ART flesh_servant_summon
		this.m.IconDisabled = "skills/raisedead2_bw.png";
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
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;

		this.m.Aspect = "winter";
		this.m.ManaCost = 4;
		this.m.Cooldown_Max = 1;
		this.m.Cooldown = 1;

		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 4;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile)
			&& _targetTile.IsEmpty;
	}

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		local bind = actor.getSkills().getSkillByID("actives.spell.flesh_servant_bind");
		return this.skill.isUsable() && this._magic_active.isUsable() && bind != null && bind.m.Type_ != null  && !this.m.Used;
	}
	
	function cast( _user, _targetTile )
	{
		this.m.Used = true;
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

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1200, this.spawn_particles.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1700, this.spawn_particles.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 2000, this.summon_undead.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
		return true;
	}

	//Helper
	function summon_undead(tag)
	{
		local bind = tag.User.getSkills().getSkillByID("actives.spell.flesh_servant_bind");

		//spawn abom type
		::Const.Movement.AnnounceDiscoveredEntities = false;
		local entity = this.Tactical.spawnEntity(bind.m.Type_, tag.TargetTile.Coords.X, tag.TargetTile.Coords.Y);
		::Const.Movement.AnnounceDiscoveredEntities = true;

		//set faction to caster's
		local faction = tag.User.getFaction();
		if (faction == this.Const.Faction.Player) faction = this.Const.Faction.PlayerAnimals;
		entity.setFaction(faction);

		//set the name
		entity.m.Name = bind.m.Name_;

        //set skills
		foreach(skill in bind.m.Skills)
		{
			if (!entity.getSkills().hasSkill(skill.m.ID)) entity.getSkills().add(skill)
		}

        //set base properties
		entity.m.BaseProperties.Bravery = bind.m.BaseProperties["Bravery"];
		entity.m.BaseProperties.Initiative = bind.m.BaseProperties["Initiative"];
		entity.m.BaseProperties.MeleeSkill = bind.m.BaseProperties["MeleeSkill"];
		entity.m.BaseProperties.RangedSkill = bind.m.BaseProperties["RangedSkill"];
		entity.m.BaseProperties.MeleeDefense = bind.m.BaseProperties["MeleeDefense"];
		entity.m.BaseProperties.RangedDefense = bind.m.BaseProperties["RangedDefense"];
		try {
			entity.m.BaseProperties.Armor = bind.m.BaseProperties["Armor"];
		} catch(exception){}
		

        //do skill calculations
		entity.m.Skills.update();

		local master = ::new("scripts/skills/special/_flesh_master");
		local slave = ::new("scripts/skills/special/_flesh_slave");
		slave.setMaster(master);
		master.setSlave(slave);

		entity.getSkills().add(slave);
		tag.User.getSkills().add(master);

		slave.activate();
		master.activate();

		if (tag.User.getSkills().getSkillByID("perk.research.flesh_overclocking") != null)
			entity.getSkills().add(::new("scripts/skills/perks/perk_research_flesh_overclocking"));

			if (tag.User.getSkills().getSkillByID("perk.research.miasma_body") != null)
			{
				local miasma = ::new("scripts/skills/special/_miasma_body");
				miasma.setActor(tag.User);
				e.getSkills().add(miasma);
			}

		entity.riseFromGround();
	}

	/////////////////////

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

	////////////////////

	function onCombatStarted()
	{
		this.m.Used = false;
	}

	function onCombatFinished()
	{
		this.m.Used = false;
	}

	function loadAI()
	{
		local actor = this.getContainer().getActor();
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.SpellFleshServant) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_spell_flesh_servant"));
			agent.finalizeBehaviors();
		}
	}

});

