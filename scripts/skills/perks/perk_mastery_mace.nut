::Const.Strings.PerkName.SpecMace = "Mace Proficiency";
::Const.Strings.PerkDescription.SpecMace = ::MSU.Text.color(::Z.Log.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Mace)"
+ "\nKnock Out, Knock Over and Strike Down have a " + ::MSU.Text.colorGreen("100%") + " chance to stun the target"

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecMace].Name = ::Const.Strings.PerkName.SpecMace;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecMace].Tooltip = ::Const.Strings.PerkDescription.SpecMace;

this.perk_mastery_mace <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.mace";
		this.m.Name = ::Const.Strings.PerkName.SpecMace;
		this.m.Description = ::Const.Strings.PerkDescription.SpecMace;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInMaces = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Mace"))
			this.m.Container.add(::new("scripts/skills/traits/_proficiency_Mace"));
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_bodyPart != ::Const.BodyPart.Head || !_skill.isAttack()) return;

		local actor = this.getContainer().getActor();
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(actor)) return;

		local weapon = actor.getMainhandItem();
		if (weapon == null) return;

		local targetTile = _targetEntity.getTile();

		if (weapon.isWeaponType(::Const.Items.WeaponType.Mace) && _skill.m.IsWeaponSkill && _skill.getDamageType().contains(::Const.Damage.DamageType.Blunt))
		{
			if (weapon.isItemType(::Const.Items.ItemType.TwoHanded))
			{
				if (!_targetEntity.getCurrentProperties().IsImmuneToStun)
				{
					if (!_targetEntity.getSkills().hasSkill("effects.stunned"))
					{
						_targetEntity.getSkills().add(::new("scripts/skills/effects/stunned_effect"));
						if (!actor.isHiddenToPlayer() && targetTile.IsVisibleForPlayer) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " has stunned ");
					}
				}
				else
				{
					local effect = ::new("scripts/skills/effects/dazed_effect");
					_targetEntity.getSkills().add(effect);
					effect.m.TurnsLeft = this.Math.max(1, 1 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

					if (!actor.isHiddenToPlayer() && targetTile.IsVisibleForPlayer) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " has been dazed for " + effect.m.TurnsLeft + " turns");
				}
			}
			else
			{
				local effect = ::new("scripts/skills/effects/dazed_effect");
				_targetEntity.getSkills().add(effect);
				effect.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
				if (!actor.isHiddenToPlayer() && targetTile.IsVisibleForPlayer) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " has been dazed for " + effect.m.TurnsLeft + " turns");
			}
		}
		else
		{
			local effect = ::new("scripts/skills/effects/dazed_effect");
			_targetEntity.getSkills().add(effect);
			effect.m.TurnsLeft = this.Math.max(1, 1 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
			if (!actor.isHiddenToPlayer() && targetTile.IsVisibleForPlayer) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " has been dazed for " + effect.m.TurnsLeft + " turns");
		}

	}

});

