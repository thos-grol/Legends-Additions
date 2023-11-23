::Const.Strings.PerkName.SpecHammer = "Bludgeon Proficiency";
::Const.Strings.PerkDescription.SpecHammer = ::MSU.Text.color(::Z.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Bludgeons - Maces and Hammers)"

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Headshot")
+ "\n Apply daze for 1 turn"

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Bludgeon attacks inflict:")
+ "\n"+::MSU.Text.colorGreen("+5%") + " armor piercing (10% for 2H)"
+ "\n"+::MSU.Text.colorRed("Debuff remains until the end of battle. Caps at 30%")

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Daze: (Duration: 2)")
+ "\n "+::MSU.Text.colorRed("– 50% Fatigue")
+ "\n "+::MSU.Text.colorRed("– 50% Initiative");



::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecHammer].Name = ::Const.Strings.PerkName.SpecHammer;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecHammer].Tooltip = ::Const.Strings.PerkDescription.SpecHammer;

this.perk_mastery_hammer <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.hammer";
		this.m.Name = ::Const.Strings.PerkName.SpecHammer;
		this.m.Description = ::Const.Strings.PerkDescription.SpecHammer;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInHammers = true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Hammer"))
			this.m.Container.add(::new("scripts/skills/traits/_proficiency_Hammer"));
	}

	function isEnabled()
	{
		if (!this.getContainer().getActor().getCurrentProperties().IsAbleToUseWeaponSkills) return false; //isDisarmed
		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Hammer)) return false;
		return true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		if (!_targetEntity.isAlive() || _targetEntity.isDying() || !_skill.isAttack()) return;

		if (_bodyPart == ::Const.BodyPart.Head)
		{
			local effect = ::new("scripts/skills/effects/dazed_effect");
			_targetEntity.getSkills().add(effect);
			effect.m.TurnsLeft = this.Math.max(1, 1 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
			if (!actor.isHiddenToPlayer() && _targetEntity.getTile().IsVisibleForPlayer) this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(_targetEntity) + " has been dazed for " + effect.m.TurnsLeft + " turns");
		}

		if (!isEnabled()) return;
		if (!_skill.getDamageType().contains(::Const.Damage.DamageType.Blunt)) return;
		if (_targetEntity.getArmor(_bodyPart) == 0) return;

		local effect = _targetEntity.getSkills().getSkillByID("effects.dismantled");
		if (effect == null) effect = ::new("scripts/skills/effects/dismantled_effect");

		local countsToAdd = 1;
		local weapon = actor.getMainhandItem();
		if (weapon != null && weapon.isItemType(::Const.Items.ItemType.TwoHanded)) countsToAdd += 1;
		if (_bodyPart == ::Const.BodyPart.Body) effect.m.BodyHitCount += countsToAdd;
		else effect.m.HeadHitCount += countsToAdd;

		_targetEntity.getSkills().add(effect);
	}

});

