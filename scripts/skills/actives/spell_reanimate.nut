//TODO: make reanimate more dramatic
	//add black flare to caster
	//add delay and add whispers
this.spell_reanimate <- this.inherit("scripts/skills/_magic_active", {
	m = {},
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
		spawn_particles(_user, _targetTile);
		spawnUndead(_user, _targetTile);
		return true;
	}

	//Helper

	function spawnUndead( _user, _tile )
	{
		local p = _tile.Properties.get("Corpse");
		p.Faction = _user.getFaction();
		if (p.Faction == this.Const.Faction.Player) p.Faction = this.Const.Faction.PlayerAnimals;

		local e = this.Tactical.Entities.onResurrect(p, true);

		if (e != null) e.getSprite("socket").setBrush(_user.getSprite("socket").getBrush().Name);
	}

	function canResurrectOnTile( _tile, _force = false )
	{
		return _tile.IsCorpseSpawned
			&& ( _tile.Properties.get("Corpse").IsResurrectable || _force
				|| !("FleshNotAllowed" in _tile.Properties.get("Corpse")) );
	}

	function spawn_particles( _user, _targetTile )
	{
		if (!_targetTile.IsVisibleForPlayer) return;

		if (::Const.Tactical.RaiseUndeadParticles.len() != 0)
		{
			for( local i = 0; i < ::Const.Tactical.RaiseUndeadParticles.len(); i = i )
			{
				this.Tactical.spawnParticleEffect(true, ::Const.Tactical.RaiseUndeadParticles[i].Brushes, _targetTile, ::Const.Tactical.RaiseUndeadParticles[i].Delay, ::Const.Tactical.RaiseUndeadParticles[i].Quantity, ::Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, ::Const.Tactical.RaiseUndeadParticles[i].SpawnRate, ::Const.Tactical.RaiseUndeadParticles[i].Stages);
				i = ++i;
			}
		}

		if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
		{
			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Raise Undead");

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill * 1.2, _user.getPos());
			}
		}
	}

});

