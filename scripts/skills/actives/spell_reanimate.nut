this.spell_reanimate <- this.inherit("scripts/skills/_magic_active", {
	m = {
		Tiles = []
	},
	function create()
	{
		this.m.ID = "actives.spell.reanimate";
		this.m.Name = "Reanimate";
		this.m.Description = "";
		this.m.Icon = "skills/raisedead2.png";
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
			&& canResurrectOnTile(_targetTile)
			&& _targetTile.IsEmpty;
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

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 2000, this.spawnUndead.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
		return true;
	}

	//Helper

	function spawnUndead(tag)
	{
		local p = tag.TargetTile.Properties.get("Corpse");
		if (p == null) return;

		p.Faction = tag.User.getFaction();
		if (p.Faction == this.Const.Faction.Player) p.Faction = this.Const.Faction.PlayerAnimals;

		local e = this.Tactical.Entities.onResurrect(p, true);
		if (e != null) e.getSprite("socket").setBrush(tag.User.getSprite("socket").getBrush().Name);

		if (tag.User.getSkills().getSkillByID("perk.research.miasma_body") != null)
			e.getSkills().add(::new("scripts/skills/special/_miasma_body"));

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

	function canResurrectOnTile( _tile, _force = false )
	{
		return _tile.IsCorpseSpawned
			&& ( _tile.Properties.get("Corpse").IsResurrectable || _force
				|| !("FleshNotAllowed" in _tile.Properties.get("Corpse")) );
	}

	function onRoundEnd()
	{
		if (this.m.Tiles.len() <= 0) return;

		local i = 1;
		foreach(tile in this.m.Tiles)
		{
			this.Time.scheduleEvent(this.TimeUnit.Virtual, i++ * 100, this.spawnUndead.bindenv(this), {
				Skill = this,
				User = this.getContainer().getActor(),
				TargetTile = tile
			});
		}

		this.m.Tiles.clear();
	}

	function loadAI()
	{
		local actor = this.getContainer().getActor();
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.SpellReanimate) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_spell_reanimate"));
			agent.finalizeBehaviors();
		}
	}



});

