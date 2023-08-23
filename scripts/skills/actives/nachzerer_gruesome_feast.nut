this.nachzerer_gruesome_feast <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.nachzerer_gruesome_feast";
		this.m.Name = "Gruesome Feast";
		this.m.Description = "Disapparate from your current location and reappear on the other side of the battlefield";
		this.m.Icon = "skills/darkflight.png";
		this.m.IconDisabled = "skills/darkflight_bw.png";
		this.m.Overlay = "active_28";
		this.m.SoundOnUse = [
			"sounds/combat/jump_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OtherTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 0;
		this.m.MinRange = 1;
		this.m.MaxRange = 5;
		this.m.MaxLevelDifference = 3;

		this.m.ChanceDecapitate = 75;
		this.m.ChanceDisembowel = 75;
		this.m.ChanceSmash = 0;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return !_targetTile.IsEmpty
			&& _targetTile.IsCorpseSpawned
			&& _targetTile.Properties.get("Corpse").IsConsumable
			&& !this.m.Used;
	}

	function onUse( _user, _targetTile )
	{
		this.m.IsSpent = true;
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile
		};
		if (tag.OldTile.IsVisibleForPlayer || _targetTile.IsVisibleForPlayer) this.spawnDust(_user, _targetTile, tag);
		this.Tactical.getNavigator().teleport(_user, _targetTile, this.onTeleportDone, tag, false, 2.0);
		return true;
	}

	function onTeleportDone( _entity, _tag )
	{
		_targetTile = _tag.TargetTile;
		_user = _tag.User;

		//spawn effects, remove corpse
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

			if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " feasts on a corpse. Human units that fail the resolve check are dazed.");
		}
		if (!_user.isHiddenToPlayer()) this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onRemoveCorpse, _targetTile);
		else this.onRemoveCorpse(_targetTile);

		this.spawnBloodbath(_targetTile);

		local feast_sounds = [
			"sounds/enemies/gruesome_feast_01.wav",
			"sounds/enemies/gruesome_feast_02.wav",
			"sounds/enemies/gruesome_feast_03.wav"
		];
		this.Sound.play(::MSU.Array.rand(feast_sounds), 200.0, _user.getPos(), this.Math.rand(95, 105) * 0.01);

		//heal self and temp injuries
		_user.setHitpoints(this.Math.min(_user.getHitpoints() + 50, _user.getHitpointsMax()));
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

		//daze actors that are non immune and fail the resolve check
		local actors = this.Tactical.Entities.getAllInstances();
		foreach( a in actors )
		{
			if (a.getID() == _user.getID() || _user.getTile().getDistanceTo(a.getTile()) > 5) continue;
			if (a.getFlags().has("monster")) continue;

			local roll = this.Math.rand(1, 100);
			local chance = this.Math.min(100, this.Math.max(100 - a.getCurrentProperties().getBravery(), 0));

			if (roll > chance) continue;
			a.getSkills().add(this.new("scripts/skills/effects/legend_dazed_effect"));
		}
		return true;
	}

	function onRemoveCorpse( _tag )
	{
		this.Tactical.Entities.removeCorpse(_tag);
		_tag.clear(this.Const.Tactical.DetailFlag.Corpse);
		_tag.Properties.remove("Corpse");
		_tag.Properties.remove("IsSpawningFlies");
	}

	function spawnBloodbath( _targetTile )
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

	function spawnDust(_user, _targetTile, _tag)
	{
		local myPos = _user.getPos();
		local targetPos = _targetTile.Pos;
		local distance = _tag.OldTile.getDistanceTo(_targetTile);
		local Dx = (targetPos.X - myPos.X) / distance;
		local Dy = (targetPos.Y - myPos.Y) / distance;

		for( local i = 0; i < distance; i = ++i )
		{
			local x = myPos.X + Dx * i;
			local y = myPos.Y + Dy * i;
			local tile = this.Tactical.worldToTile(this.createVec(x, y));

			if (this.Tactical.isValidTile(tile.X, tile.Y) && this.Const.Tactical.DustParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.DustParticles.len(); i = ++i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.DustParticles[i].Brushes, this.Tactical.getTile(tile), this.Const.Tactical.DustParticles[i].Delay, this.Const.Tactical.DustParticles[i].Quantity * 0.5, this.Const.Tactical.DustParticles[i].LifeTimeQuantity * 0.5, this.Const.Tactical.DustParticles[i].SpawnRate, this.Const.Tactical.DustParticles[i].Stages);
				}
			}
		}
	}

});