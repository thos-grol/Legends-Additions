::Const.Strings.PerkName.SpecFlail = "Flail Proficiency";
::Const.Strings.PerkDescription.SpecFlail = ::MSU.Text.color(::Z.Log.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Flail)"
+ "\nThresh gains"+::MSU.Text.colorGreen("+5%")+ " chance to hit"
+ "\nLash and Hail ignore shield defense bonuses"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "On attacking with Flail:")
+ "\n " + ::MSU.Text.colorGreen("25%") + " to do an extra free attack";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecFlail].Name = ::Const.Strings.PerkName.SpecFlail;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecFlail].Tooltip = ::Const.Strings.PerkDescription.SpecFlail;

this.perk_mastery_flail <- this.inherit("scripts/skills/skill", {
	m = {
		Chance = 25,
		IsSpinningFlail = false
	},
	function create()
	{
		this.m.ID = "perk.mastery.flail";
		this.m.Name = ::Const.Strings.PerkName.SpecFlail;
		this.m.Description = ::Const.Strings.PerkDescription.SpecFlail;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInFlails = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Flail"))
			this.m.Container.add(::new("scripts/skills/traits/_proficiency_Flail"));
	}

	function spinFlail (_skill, _targetTile)
	{
		local targetEntity = _targetTile.getEntity();
		if (targetEntity == null) return;
		if (this.m.IsSpinningFlail || this.Math.rand(1,100) > this.m.Chance) return;

		local user = this.getContainer().getActor();

		if (this.Tactical.TurnSequenceBar.getActiveEntity().getID() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == user.getID())
		{
			if (!user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer)
			{
				this.getContainer().setBusy(true);
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 300, function ( perk )
				{
					if (targetEntity.isAlive())
					{
						if (!user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
						{
							this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(user) + " spins their flail");
						}

						perk.m.IsSpinningFlail = true;

						local isAbleToDie = targetEntity.m.IsAbleToDie;
						if (!user.isPlayerControlled())
						{
							targetEntity.m.IsAbleToDie = false;
						}

						_skill.useForFree(_targetTile);

						if (!user.isPlayerControlled())
						{
							targetEntity.m.IsAbleToDie = isAbleToDie;
						}

						perk.m.IsSpinningFlail = false;
					}

					this.getContainer().setBusy(false);

				}.bindenv(this), this);
			}
			else
			{
				if (targetEntity.isAlive())
				{
					this.m.IsSpinningFlail = true;

					local isAbleToDie = targetEntity.m.IsAbleToDie;
					if (!user.isPlayerControlled())
					{
						targetEntity.m.IsAbleToDie = false;
					}

					_skill.useForFree(_targetTile);

					if (!user.isPlayerControlled())
					{
						targetEntity.m.IsAbleToDie = isAbleToDie;
					}

					this.m.IsSpinningFlail = false;
				}
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Flail) && _skill.isAttack() && _skill.m.IsWeaponSkill)
		{
			this.spinFlail(_skill, _targetTile);
		}
	}

});

