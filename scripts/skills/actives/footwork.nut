this.footwork <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.footwork";
		this.m.Name = "Footwork";
		this.m.Description = "Use skillful footwork to move without triggering free attacks.";
		this.m.Icon = "ui/perks/perk_25_active.png";
		this.m.IconDisabled = "ui/perks/perk_25_active_sw.png";
		this.m.Overlay = "perk_25_active";
		this.m.SoundOnUse = [
			"sounds/combat/footwork_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsTargetingActor = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsDisengagement = true;
		this.m.ActionPointCost = 3;
		this.m.FatigueCost = 20;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
	}

	function getTooltip()
	{
		local ret = [
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

		if (this.Tactical.isActive() && !this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Can only be used when in an opponent\'s Zone of Control[/color]"
			});
		}

		if (this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Can not be used while rooted[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		if (this.skill.isUsable()
			&& this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions())
			&& !this.getContainer().getActor().getCurrentProperties().IsRooted)
		{
			local myTile = this.getContainer().getActor().getTile();

			for( local i = 0; i < 6; i = i )
			{
				if (!myTile.hasNextTile(i))
				{
				}
				else
				{
					local nextTile = myTile.getNextTile(i);

					if (!nextTile.IsOccupiedByActor || this.Math.abs(nextTile.Level - myTile.Level) > 1)
					{
					}
					else
					{
						local entity = nextTile.getEntity();

						if (!entity.getCurrentProperties().IsStunned && !entity.isAlliedWith(this.getContainer().getActor()))
						{
							return true;
						}
					}
				}

				i = ++i;
			}
		}
		else
		{
			return false;
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.getContainer().getActor().getSkills().hasSkill("perk.legend_backflip"))
		{
			this.m.MaxRange = 2;
		}

		this.m.FatigueCostMult = _properties.IsFleetfooted ? 0.5 : 1.0;

		if (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_grunt_potion"))
		{
			this.m.ActionPointCost = 2;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		if (!_targetTile.IsEmpty)
		{
			return false;
		}

		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.Tactical.getNavigator().teleport(_user, _targetTile, null, null, false);
		return true;
	}

});

