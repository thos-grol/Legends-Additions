// Cleaver Proficiency

// -25% Cleaver skill Fatigue

// Bleeding damage inflicted by cleavers and whips is doubled to 10 and 20 per turn

// Disarm only has half the penalty to hit

::Const.Strings.PerkName.SpecCleaver = "Cleaver Proficiency";
::Const.Strings.PerkDescription.SpecCleaver = ::MSU.Text.color(::Z.Log.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Cleavers)"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]With cleaver equipped:[/u]")
+ "\n• " + "Attacks apply " + ::MSU.Text.colorRed("Weakness")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.BloodRed, "[u]Bleed:[/u] (Duration: 2)")
+ "\n " + ::MSU.Text.color(::Z.Log.Color.BloodRed, "On turn end or waiting, inflict 5 damage. Effect is stackable")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.BloodRed, "[u]Weakness:[/u] (Duration: 3)")
+ "\n " + ::MSU.Text.color(::Z.Log.Color.BloodRed, "-5X% damage. X is the number of bleed stacks. Caps at 75%")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "Deal damage with cleavers to have a chance of increasing proficiency \n\nSee progress on the Details page");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecCleaver].Name = ::Const.Strings.PerkName.SpecCleaver;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecCleaver].Tooltip = ::Const.Strings.PerkDescription.SpecCleaver;

this.perk_mastery_cleaver <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.cleaver";
		this.m.Name = this.Const.Strings.PerkName.SpecCleaver;
		this.m.Description = this.Const.Strings.PerkDescription.SpecCleaver;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
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
		if (!item.isWeaponType(this.Const.Items.WeaponType.Cleaver)) return false;

		if (_targetEntity.getCurrentProperties().IsImmuneToBleeding) return false;
		if (_damageInflictedHitpoints < this.Const.Combat.MinDamageToApplyBleeding) return false;
		if (_targetEntity.isNonCombatant()) return false;

		local actor = this.getContainer().getActor();
		local effect = _targetEntity.getSkills().getSkillByID("effects.weakness");
		if (effect != null) effect.resetTime();
		else _targetEntity.getSkills().add(::new("scripts/skills/effects/weakness_effect"));

		return true;
	}

});

