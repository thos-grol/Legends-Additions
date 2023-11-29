this.ptr_follow_up_effect <- this.inherit("scripts/skills/skill", {
	m = {
		DamageMalus = 50,
		DamageMalusIncreasePerProc = 10,
		ProcCount = 0,
		IsProccing = false
	},
	function create()
	{
		this.m.ID = "effects.ptr_follow_up";
		this.m.Name = "Follow Up";
		this.m.Description = "Every time an enemy gets hit in this character\'s attack range by an ally, %they% will perform a free non-lethal attack against that enemy with reduced damage.";
		this.m.Icon = "ui/perks/breakthrough.png";
		this.m.IconMini = "ptr_follow_up_effect_mini";
		this.m.Type = ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();
		tooltip.push(
				{
					id = 10,
					type = "text",
					icon = "ui/icons/damage_dealt.png",
					text = "[color=" + ::Const.UI.Color.NegativeValue + "]-" + this.getCurrentMalus() + "%[/color] Damage inflicted"
				}
			);

		if (!this.canFollowUp())
		{
			tooltip.push(
					{
						id = 10,
						type = "text",
						icon = "ui/tooltips/warning.png",
						text = "Can only Follow Up when not engaged in Melee and wielding a Two-Handed Weapon with a range of 2 tiles"
					}
				);
		}

		return tooltip;
	}

	function getCurrentMalus()
	{
		return this.Math.min(90, this.m.DamageMalus + (this.m.ProcCount * this.m.DamageMalusIncreasePerProc));
	}

	function canFollowUp()
	{
		local actor = this.getContainer().getActor();

		if (!actor.getCurrentProperties().IsAbleToUseWeaponSkills || !actor.hasZoneOfControl() || actor.isEngagedInMelee())
		{
			return false;
		}

		local weapon = actor.getMainhandItem();
		if (weapon == null || !weapon.isItemType(::Const.Items.ItemType.TwoHanded) || !weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			return false;
		}

		return true;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		if (!actor.isPlacedOnMap() || actor.getMoraleState() == ::Const.MoraleState.Fleeing)
		{
			this.removeSelf();
			return;
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsProccing)
		{
			_properties.DamageTotalMult *= 1.0 - this.getCurrentMalus() * 0.01;
		}
	}

	function proc(_targetEntity)
	{
		if (!this.canFollowUp())
		{
			return;
		}

		local targetTile = _targetEntity.getTile();
		if (targetTile == null)
		{
			return;
		}

		local attack = this.getContainer().getAttackOfOpportunity();
		if (attack != null && attack.onVerifyTarget(this.getContainer().getActor().getTile(), targetTile))
		{
			local targetEntity = targetTile.getEntity();
			if (targetEntity == null)
			{
				return;
			}

			local user = this.getContainer().getActor();
			if (!user.isHiddenToPlayer() || targetTile.IsVisibleForPlayer)
			{
				this.getContainer().setBusy(true);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, function ( effect )
				{
					if (targetEntity.isAlive() && !targetEntity.isDying())
					{
						this.logDebug("[" + user.getName() + "] is Following Up with skill [" + attack.getName() + "] on target [" + targetEntity.getName() + "]");

						if (!user.isHiddenToPlayer() && targetTile.IsVisibleForPlayer)
						{
							this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(user) + " is Following Up");
						}

						local isAbleToDie = targetEntity.m.IsAbleToDie;
						targetEntity.m.IsAbleToDie = false;

						effect.m.IsProccing = true;
						attack.useForFree(targetTile);
						effect.m.ProcCount++;
						effect.m.IsProccing = false;

						targetEntity.m.IsAbleToDie = isAbleToDie;
					}

					this.getContainer().setBusy(false);

				}.bindenv(this), this);
			}
			else
			{
				if (targetEntity.isAlive() && !targetEntity.isDying())
				{
					this.logDebug("[" + user.getName() + "] is Following Up with skill [" + attack.getName() + "] on target [" + targetEntity.getName() + "]");

					local isAbleToDie = targetEntity.m.IsAbleToDie;
					targetEntity.m.IsAbleToDie = false;

					this.m.IsProccing = true;
					attack.useForFree(targetTile);
					this.m.ProcCount++;
					this.m.IsProccing = false;

					targetEntity.m.IsAbleToDie = isAbleToDie;
				}
			}
		}
	}

	function onTurnStart()
	{
		this.removeSelf();
	}
});
