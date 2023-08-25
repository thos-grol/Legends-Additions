//TODO: duplicate darkflight ai, dupilicate gruesome feast skill and add claw swipe
this.nachzerer_leap <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.nachzerer_leap";
		this.m.Name = "Leap";
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
		this.m.MinRange = 2;
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
		if (!_targetTile.IsEmpty) return false;
		return true;
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
		//Scan 6 adjacent tiles
		local victims = [];
		for( local i = 0; i < 6; i = ++i )
		{
			if (!_targetTile.hasNextTile(i)) continue;
			local next_tile = _targetTile.getNextTile(i);
			if (!next_tile.IsOccupiedByActor) continue;
			local actor = next_tile.getEntity();
			if (actor.isAlliedWith(_entity)) continue;
			ZOC.push(actor);
		}

		//Gets random victim
		if (victims.len() == 0)
		{
			if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " leaps");
			return;
		}
		local victim = ::MSU.Array.rand(victims);

		//Perform claw attack
		if (!victim.isHiddenToPlayer())
		{
			local layers = this.Const.ShakeCharacterLayers[this.Const.BodyPart.Body];
			this.Tactical.getShaker().shake(victim, myTile, 2);
		}
		if (_tag.OldTile.IsVisibleForPlayer || myTile.IsVisibleForPlayer) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_entity) + " leaps and swipes at " + this.Const.UI.getColorizedEntityName(victim));

		this.spawnAttackEffect(victim.getTile(), this.Const.Tactical.AttackEffectClaws);

		local claw_sounds = [
			"sounds/enemies/ghoul_claws_01.wav",
			"sounds/enemies/ghoul_claws_02.wav",
			"sounds/enemies/ghoul_claws_03.wav",
			"sounds/enemies/ghoul_claws_04.wav",
			"sounds/enemies/ghoul_claws_05.wav",
			"sounds/enemies/ghoul_claws_06.wav"
		];
		this.Sound.play(::MSU.Array.rand(claw_sounds), 200.0, _user.getPos(), this.Math.rand(95, 105) * 0.01);
		this.attackEntity(_user, victim);
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