::Const.Strings.PerkName.Intimidate <- "Intimidate";
::Const.Strings.PerkDescription.Intimidate <- "Intimidate your foes with aggressive attacks..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Attack:")
+ "\n"+ ::MSU.Text.colorRed("+1 stack")
+ "\n" + ::MSU.Text.colorRed("– X") + " Resolve per stack"
+ "\n" + ::MSU.Text.colorRed("X is 10% of Melee Skill. Expires on turn start");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Intimidate].Name = ::Const.Strings.PerkName.Intimidate;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Intimidate].Tooltip = ::Const.Strings.PerkDescription.Intimidate;

this.perk_intimidate <- this.inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false
	},
	function create()
	{
		this.m.ID = "perk.intimidate";
		this.m.Name = ::Const.Strings.PerkName.Intimidate;
		this.m.Description = ::Const.Strings.PerkDescription.Intimidate;
		this.m.Icon = "ui/perks/intimidate.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function applyDebuff(_targetEntity)
	{
		if (_targetEntity.getMoraleState() == ::Const.MoraleState.Ignore) return;

		local effect = _targetEntity.getSkills().getSkillByID("effects.intimidated");
		if (effect != null)
		{
			effect.m.ResolveMalus += ::Math.floor(this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * 0.1);
		}
		else
		{
			effect = ::new("scripts/skills/effects/intimidated_effect");
			effect.m.ResolveMalus += ::Math.floor(this.getContainer().getActor().getCurrentProperties().getMeleeSkill() * 0.1);
			_targetEntity.getSkills().add(effect);
		}
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (!_skill.isAttack() || !this.isInEffect() || _targetEntity.isAlliedWith(this.getContainer().getActor())) return;

		this.applyDebuff(_targetEntity);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (!_skill.isAttack() || !this.isInEffect() || _targetEntity.isAlliedWith(this.getContainer().getActor())) return;
		this.applyDebuff(_targetEntity);
	}

	function isInEffect()
	{
		if (this.m.IsForceEnabled) return true;

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(::Const.Items.WeaponType.Spear)) return false;
		return true;
	}
});
