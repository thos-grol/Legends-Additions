::Const.Strings.PerkName.SpecCleaver = "Cleaver Proficiency";
::Const.Strings.PerkDescription.SpecCleaver = ::MSU.Text.color(::Z.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Cleavers)"

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "With cleaver equipped:")
+ "\n• " + "Attacks apply " + ::MSU.Text.colorRed("Weakness")

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Bleed: (Duration: 2, Stackable)")
+ "\n " + ::MSU.Text.color(::Z.Color.BloodRed, "On wait or turn end, inflict 5 damage")

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Weakness: (Duration: 1)")
+ "\n " + ::MSU.Text.color(::Z.Color.BloodRed, "– 5X% damage. X is the number of bleed stacks. Caps at 50%");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecCleaver].Name = ::Const.Strings.PerkName.SpecCleaver;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecCleaver].Tooltip = ::Const.Strings.PerkDescription.SpecCleaver;

this.perk_mastery_cleaver <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.cleaver";
		this.m.Name = ::Const.Strings.PerkName.SpecCleaver;
		this.m.Description = ::Const.Strings.PerkDescription.SpecCleaver;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInCleavers = true;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying()) return false;

		local item = this.getContainer().getActor().getMainhandItem();
		if (!item.isWeaponType(::Const.Items.WeaponType.Cleaver)) return false;

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding) return false;
		if (_damageInflictedHitpoints < ::Const.Combat.MinDamageToApplyBleeding) return false;
		if (_targetEntity.isNonCombatant()) return false;

		local actor = this.getContainer().getActor();
		local effect = _targetEntity.getSkills().getSkillByID("effects.weakness");
		if (effect != null) effect.resetTime();
		else _targetEntity.getSkills().add(::new("scripts/skills/effects/weakness_effect"));

		return true;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Cleaver"))
			this.m.Container.add(::new("scripts/skills/traits/_proficiency_Cleaver"));
	}

});

