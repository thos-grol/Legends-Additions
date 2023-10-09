this.hand_to_hand <- this.inherit("scripts/skills/skill", {
	m = {
		Backgrounds = [
			"background.legend_commander_druid",
			"background.legend_druid",
			"background.brawler",
			"background.legend_commander_berserker",
			"background.legend_berserker"
		]
	},
	function create()
	{
		this.m.ID = "actives.hand_to_hand";
		this.m.Name = "CQC";
		this.m.Description = "Let them fly! Use your limbs to inflict damage on your enemy.";
		this.m.KilledString = "Pummeled to death";
		this.m.Icon = "skills/active_08.png";
		this.m.IconDisabled = "skills/active_08_sw.png";
		this.m.Overlay = "active_08";
		this.m.SoundOnUse = [
			"sounds/combat/hand_01.wav",
			"sounds/combat/hand_02.wav",
			"sounds/combat/hand_03.wav"
		];
		this.m.SoundOnHit = [
			"sounds/combat/hand_hit_01.wav",
			"sounds/combat/hand_hit_02.wav",
			"sounds/combat/hand_hit_03.wav"
		];
		this.m.Type = ::Const.SkillType.Active;
		this.m.Order = ::Const.SkillOrder.OffensiveTargeted + 3;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsSerialized = false;
		this.m.InjuriesOnBody = ::Const.Injury.BluntBody;
		this.m.InjuriesOnHead = ::Const.Injury.BluntHead;
		this.m.DirectDamageMult = 0.1;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 5;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local ret = this.getDefaultTooltip();
		local actor = this.getContainer().getActor();
		local _properties = actor.getCurrentProperties();

		foreach( bg in this.m.Backgrounds )
		{
			if (actor.getSkills().hasSkill(bg))
			{
				ret.push({
					id = 7,
					type = "text",
					icon = "ui/icons/regular_damage.png",
					text = "[color=" + ::Const.UI.Color.PositiveValue + "]+25%[/color] damage from background"
				});
				break;
			}
		}

		if (("IsSpecializedInFists" in _properties) && _properties.IsSpecializedInFists)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+"+ getBonus() +"[/color] from armor (Unarmed Mastery)"
			});
		}

		return ret;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill != this) return;
		
		local actor = this.getContainer().getActor();
		_properties.DamageRegularMin += 5;
		_properties.DamageRegularMax += 10;
		_properties.DamageArmorMult = 0.5;
		_properties.FatigueDealtPerHitMult += 1.0;

		//if unarmed or performing offhand attack
		if (this.m.Container.hasSkill("effects.disarmed") || this.m.Container.hasSkill("perk.legend_ambidextrous"))
		{
			local mhand = actor.getMainhandItem();
			if (mhand != null)
			{
				_properties.DamageRegularMin -= mhand.m.RegularDamage;
				_properties.DamageRegularMax -= mhand.m.RegularDamageMax;
			}
		}

		//Calculate damage
		if (("IsSpecializedInFists" in _properties) && _properties.IsSpecializedInFists)
		{
			_properties.DamageRegularMin += getBonus();
			_properties.DamageRegularMax += getBonus();
		}

		foreach( bg in this.m.Backgrounds )
		{
			if (actor.getSkills().hasSkill(bg))
			{
				_properties.DamageTotalMult *= 1.25;
				break;
			}
		}

		if (this.m.Container.hasSkill("perk.legend_ambidextrous") && actor.getMainhandItem() != null) 
			_properties.DamageTotalMult *= 0.8;

	}

	function onAfterUpdate( _properties )
	{
		if (_properties.IsSpecializedInFists) this.m.FatigueCostMult = _properties.IsSpecializedInFists ? ::Const.Combat.WeaponSpecFatigueMult : 1.0;

		if (this.m.Container.hasSkill("perk.legend_ambidextrous"))
		{
			if (this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Mainhand) != null) this.m.IsIgnoredAsAOO = true;
			else this.m.IsIgnoredAsAOO = false;
		}
	}

	function isHidden()
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(::Const.ItemSlot.Offhand);
		local main = items.getItemAtSlot(::Const.ItemSlot.Mainhand);
		return main != null && !this.getContainer().hasSkill("effects.disarmed") || this.skill.isHidden() || this.m.Container.getActor().isStabled();
	}

	function getBonus()
    {
        local total_weight = this.getContainer().getActor().getItems().getStaminaModifier([
            ::Const.ItemSlot.Body,
            ::Const.ItemSlot.Head
        ]) * -1;

		return ::Math.round(2 * ::Math.pow(total_weight, 0.5));
    }

	function isUsable()
	{
		local items = this.getContainer().getActor().getItems();
		if (this.m.Container.hasSkill("perk.legend_ambidextrous") 
			&& items.getItemAtSlot(::Const.ItemSlot.Offhand) == null 
			&& !items.hasBlockedSlot(::Const.ItemSlot.Offhand) 
			&& this.skill.isUsable) return true;

		return (items.getItemAtSlot(::Const.ItemSlot.Mainhand) == null || this.getContainer().hasSkill("effects.disarmed")) && this.skill.isUsable();
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_skill != this) return;

		//add proficiency to cqc strikes, even when weapon is equipped
		local items = this.getContainer().getActor().getItems();
		if (this.m.Container.hasSkill("perk.legend_ambidextrous") && items.getItemAtSlot(::Const.ItemSlot.Mainhand) != null){
			local fist_proficiency = this.m.Container.getSkillByID("trait.proficiency_Fist");
			if (fist_proficiency != null) fist_proficiency.add_proficiency();
		}

		if (!_targetEntity.isAlive() || _targetEntity.isDying()) return;
		
		local roll = ::Math.rand(1, 100);
		local chance = getBonus();
		if (roll > chance) return;

		local isVisible = !_targetEntity.isHiddenToPlayer();

		if (_targetEntity.getFlags().has("StaggerImmunity"))
		{
			if (isVisible) ::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + ::MSU.Text.colorRed(" is immune to stagger"));
			return;
		}

		if (!_targetEntity.getSkills().hasSkill("effects.staggered"))
		{
			_targetEntity.getSkills().add(this.new("scripts/skills/effects/staggered_effect"));
			if (isVisible) ::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + ::MSU.Text.colorRed(" has been staggered") + ::Z.Log.display_chance(roll, chance));
		}
				
		
	}



});

