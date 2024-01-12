this._curse_crystal_skull <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effect._curse_crystal_skull";
		this.m.Name = "";
		this.m.Description = "";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsHidden = true;
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(actor) + "'s Cursed Crystal Skull comes alive");

		//50 resolve -> 75% chance to backfire
		//100 resolve -> 25% chance to backfire
		//5% chance to backfire minimum
		local targetTile = actor.getTile();
		local resolve = actor.getCurrentProperties().getBravery();
		if (::Math.rand(1, 100) <= ::Math.minf(95, resolve - 25))
		{
			local targets = getAffectedTiles(targetTile);
			if (targets.len() == 0) return;
			targetTile = ::MSU.Array.rand(targets); //success
		}

		scream( actor, targetTile );
	}

	function getAffectedTiles( _origin )
	{
		local ret = [];
		this.Tactical.queryTilesInRange(_origin, 1, 3, false, [], this.onQueryTilesHit, ret);
		return ret;
	}

	function onQueryTilesHit( _tile, _ret )
	{
		if (!_tile.IsOccupiedByActor) return;
		if (!_tile.getEntity().isAttackable()) return;
		_ret.push(_tile);
	}

	function scream( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " [Horrific Scream] " + ::Const.UI.getColorizedEntityName(_targetTile.getEntity()));
		}

		this.Sound.play("sounds/enemies/horrific_scream_01.wav", 4.0);

		_targetTile.getEntity().checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		_targetTile.getEntity().checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		_targetTile.getEntity().checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);
		_targetTile.getEntity().checkMorale(-1, 0, ::Const.MoraleCheckType.MentalAttack);

		local hitInfo = clone ::Const.Tactical.HitInfo;
			hitInfo.DamageRegular = ::Math.rand(15, 45);
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = ::Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			_targetTile.getEntity().onDamageReceived(_user, this, hitInfo);

		return true;
	}

});
