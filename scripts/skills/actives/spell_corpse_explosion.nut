this.spell_corpse_explosion <- this.inherit("scripts/skills/_magic_active", {
	m = {},
	function create()
	{
		this.m.ID = "actives.spell.corpse_explosion";
		this.m.Name = "Corpse Explosion";
		this.m.Description = "";
		this.m.Icon = "skills/raisedead2.png"; //FEATURE_0: HOME ART corpse explosion active
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
		local actor = this.getContainer().getActor();
		local entity = _targetTile.getEntity();
		if (entity == null) return false;
		if (!actor.isAlliedWith(_entity)) return false;
		if (!actor.getFlags().has("undead")) return false;
		if (actor.getFlags().has("noncorporeal")) return false;
		return this.skill.onVerifyTarget(_originTile, _targetTile);
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

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 2000, this.explode.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
		return true;
	}

	//Helper

	function explode(tag)
	{
		local entity = tag.TargetTile.getEntity();
		local max = entity.getHitpoints();
		local min = ::Math.round(max * 0.33);

		this.Tactical.getCamera().quake(this.createVec(0, -1.0), 6.0, 0.16, 0.35);

		for( local i = 0; i < this.Const.Tactical.MortarImpactParticles.len(); i = ++i )
		{
			local effect = this.Const.Tactical.MortarImpactParticles[i];
			this.Tactical.spawnParticleEffect(false, effect.Brushes, tag.TargetTile, effect.Delay, effect.Quantity, effect.LifeTimeQuantity, effect.SpawnRate, effect.Stages, this.createVec(0, 0));
		}

		local tiles_ = getAffectedTiles(tag.TargetTile);
		foreach( t in tiles_ )
		{
			if (t.IsOccupiedByActor)
			{
				local target = t.getEntity();

				if (target.getMoraleState() != this.Const.MoraleState.Ignore)
				{
					target.checkMorale(-1, 0);
					target.getSkills().add(this.new("scripts/skills/effects/shellshocked_effect"));
				}

				local hitInfo = clone this.Const.Tactical.HitInfo;
				hitInfo.DamageRegular = this.Math.rand(min, max);
				hitInfo.DamageArmor = hitInfo.DamageRegular * 0.7;
				hitInfo.DamageDirect = 0.2;
				hitInfo.BodyPart = 0;
				hitInfo.FatalityChanceMult = 0.0;
				hitInfo.Injuries = this.Const.Injury.BurningAndPiercingBody;
				target.onDamageReceived(tag.User, this, hitInfo);
			}

			if (t.Type != this.Const.Tactical.TerrainType.ShallowWater && t.Type != this.Const.Tactical.TerrainType.DeepWater)
			{
				t.clear(this.Const.Tactical.DetailFlag.Scorchmark);
				t.spawnDetail("impact_decal", this.Const.Tactical.DetailFlag.Scorchmark, false, true);
			}
		}

		local max_backlash = ::Math.round(max * 0.25);
		local hitInfo = clone this.Const.Tactical.HitInfo;
		hitInfo.DamageRegular = this.Math.rand(1, max_backlash);
		hitInfo.DamageDirect = 1.0;
		hitInfo.BodyPart = 0;
		hitInfo.FatalityChanceMult = 0.0;
		hitInfo.Injuries = this.Const.Injury.BurningAndPiercingBody;
		tag.User.onDamageReceived(tag.User, this, hitInfo);
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

	function getAffectedTiles( _targetTile )
	{
		local ret = [];
		this.Tactical.queryTilesInRange(_targetTile, 1, 1, false, [], this.onQueryTilesHit, ret);
		return ret;
	}

	function onQueryTilesHit( _tile, _ret )
	{
		_ret.push(_tile);
	}

	function loadAI()
	{
		local actor = this.getContainer().getActor();
		local agent = actor.getAIAgent();
		if (agent.findBehavior(::Const.AI.Behavior.ID.SpellCorpseExplosion) == null)
		{
			agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_spell_corpse_explosion"));
			agent.finalizeBehaviors();
		}
	}

});

