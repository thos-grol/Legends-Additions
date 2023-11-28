this.legend_gruesome_feast <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.legend_gruesome_feast";
		this.m.Name = "Gruesome Feast";
		this.m.Description = "Feast on a corpse to regain health and cure injuries. \n\nWill automatically feast on corpses at the end of the battle and restore full health and remove injuries.";
		this.m.Icon = "skills/gruesome_square.png";
		this.m.IconDisabled = "skills/gruesome_square_bw.png";
		this.m.Overlay = "gruesome_square";
		this.m.SoundOnUse = [
			"sounds/enemies/gruesome_feast_01.wav",
			"sounds/enemies/gruesome_feast_02.wav",
			"sounds/enemies/gruesome_feast_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.UtilityTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = true;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsAudibleWhenHidden = false;
		this.m.IsUsingActorPitch = true;
		this.m.ActionPointCost = 7;
		this.m.FatigueCost = 25;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
		this.m.MaxLevelDifference = 4;
	}

	function getTooltip()
	{
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
		if (_targetTile.IsEmpty)
		{
			return false;
		}

		if (!_targetTile.IsCorpseSpawned)
		{
			return false;
		}

		if (!_targetTile.Properties.get("Corpse").IsConsumable)
		{
			return false;
		}

		return true;
	}

	function spawnBloodbath( _targetTile )
	{
		for( local i = 0; i != this.Const.CorpsePart.len(); i = i )
		{
			_targetTile.spawnDetail(this.Const.CorpsePart[i]);
			i = ++i;
		}

		for( local i = 0; i != 6; i = i )
		{
			if (!_targetTile.hasNextTile(i))
			{
			}
			else
			{
				local tile = _targetTile.getNextTile(i);

				for( local n = this.Math.rand(0, 2); n != 0; n = n )
				{
					local decal = this.Const.BloodDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodDecals[this.Const.BloodType.Red].len() - 1)];
					tile.spawnDetail(decal);
					n = --n;
				}
			}

			i = ++i;
		}

		local myTile = this.getContainer().getActor().getTile();

		for( local n = 2; n != 0; n = n )
		{
			local decal = this.Const.BloodDecals[this.Const.BloodType.Red][this.Math.rand(0, this.Const.BloodDecals[this.Const.BloodType.Red].len() - 1)];
			myTile.spawnDetail(decal);
			n = --n;
		}
	}

	function onRemoveCorpse( _tag )
	{
		this.Tactical.Entities.removeCorpse(_tag);
		_tag.clear(this.Const.Tactical.DetailFlag.Corpse);
		_tag.Properties.remove("Corpse");
		_tag.Properties.remove("IsSpawningFlies");
	}

	function onUse( _user, _targetTile )
	{
        _targetTile = _user.getTile();

        if (_targetTile.IsVisibleForPlayer)
        {
            if (::Const.Tactical.GruesomeFeastParticles.len() != 0)
            {
                for( local i = 0; i < ::Const.Tactical.GruesomeFeastParticles.len(); i = i )
                {
                    this.Tactical.spawnParticleEffect(false, ::Const.Tactical.GruesomeFeastParticles[i].Brushes, _targetTile, ::Const.Tactical.GruesomeFeastParticles[i].Delay, ::Const.Tactical.GruesomeFeastParticles[i].Quantity, ::Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, ::Const.Tactical.GruesomeFeastParticles[i].SpawnRate, ::Const.Tactical.GruesomeFeastParticles[i].Stages);
                    i = ++i;
                }
            }

            if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
                this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_user) + " feasts on a corpse");
        }

        if (!_user.isHiddenToPlayer()) this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onRemoveCorpse, _targetTile);
        else this.onRemoveCorpse(_targetTile);

        this.spawnBloodbath(_targetTile);
        _user.setHitpoints(this.Math.min(_user.getHitpoints() + 50, _user.getHitpointsMax()));
        local skills = _user.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);

        foreach( s in skills )
        {
            if (s.getOrder() == ::Const.SkillOrder.PermanentInjury) continue;
            s.removeSelf();
        }

        _user.onUpdateInjuryLayer();
        return true;
    }

	// o.onAdded <- function()
	// {
	// 	local actor = this.getContainer().getActor();
	// 	if (actor.isPlayerControlled()) return;
	// 	local agent = actor.getAIAgent();
	// 	if (agent.findBehavior(::Const.AI.Behavior.ID.GruesomeFeast) == null)
	// 	{
	// 		agent.addBehavior(::new("scripts/ai/tactical/behaviors/ai_gruesome_feast_potion"));
	// 		agent.finalizeBehaviors();
	// 	}
	// }

});

