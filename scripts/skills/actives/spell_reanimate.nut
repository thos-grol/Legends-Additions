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

		this.m.ManaCost = 2;
		this.m.Cooldown_Max = 1;
		this.m.Cooldown = 1;

		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 8;
		this.m.MaxLevelDifference = 4;
	}

	//Unique fns
	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile)) return false;
		if (!this.MSU.Tile.canResurrectOnTile(_targetTile)) return false;
		if (!_targetTile.IsEmpty) return false;
		return true;
	}

	function cast( _user, _targetTile )
	{
		if (_targetTile.IsVisibleForPlayer)
		{
			if (this.Const.Tactical.RaiseUndeadParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.RaiseUndeadParticles.len(); i = i )
				{
					this.Tactical.spawnParticleEffect(true, this.Const.Tactical.RaiseUndeadParticles[i].Brushes, _targetTile, this.Const.Tactical.RaiseUndeadParticles[i].Delay, this.Const.Tactical.RaiseUndeadParticles[i].Quantity, this.Const.Tactical.RaiseUndeadParticles[i].LifeTimeQuantity, this.Const.Tactical.RaiseUndeadParticles[i].SpawnRate, this.Const.Tactical.RaiseUndeadParticles[i].Stages);
					i = ++i;
				}
			}

			if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " [Raise Undead]");

				if (this.m.SoundOnHit.len() != 0)
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill * 1.2, _user.getPos());
				}
			}
		}

		this.spawnUndead(_user, _targetTile);
		return true;
	}

	function spawnUndead( _user, _tile )
	{
		local p = _tile.Properties.get("Corpse");
		p.Faction = _user.getFaction();
		if (p.Faction == this.Const.Faction.Player) p.Faction = this.Const.Faction.PlayerAnimals;

		local e = this.Tactical.Entities.onResurrect(p, true);

		if (e != null) e.getSprite("socket").setBrush(_user.getSprite("socket").getBrush().Name);
	}

});

