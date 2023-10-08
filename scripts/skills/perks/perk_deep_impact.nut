::Const.Strings.PerkName.DeepImpact <- "Deep Impact";
::Const.Strings.PerkDescription.DeepImpact <- "Learn to strike in such a way that your enemy's head rings..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("– X%") + " enemy armor HP damamge mitigation"
+ "\n"+::MSU.Text.colorRed("X is 20% of current armor effectiveness")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Blunt attacks:")
+ "\nCan apply injuries to the undead";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DeepImpact].Name = ::Const.Strings.PerkName.DeepImpact;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.DeepImpact].Tooltip = ::Const.Strings.PerkDescription.DeepImpact;

this.perk_deep_impact <- this.inherit("scripts/skills/skill", {
	m = {
		AppliedMultiplier = 1.0,
		DidApply = false,
		ArmorEffectivenessMult = 0.2,
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.deep_impact";
		this.m.Name = ::Const.Strings.PerkName.DeepImpact;
		this.m.Description = ::Const.Strings.PerkDescription.DeepImpact;
		this.m.Icon = "ui/perks/deep_impact.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		return true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		this.m.AppliedMultiplier = _properties.DamageArmorMult * this.m.ArmorEffectivenessMult;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		// if (_skill.isAttack() && (_hitInfo.DamageType == ::Const.Damage.DamageType.Blunt || this.m.IsForceEnabled))
		if (_skill.isAttack())
		{
			::Const.Combat.ArmorDirectDamageMitigationMult *= 1.0 - this.m.AppliedMultiplier;
			this.m.DidApply = true;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (this.m.DidApply)
		{
			::Const.Combat.ArmorDirectDamageMitigationMult /= 1.0 - this.m.AppliedMultiplier;
			this.m.DidApply = false;
		}
	}
});
