this.nachzerer_leap <- this.inherit("scripts/skills/skill", {
	m = {
		Cooldown = 4
	},
	function create()
	{
		this.m.ID = "actives.nachzerer_leap";
		this.m.Name = "Leap";
		this.m.Description = "";
		this.m.Icon = "skills/active_52.png";
		this.m.IconDisabled = "skills/active_52_sw.png";
		this.m.Overlay = "active_52";
		this.m.Description = "Long and sharp claws that can tear flesh with ease.";
		this.m.KilledString = "Ripped to shreds";
		this.m.SoundOnUse = [
			"sounds/combat/jump_01.wav"
		];
		this.m.SoundOnHit = [
			"sounds/enemies/ghoul_claws_01.wav",
			"sounds/enemies/ghoul_claws_02.wav",
			"sounds/enemies/ghoul_claws_03.wav",
			"sounds/enemies/ghoul_claws_04.wav",
			"sounds/enemies/ghoul_claws_05.wav",
			"sounds/enemies/ghoul_claws_06.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsUsingActorPitch = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 45;
		this.m.MinRange = 2;
		this.m.MaxRange = 4;

		this.m.MaxLevelDifference = 1;
		this.m.ChanceDecapitate = 75;
		this.m.ChanceDisembowel = 75;
		this.m.ChanceSmash = 0;
		this.m.InjuriesOnBody = this.Const.Injury.CuttingBody;
		this.m.InjuriesOnHead = this.Const.Injury.CuttingHead;
		this.m.DirectDamageMult = 0.25;
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

	function isUsable()
	{
		local actor = this.getContainer().getActor();
		return this.skill.isUsable() && !actor.getCurrentProperties().IsRooted && this.m.Cooldown == 0 && actor.getSurroundedCount() + 1 >= 2;
	}


	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!_targetTile.IsEmpty) return false;
		if (this.Math.abs(_targetTile.Level - _originTile.Level) > this.m.MaxLevelDifference) return false;
		return true;
	}

	function onTurnStart()
	{
		this.m.Cooldown = this.Math.max(0, this.m.Cooldown - 1);
	}

	function onUse( _user, _targetTile )
	{
		this.m.Cooldown = 4;
		local tag = {
			Skill = this,
			User = _user,
			OldTile = _user.getTile(),
			TargetTile = _targetTile,
			OnRepelled = this.onRepelled
		};

		if (tag.OldTile.IsVisibleForPlayer || _targetTile.IsVisibleForPlayer)
		{
			local myPos = _user.getPos();
			local targetPos = _targetTile.Pos;
			local distance = tag.OldTile.getDistanceTo(_targetTile);
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

		this.Tactical.getNavigator().teleport(_user, _targetTile, this.onTeleportDone, tag, false, 2.0);
		return true;
	}

	function onRepelled( _tag )
	{
		this.Tactical.getNavigator().teleport(_tag.User, _tag.TargetTile, null, null, false);
	}

	function onTeleportDone( _entity, _tag )
	{
		local myTile = _entity.getTile();
		local potentialVictims = [];
		local betterThanNothing;
		local ZOC = [];
		local dirToTarget = _tag.OldTile.getDirectionTo(myTile);

		for( local i = 0; i != 6; i = ++i )
		{
			if (!myTile.hasNextTile(i)) continue;

			local tile = myTile.getNextTile(i);
			if (!tile.IsOccupiedByActor) continue;

			local actor = tile.getEntity();
			if (!actor.isAlliedWith(_entity))
			{
				ZOC.push(actor);
				if (betterThanNothing == null) betterThanNothing = actor;
				potentialVictims.push(actor);
			}
		}

		foreach( actor in ZOC )
		{
			if (!actor.onMovementInZoneOfControl(_entity, true)) continue;

			if (actor.onAttackOfOpportunity(_entity, true))
			{
				if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " leaps and is repelled");
				if (!_entity.isAlive() || _entity.isDying()) return;

				local dir = myTile.getDirectionTo(_tag.OldTile);

				if (myTile.hasNextTile(dir))
				{
					local tile = myTile.getNextTile(dir);
					if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getDistanceTo(actor.getTile()) > 1)
					{
						_tag.TargetTile = tile;
						this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}

				for( local i = 0; i != 6; i = ++i )
				{
					if (!myTile.hasNextTile(i)) continue;
					local tile = myTile.getNextTile(i);
					if (tile.IsEmpty && this.Math.abs(tile.Level - myTile.Level) <= 1 && tile.getZoneOfControlCountOtherThan(_entity.getAlliedFactions()) == 0)
					{
						_tag.TargetTile = tile;
						this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
						return;
					}
				}

				_tag.TargetTile = _tag.OldTile;
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 50, _tag.OnRepelled, _tag);
				return;
			}
		}

		if (potentialVictims.len() == 0 && betterThanNothing != null) potentialVictims.push(betterThanNothing);

		if (potentialVictims.len() != 0)
		{
			local victim = potentialVictims[this.Math.rand(0, potentialVictims.len() - 1)];

			if (!victim.isHiddenToPlayer())
			{
				local layers = this.Const.ShakeCharacterLayers[this.Const.BodyPart.Body];
				this.Tactical.getShaker().shake(victim, myTile, 2);
			}

			if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " leaps and swipes " + this.Const.UI.getColorizedEntityName(victim));
			}

			this.spawnAttackEffect(victim.getTile(), this.Const.Tactical.AttackEffectClaws);
			this.Sound.play("sounds/enemies/ghoul_claws_01.wav", 200.0, _user.getPos(), this.Math.rand(95, 105) * 0.01);
			this.attackEntity(_user, victim);
			return;
		}

		if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " leaps");
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_targetEntity.getHitpoints() <= 0 || !_targetEntity.isAlive() || _targetEntity.getFlags().has("undead")) return;
        if (_targetEntity.getCurrentProperties().IsImmuneToBleeding || hp - _targetEntity.getHitpoints() < this.Const.Combat.MinDamageToApplyBleeding) return;

		if (!_targetEntity.isHiddenToPlayer()) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " has been bled by the Nachzerer's sharp claws.");

        local effect = this.new("scripts/skills/effects/bleeding_effect");
        if (_user.getFaction() == this.Const.Faction.Player) effect.setActor(this.getContainer().getActor());
        effect.setDamage(15);
        target.getSkills().add(effect);
	}

});

