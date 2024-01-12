this.warcry <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "actives.warcry";
		this.m.Name = "Warcry";
		this.m.Description = "";
		this.m.Icon = "skills/active_41.png";
		this.m.IconDisabled = "skills/active_41.png";
		this.m.Overlay = "active_49";
		this.m.SoundOnUse = [
			"sounds/enemies/warcry_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 0;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.m.IsSpent;
	}

	function onTurnStart()
	{
		if (::Math.rand(1,100) <= 33) this.m.IsSpent = false;
	}

	function onUse( _user, _targetTile )
	{
		if (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
		{
			this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Warcry");
		}

		local tag = {
			User = _user
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1000, this.onDelayedEffect, tag);
		this.m.IsSpent = true;
		return true;
	}

	function onDelayedEffect( _tag )
	{
		local mytile = _tag.User.getTile();
		local actors = this.Tactical.Entities.getAllInstances();

		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (a.getID() == _tag.User.getID())
				{
					continue;
				}

				if (a.getFaction() == _tag.User.getFaction())
				{
					local difficulty = 10 - ::Math.pow(a.getTile().getDistanceTo(mytile), ::Const.Morale.EnemyKilledDistancePow);

					if (a.getMoraleState() == ::Const.MoraleState.Fleeing)
					{
						a.checkMorale(::Const.MoraleState.Wavering - ::Const.MoraleState.Fleeing, difficulty);
					}
					else
					{
						a.checkMorale(1, difficulty);
					}

					a.setFatigue(a.getFatigue() - 20);
				}
				else if (!a.isAlliedWith(_tag.User))
				{
					local difficulty = 5 + ::Math.pow(a.getTile().getDistanceTo(mytile), ::Const.Morale.AllyKilledDistancePow);
					a.checkMorale(-1, difficulty, ::Const.MoraleCheckType.MentalAttack);
				}
			}
		}
	}

});

