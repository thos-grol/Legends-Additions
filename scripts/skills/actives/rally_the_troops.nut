this.rally_the_troops <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rally_the_troops";
		this.m.Name = "Rally";
		this.m.Description = "Raaaaally! Use this character\'s inspirational resolve to rally nearby fleeing allies and push everyone to go the extra mile. A single character can only be rallied once per round.";
		this.m.Icon = "ui/perks/perk_42_active.png";
		this.m.IconDisabled = "ui/perks/perk_42_active_sw.png";
		this.m.Overlay = "perk_42_active";
		this.m.SoundOnUse = [
			"sounds/combat/rally_the_troops_01.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local bravery = ::Math.max(0, ::Math.floor(this.getContainer().getActor().getCurrentProperties().getBravery() * 0.4));
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
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Triggers a morale check to rally fleeing allies within 4 tiles distance, with a bonus to Will of [color=" + ::Const.UI.Color.PositiveValue + "]+" + bravery + "[/color] based on this character\'s Resolve"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Triggers a morale check to raise the morale of anyone wavering or worse within 4 tiles distance, with a bonus to Will of [color=" + ::Const.UI.Color.PositiveValue + "]+" + bravery + "[/color] based on this character\'s Resolve, but lowered by [color=" + ::Const.UI.Color.NegativeValue + "]-10[/color] per tile distance"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a chance to remove the Sleeping effect on cast. This chance is 40% of the resolve of the user."
			}
		];

		if (this.getContainer().hasSkill("effects.rallied"))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + ::Const.UI.Color.NegativeValue + "]Can not rally others the same turn as being rallied himself[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.rallied");
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local bravery = ::Math.floor(_user.getCurrentProperties().getBravery() * 0.4);
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (myTile.getDistanceTo(a.getTile()) > 4)
			{
				continue;
			}

			if (a.getFaction() != _user.getFaction())
			{
				continue;
			}

			this.logInfo("attempting to rally");

			if (a.getSkills().hasSkill("effects.charmed") || a.getSkills().hasSkill("effects.legend_intensely_charmed") || a.getSkills().hasSkill("effects.sleeping"))
			{
				local rand = ::Math.rand(1, 100);

				if (bravery > rand)
				{
					this.logInfo("Removing charms");
					a.getSkills().removeByID("effects.charmed");
					a.getSkills().removeByID("effects.sleeping");
					a.getSkills().removeByID("effects.legend_intensely_charmed");
				}
			}

			if (a.getMoraleState() >= ::Const.MoraleState.Steady)
			{
				continue;
			}

			this.logInfo("finding rally difficulty");
			local difficulty = bravery;
			this.logInfo("getting distance");
			local distance = a.getTile().getDistanceTo(myTile) * 10;
			this.logInfo("getting morale state");
			local morale = a.getMoraleState();

			if (a.getMoraleState() == ::Const.MoraleState.Fleeing)
			{
				this.logInfo("Turning back the fleeing");
				a.checkMorale(::Const.MoraleState.Wavering - ::Const.MoraleState.Fleeing, difficulty, ::Const.MoraleCheckType.Default, "status_effect_56");
			}
			else
			{
				this.logInfo("moral check for the rest");
				a.checkMorale(1, difficulty - distance, ::Const.MoraleCheckType.Default, "status_effect_56");
			}

			if (a.getSkills().hasSkill("effects.rallied"))
			{
				continue;
			}

			if (a.getSkills().hasSkill("effects.charmed") || a.getSkills().hasSkill("effects.legend_intensely_charmed") || a.getSkills().hasSkill("effects.sleeping"))
			{
				local rand = ::Math.rand(1, 100);

				if (bravery > rand)
				{
					a.getSkills().removeByID("effects.charmed");
					a.getSkills().removeByID("effects.sleeping");
					a.getSkills().removeByID("effects.legend_intensely_charmed");
				}
			}

			if (a.getMoraleState() >= ::Const.MoraleState.Steady)
			{
				continue;
			}

			local difficulty = bravery;
			local distance = a.getTile().getDistanceTo(myTile) * 10;
			local morale = a.getMoraleState();

			if (a.getMoraleState() == ::Const.MoraleState.Fleeing)
			{
				a.checkMorale(::Const.MoraleState.Wavering - ::Const.MoraleState.Fleeing, difficulty, ::Const.MoraleCheckType.Default, "status_effect_56");
			}
			else
			{
				a.checkMorale(1, difficulty - distance, ::Const.MoraleCheckType.Default, "status_effect_56");
			}

			if (morale != a.getMoraleState())
			{
				a.getSkills().add(this.new("scripts/skills/effects/rallied_effect"));
			}
		}

		this.getContainer().add(this.new("scripts/skills/effects/rallied_effect"));
		return true;
	}

});

