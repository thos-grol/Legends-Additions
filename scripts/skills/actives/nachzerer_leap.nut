this.nachzerer_leap <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 2
	},
	function create()
	{
		this.m.ID = "actives.nachzerer_leap";
		this.m.Name = "Leap";
		this.m.Description = "Disapparate from your current location and reappear on the other side of the battlefield";
		this.m.Icon = "skills/darkflight.png";
		this.m.IconDisabled = "skills/darkflight_bw.png";
		this.m.Overlay = "active_28";
		this.m.SoundOnUse = [
			"sounds/enemies/ghoul_claws_06.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/ghoul_death_03.wav",
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OtherTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 6;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			}
		];
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty) return false;

		return true;
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.m.Cooldown == 0;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 2;
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile,
			OnDone = this.onTeleportDone,
			OnTeleportStart = this.onTeleportStart
		};
		::logInfo("Leap 0");

		if (_user.getTile().IsVisibleForPlayer)
		{
			local _tile = _user.getTile()
			if (this.Tactical.isValidTile(_tile.X, _tile.Y) && ::Const.Tactical.DustParticles.len() != 0)
			{
				for( local i = 0; i < ::Const.Tactical.DustParticles.len(); i = i )
				{
					this.Tactical.spawnParticleEffect(false, ::Const.Tactical.DustParticles[i].Brushes, _tile, ::Const.Tactical.DustParticles[i].Delay, ::Const.Tactical.DustParticles[i].Quantity * 0.5, ::Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, ::Const.Tactical.DustParticles[i].SpawnRate, ::Const.Tactical.DustParticles[i].Stages);
					i = ++i;
				}
			}

			this.Time.scheduleEvent(this.TimeUnit.Virtual, 200, this.onTeleportStart, tag);
		}
		else this.onTeleportStart(tag);

		return true;
	}

	function onTeleportStart( _tag )
	{
		::logInfo("Leap 1");
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnDone, _tag, false, 3.0);
	}

	function onTeleportDone( _entity, _tag )
	{
		::logInfo("Leap 2");
		if (!_entity.isHiddenToPlayer())
		{
			local _tile = _tag.User.getTile()
			if (this.Tactical.isValidTile(_tile.X, _tile.Y) && ::Const.Tactical.DustParticles.len() != 0)
			{
				for( local i = 0; i < ::Const.Tactical.DustParticles.len(); i = i )
				{
					this.Tactical.spawnParticleEffect(false, ::Const.Tactical.DustParticles[i].Brushes, _tile, ::Const.Tactical.DustParticles[i].Delay, ::Const.Tactical.DustParticles[i].Quantity * 0.5, ::Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, ::Const.Tactical.DustParticles[i].SpawnRate, ::Const.Tactical.DustParticles[i].Stages);
					i = ++i;
				}
			}

			if (_entity.getTile().IsVisibleForPlayer && _tag.Skill.m.SoundOnHit.len() > 0)
				this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, _entity.getPos());
		}
		::logInfo("Leap 3");
	}

	function getTargets( _user )
	{
		local ret = {
			Tiles = [],
			User = _user
		};
		this.Tactical.queryTilesInRange(_user.getTile(), this.m.MinRange, this.m.MaxRange, false, [], this.onQueryTilesActor, ret);
		return ret.Tiles;
	}

	function onQueryTilesActor( _tile, _ret )
	{
		if (_tile.IsEmpty) return;
		if (_tile.getEntity() == null) return;
		if (!_tile.getEntity().isAttackable()) return;
		if (!_tile.getEntity().isAlive() || _tile.getEntity().isDying()) return;
		if (_ret.User.isAlliedWith(_tile.getEntity())) return;
		_ret.Tiles.push(_tile);
	}
});