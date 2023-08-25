this.nachzerer_gruesome_feast <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 1
	},
	function create()
	{
		this.m.ID = "actives.nachzerer_gruesome_feast";
		this.m.Name = "Darkflight";
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
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OtherTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 0;
		this.m.MinRange = 0;
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
		this.m.Cooldown = 1;
		local tag = {
			Skill = this,
			User = _user,
			TargetTile = _targetTile,
			OnDone = this.onTeleportDone,
			OnFadeIn = this.onFadeIn,
			OnRemoveCorpse = this.onRemoveCorpse,
			OnFeasted = this.onFeasted,
			OnTeleportStart = this.onTeleportStart
		};

		if (_user.getTile().IsVisibleForPlayer)
		{
			local _tile = _user.getTile()
			if (this.Tactical.isValidTile(_tile.X, _tile.Y) && this.Const.Tactical.DustParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, _tile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
					i = ++i;
				}
			}

			this.Time.scheduleEvent(this.TimeUnit.Virtual, 400, this.onTeleportStart, tag);
		}
		else this.onTeleportStart(tag);

		return true;
	}

	function onTeleportStart( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, _tag.OnDone, _tag, false, 3.0);
	}

	function onTeleportDone( _entity, _tag )
	{
		if (!_entity.isHiddenToPlayer())
		{
			local _tile = _tag.User.getTile()
			if (this.Tactical.isValidTile(_tile.X, _tile.Y) && this.Const.Tactical.DustParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, _tile, this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
					i = ++i;
				}
			}
			this.Time.scheduleEvent(this.TimeUnit.Virtual, 800, _tag.OnFadeIn, _tag);

			if (_entity.getTile().IsVisibleForPlayer && _tag.Skill.m.SoundOnHit.len() > 0)
				this.Sound.play(_tag.Skill.m.SoundOnHit[this.Math.rand(0, _tag.Skill.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _entity.getPos());
		}
		else _tag.OnFadeIn(_tag);
	}

	function onFadeIn( _tag )
	{
		local _targetTile = _tag.TargetTile;
		local _user = _tag.User;

		// Spawn Gruesome Feast particles
		if (_targetTile.IsVisibleForPlayer)
		{
			if (this.Const.Tactical.GruesomeFeastParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.GruesomeFeastParticles.len(); i = i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.GruesomeFeastParticles[i].Brushes, _targetTile, this.Const.Tactical.GruesomeFeastParticles[i].Delay, this.Const.Tactical.GruesomeFeastParticles[i].Quantity, this.Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, this.Const.Tactical.GruesomeFeastParticles[i].SpawnRate, this.Const.Tactical.GruesomeFeastParticles[i].Stages);
					i = ++i;
				}
			}
		}

		// start onRemoveCorpse
		if (!_user.isHiddenToPlayer()) this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, _tag.OnRemoveCorpse, _targetTile);
		else _tag.OnRemoveCorpse(_targetTile);

		// Spawn Bloodbath
		if (_targetTile.IsVisibleForPlayer)
		{
			for( local i = 0; i != this.Const.CorpsePart.len(); i = ++i )
			{
				_targetTile.spawnDetail(this.Const.CorpsePart[i]);
			}

			for( local i = 0; i != 6; i = ++i )
			{
				if (!_targetTile.hasNextTile(i)) continue;
				local tile = _targetTile.getNextTile(i);
				for( local n = this.Math.rand(0, 2); n != 0; n = n )
				{
					local decal = this.Const.BloodDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodDecals[this.Const.BloodType.Red].len() - 1)];
					tile.spawnDetail(decal);
					n = --n;
				}
			}

			for( local n = 2; n != 0; n = --n )
			{
				local decal = this.Const.BloodDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodDecals[this.Const.BloodType.Red].len() - 1)];
				_targetTile.spawnDetail(decal);
			}
		}

		// Play feast sounds Bloodbath
		local feast_sounds = [
			"sounds/enemies/gruesome_feast_01.wav",
			"sounds/enemies/gruesome_feast_02.wav",
			"sounds/enemies/gruesome_feast_03.wav"
		];
		this.Sound.play(::MSU.Array.rand(feast_sounds), 200.0, _user.getPos(), this.Math.rand(95, 105) * 0.01);

		// start onFeasted
		if (!_user.isHiddenToPlayer()) this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, _tag.OnFeasted, _tag);
		else _tag.OnFeasted(_tag);
	}

	function onFadeDone( _tag )
	{
	}

	function onRemoveCorpse( _tag )
	{
		this.Tactical.Entities.removeCorpse(_tag);
		_tag.clear(this.Const.Tactical.DetailFlag.Corpse);
		_tag.Properties.remove("Corpse");
		_tag.Properties.remove("IsSpawningFlies");
	}

	function onFeasted( _tag )
	{
		local _user = _tag.User;

		if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " feasts on a corpse.");

		//heal self and temp injuries
		_user.setHitpoints(this.Math.min(_user.getHitpoints() + 100, _user.getHitpointsMax()));
		local skills = _user.getSkills().getAllSkillsOfType(this.Const.SkillType.Injury);
		foreach( s in skills )
        {
            if (s.getOrder() == ::Const.SkillOrder.PermanentInjury) continue;
            s.removeSelf();
        }
		_user.onUpdateInjuryLayer();

		//remove maddening hunger
		_user.getSkills().removeByID("effects.nachzerer_maddening_hunger");

		//add 2 stacks of hair armor
		local nachzerer_hair_armor = _user.getSkills().getSkillByID("perk.nachzerer_hair_armor");
		if (nachzerer_hair_armor != null) nachzerer_hair_armor.addCharges(2);
	}
});

