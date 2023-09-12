
::Const.Strings.PerkDescription.Backstabber = "It's not the strong who survive. It's the survivors who are strong..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n"+::MSU.Text.colorGreen("+5") + " Surrounded Offense"
+ "\n"+::MSU.Text.colorGreen("+20%") + " damage against targets that are " + ::MSU.Text.colorRed("injured, stunned, netted, or sleeping.");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Backstabber].Tooltip = ::Const.Strings.PerkDescription.Backstabber;

this.perk_backstabber <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.backstabber";
		this.m.Name = this.Const.Strings.PerkName.Backstabber;
		this.m.Description = this.Const.Strings.PerkDescription.Backstabber;
		this.m.Icon = "ui/perks/perk_40.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.SurroundedBonusMult = 2.0;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (_skill.isAttack() && _targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury) || _targetEntity.getSkills().hasSkill("effects.debilitated"))
		{
			_properties.DamageTotalMult *= 1.2;
		}

		if (_targetEntity.getSkills().hasSkill("effects.stunned") || _targetEntity.getSkills().hasSkill("effects.net") || _targetEntity.getSkills().hasSkill("effects.sleeping"))
		{
			_properties.DamageTotalMult *= 1.1;
		}
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		if (_skill.isAttack() && _targetEntity != null && _targetEntity.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
		{
			this.spawnIcon("perk_16", this.getContainer().getActor().getTile());
		}
	}

});