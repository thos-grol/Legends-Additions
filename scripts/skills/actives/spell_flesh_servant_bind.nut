this.spell_flesh_servant_bind <- this.inherit("scripts/skills/_magic_active", {
	m = {
		Used = false,
		Name_ = null,
		Type_ = null,
		Skills = [],
		BaseProperties = {},
	},
	function create()
	{
		this.m.ID = "actives.spell.flesh_servant_bind";
		this.m.Name = "Bind Flesh Servant";
		this.m.Description = "";
		this.m.Icon = "skills/raisedead2.png"; //FIXME: ART flesh_servant_summon
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
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 4;

		this.m.IsSerialized = true;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return this.skill.onVerifyTarget(_originTile, _targetTile)
			&& canBind(_targetTile)
			&& _targetTile.IsEmpty;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.m.Used;
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

		this.Time.scheduleEvent(this.TimeUnit.Virtual, 2000, this.bind_undead.bindenv(this), {
			Skill = this,
			User = _user,
			TargetTile = _targetTile
		});
		return true;
	}

	//Helper

	function canBind( _tile )
	{
		return _tile.IsCorpseSpawned
			&& ( _tile.Properties.get("Corpse").IsResurrectable	|| !("FleshNotAllowed" in _tile.Properties.get("Corpse")) );
	}

	function bind_undead(tag)
	{
		local _info = tag.TargetTile.Properties.get("Corpse");

		if (_info.Name.len() != 0) this.m.Name_ = "Flesh Abomination (" + _info.Name + ")";
        else if (_info.CorpseName.len() != 0) this.m.Name_ = "Flesh Abomination (" + _info.CorpseName + ")";

		if (_info.BaseProperties["MeleeSkill"] >= _info.BaseProperties["RangedSkill"])
            this.m.Type_ = "scripts/entity/tactical/enemies/flesh_abomination";
        else this.m.Type_ = "scripts/entity/tactical/enemies/flesh_abomination_ranged";

		if ("Skills" in _info)
        {
            foreach(skill in _info.Skills)
            {
                this.m.Skills.push(skill)
            }
        }

        if ("BaseProperties" in _info)
        {
            this.m.BaseProperties.Bravery <- _info.BaseProperties["Bravery"];
            this.m.BaseProperties.Initiative <- _info.BaseProperties["Initiative"];
            this.m.BaseProperties.MeleeSkill <- _info.BaseProperties["MeleeSkill"];
            this.m.BaseProperties.RangedSkill <- _info.BaseProperties["RangedSkill"];
            this.m.BaseProperties.MeleeDefense <- _info.BaseProperties["MeleeDefense"];
            this.m.BaseProperties.RangedDefense <- _info.BaseProperties["RangedDefense"];
        }

		this.Tactical.Entities.removeCorpse(tag.TargetTile);
		tag.TargetTile.clear(this.Const.Tactical.DetailFlag.Corpse);
		tag.TargetTile.Properties.remove("Corpse");
		tag.TargetTile.Properties.remove("IsSpawningFlies");
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

	function onSerialize( _out )
	{
		this.skill.onSerialize(_out);
		_out.writeString(this.m.Name_);
		_out.writeString(this.m.Type_);
		::MSU.Utils.serialize(this.m.BaseProperties, _out);

		local scripts = [];
		foreach(skill in this.m.Skills)
		{
			if (skill.m.ID in ::Z.Map) 
				scripts.push(::Z.Map[skill.m.ID]);
		}
		::MSU.Utils.serialize(scripts, _out);
	}

	function onDeserialize( _in )
	{
		this.skill.onDeserialize(_in);
		this.m.Name_ = _in.readString();
		this.m.Type_ = _in.readString();
		this.m.BaseProperties = ::MSU.Utils.deserialize(_in);
		local scripts = ::MSU.Utils.deserialize(_in);
		foreach(script in scripts)
		{
			this.m.Skills.push(::new(script));
		}		
	}

	

});

