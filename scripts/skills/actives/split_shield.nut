this.split_shield <- this.inherit("scripts/skills/skill", {
	m = {
		ApplyAxeMastery = false
	},
	function isAxeMasteryApplied()
	{
		return this.m.ApplyAxeMastery;
	}

	function setApplyAxeMastery( _f )
	{
		this.m.ApplyAxeMastery = _f;
	}

	function create()
	{
		this.m.ID = "actives.split_shield";
		this.m.Name = "Split Shield";
		this.m.Description = "An attack specifically aimed at destroying an opponent\'s shield. Can only be used against targets that carry a shield. Will always hit but may take several hits depending on type of shield and weapon used.";
		this.m.Icon = "skills/active_09.png";
		this.m.IconDisabled = "skills/active_09_sw.png";
		this.m.Overlay = "active_09";
		this.m.SoundOnHit = [
			"sounds/combat/split_shield_01.wav",
			"sounds/combat/split_shield_02.wav",
			"sounds/combat/split_shield_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsUsingHitchance = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.IsWeaponSkill = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local damage = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).getShieldDamage();

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInAxes)
		{
			damage = damage + this.Math.max(1, damage / 2);
		}

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
		ret.push({
			id = 7,
			type = "text",
			icon = "ui/icons/shield_damage.png",
			text = "Inflicts [color=" + ::Const.UI.Color.DamageValue + "]" + damage + "[/color] damage to shields"
		});

		if (this.m.MaxRange > 1)
		{
			ret.push({
				id = 8,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "Has a range of [color=" + ::Const.UI.Color.PositiveValue + "] " + this.m.MaxRange + "[/color] tiles"
			});
		}

		if (this.m.MaxRange > 1 && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/hitchance.png",
				text = "Has [color=" + ::Const.UI.Color.NegativeValue + "]-15%[/color] chance to hit targets directly adjacent because the weapon is too unwieldy. Can be removed with polearm proficiency"
			});
		}

		return ret;
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsSpecializedInAxes ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null && this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).getBlockedSlotType() != null)
		{
			this.m.ActionPointCost = 6;
		}
		else
		{
			this.m.ActionPointCost = 4;
		}
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		return _targetTile.getEntity().isArmedWithShield();
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		local shield = target.getItems().getItemAtSlot(::Const.ItemSlot.Offhand);

		if (shield != null)
		{
			this.spawnAttackEffect(_targetTile, ::Const.Tactical.AttackEffectSplitShield);
			local damage = _user.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand).getShieldDamage();

			if (_user.getCurrentProperties().IsSpecializedInAxes)
			{
				damage = damage + this.Math.max(1, damage / 2);
			}

			if (shield.getID() == "weapon.legend_parrying_dagger")
			{
				damage = damage * 0.2;
			}
			else if (shield.getID() == "shield.legend_named_parrying_dagger")
			{
				damage = damage * 0.2;
			}

			local conditionBefore = shield.getCondition();
			shield.applyShieldDamage(damage);

			if (shield.getCondition() == 0)
			{
				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Split Shield and destroys " + ::Const.UI.getColorizedEntityName(target) + "\'s shield");
				}
			}
			else
			{
				if (this.m.SoundOnHit.len() != 0)
				{
					this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, target.getPos());
				}

				if (!_user.isHiddenToPlayer() && _targetTile.IsVisibleForPlayer)
				{
					this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(_user) + " uses Split Shield and hits " + ::Const.UI.getColorizedEntityName(target) + "\'s shield for [b]" + (conditionBefore - shield.getCondition()) + "[/b] damage");
				}
			}

			if (!this.Tactical.getNavigator().isTravelling(target))
			{
				this.Tactical.getShaker().shake(target, _user.getTile(), 2, ::Const.Combat.ShakeEffectSplitShieldColor, ::Const.Combat.ShakeEffectSplitShieldHighlight, ::Const.Combat.ShakeEffectSplitShieldFactor, 1.0, [
					"shield_icon"
				], 1.0);
			}

			local overwhelm = this.getContainer().getSkillByID("perk.overwhelm");

			if (overwhelm != null)
			{
				overwhelm.onTargetHit(this, _targetTile.getEntity(), ::Const.BodyPart.Body, 0, 0);
			}
		}

		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill == this && this.m.MaxRange > 1)
		{
			if (_targetEntity != null && !this.getContainer().getActor().getCurrentProperties().IsSpecializedInPolearms && this.getContainer().getActor().getTile().getDistanceTo(_targetEntity.getTile()) == 1)
			{
				_properties.MeleeSkill += -15;
				this.m.HitChanceBonus = -15;
			}
		}
	}

});

