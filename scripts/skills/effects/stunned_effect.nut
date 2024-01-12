this.stunned_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1,
		Ignore = false
	},
	function create()
	{
		this.m.ID = "effects.stunned";
		this.m.Name = "Stunned";
		this.m.Icon = "skills/status_effect_05.png";
		this.m.IconMini = "status_effect_05_mini";
		this.m.Overlay = "status_effect_05";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "This character is stunned or otherwise incapacitated for [color=" + ::Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color] more turn(s), and unable to act.";
	}

	function addTurns( _t )
	{
		this.m.TurnsLeft += _t;
	}

	function onAdded()
	{
		if (!this.m.Ignore)
		{
			local skill = this.getContainer().getSkillByID("effects.steel_brow");
			if (skill != null)
			{
				if (this.getContainer().getActor().getTile().IsVisibleForPlayer)
				{
					this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " resists the Stun with " + skill.getName() + " and is Dazed instead.");
				}

				this.removeSelf();
				this.getContainer().add(::new("scripts/skills/effects/dazed_effect"));
				return;
			}
		}


		local statusResisted = this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses ? ::Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || this.getContainer().getActor().getCurrentProperties().IsResistantToPhysicalStatuses ? ::Math.rand(1, 100) <= 33 : false;

		if (statusResisted)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " shook off being stunned thanks to his unnatural physiology");
			}

			this.removeSelf();
		}
		else if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToStun)
		{
			this.m.Container.removeByID("effects.shieldwall");
			this.m.Container.removeByID("effects.spearwall");
			this.m.Container.removeByID("effects.riposte");
			this.m.Container.removeByID("effects.return_favor");
			this.m.Container.removeByID("effects.possessed_undead");
			this.m.Container.removeByID("effects.legend_vala_currently_chanting");
			this.m.Container.removeByID("effects.legend_vala_in_trance");
		}
		else
		{
			this.m.IsGarbage = true;
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned"))
		{
			actor.getSprite("status_stunned").Visible = false;
		}

		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (!actor.getCurrentProperties().IsImmuneToStun)
		{
			if (this.m.TurnsLeft != 0)
			{
				_properties.IsStunned = true;
				actor.setActionPoints(0);

				if (actor.hasSprite("status_stunned"))
				{
					actor.getSprite("status_stunned").setBrush(::Const.Combat.StunnedBrush);
					actor.getSprite("status_stunned").Visible = true;
				}

				actor.setDirty(true);
			}
			else
			{
				if (actor.hasSprite("status_stunned"))
				{
					actor.getSprite("status_stunned").Visible = false;
				}

				actor.setDirty(true);
			}
		}
		else
		{
			this.removeSelf();
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
			local actor = this.getContainer().getActor();

			if (actor.hasSprite("status_stunned"))
			{
				actor.getSprite("status_stunned").Visible = false;
			}

			actor.setDirty(true);
		}
	}

});

