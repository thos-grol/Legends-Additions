::mods_hookExactClass("ui/screens/tactical/modules/turn_sequence_bar/turn_sequence_bar", function (o)
{
	o.flashProgressbars = function( _flashActionPointsProgressbar, _flashFatigueProgressbar )
	{
		local activeEntity = this.getActiveEntity();

		if (activeEntity == null) return;
		local flashBars;
		if (_flashActionPointsProgressbar)
		{
			flashBars = {
				attackPoints = true
			};
		}

		if (_flashFatigueProgressbar)
		{
			if (flashBars == null)
			{
				flashBars = {
					fatigue = true
				};
			}
			else
			{
				flashBars.fatigue <- true;
			}
		}

		if (flashBars != null)
		{
			this.m.JSHandle.asyncCall("flashProgressbars", flashBars);
		}
	}

	o.initNextRound = function()
	{
		if (this.m.IsBattleEnded)
		{
			this.logDebug("Info: Battle ended after " + this.m.CurrentRound + " Round(s).");
			return;
		}

		this.m.IsLocked = true;
		this.m.JSHandle.call("clear", null);

		foreach( entity in this.m.CurrentEntities )
		{
			entity.onTurnEnd();
		}

		foreach( entity in this.m.AllEntities )
		{
			entity.onRoundEnd();
		}

		this.m.CurrentEntities = [];
		this.m.ActiveEntityMouseHover = null;

		if (this.m.AllEntities.len() > 0)
		{
			++this.m.CurrentRound;
			::Z.Log.next_round(this.m.CurrentRound);

			if (this.m.OnNextRoundListener != null)
			{
				this.m.OnNextRoundListener(this.m.CurrentRound);
			}

			local temp = clone this.m.AllEntities;

			foreach( entity in temp )
			{
				entity.onRoundStart();
			}

			if (this.m.AllEntities.len() == 0)
			{
				return;
			}

			this.m.CurrentEntities = clone this.m.AllEntities;
			this.m.CurrentEntities.sort(this.compareEntitiesByInitiative);

			foreach( entity in this.m.CurrentEntities )
			{
				entity.setWaitActionSpent(false);
			}

			this.m.CurrentEntities[0].onBeforeActivation();
			this.m.TurnPosition = 0;
			local entitiesToAdd = ::Math.min(this.m.CurrentEntities.len(), this.m.MaxVisibleEntities);

			for( local i = 0; i < entitiesToAdd; i = ++i )
			{
				this.m.JSHandle.call("addEntity", this.convertEntityToUIData(this.m.CurrentEntities[i], i == this.m.CurrentEntities.len() - 1));
			}

			this.m.IsSkippingRound = false;
			this.m.JSHandle.call("setEndTurnAllButtonVisible", true);
		}
	}

	o.initNextTurn = function( _force = false )
	{
		if (this.m.IsBattleEnded)
		{
			return;
		}

		if (this.m.IsLocked)
		{
			return;
		}

		if (!_force && (this.Time.hasEventScheduled(this.TimeUnit.Virtual) || this.Tactical.State.isPaused()))
		{
			return;
		}

		if (this.m.OnNextTurnListener != null)
		{
			if (!this.m.OnNextTurnListener())
			{
				return;
			}
		}

		if (this.m.CurrentEntities.len() <= 1)
		{
			if (!this.m.IsInitNextRound)
			{
				this.m.IsInitNextRound = true;
				this.m.CheckEnemyRetreat = true;
			}

			return;
		}

		::Z.Log.next_turn();

		local activeEntity = this.m.CurrentEntities[0];

		if (this.m.CurrentEntities.len() > 1)
		{
			this.m.CurrentEntities[1].onBeforeActivation();
		}

		this.m.IsLocked = true;
		this.m.JSHandle.asyncCall("removeEntity", activeEntity.getID());
		activeEntity.onTurnEnd();
		this.m.CurrentEntities.remove(0);
		++this.m.TurnPosition;
		this.m.IsLastEntityPlayerControlled = activeEntity.isPlayerControlled();

		if (this.m.CurrentEntities.len() >= this.m.MaxVisibleEntities)
		{
			local entityToAddIndex = ::Math.min(this.m.CurrentEntities.len() - 1, this.m.MaxVisibleEntities - 1);
			this.m.JSHandle.asyncCall("addEntity", this.convertEntityToUIData(this.m.CurrentEntities[entityToAddIndex], entityToAddIndex == this.m.CurrentEntities.len() - 1));
		}
	}
});