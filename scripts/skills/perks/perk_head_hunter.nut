::Const.Strings.PerkName.HeadHunter = "Head Hunter";
::Const.Strings.PerkDescription.HeadHunter = "Aim to kill..."
+ "\n\n"+::MSU.Text.color(::Z.Log.Color.Blue, "On headshot:")
+ "\n"+::MSU.Text.colorGreen("This unit's next attack will hit the head");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.HeadHunter].Name = ::Const.Strings.PerkName.HeadHunter;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.HeadHunter].Tooltip = ::Const.Strings.PerkDescription.HeadHunter;

this.perk_head_hunter <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		SkillCount = 0
	},
	function create()
	{
		this.m.ID = "perk.head_hunter";
		this.m.Name = ::Const.Strings.PerkName.HeadHunter;
		this.m.Description = ::Const.Strings.PerkDescription.HeadHunter;
		this.m.Icon = "ui/perks/perk_15.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk | ::Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function getDescription()
	{
		return "This character is guaranteed to land a hit to the head on the next attack that connects.";
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.m.Stacks == 0;

		if (this.m.Stacks != 0)
		{
			_properties.HitChance[::Const.BodyPart.Head] = 100.0;
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (_bodyPart == ::Const.BodyPart.Head)
		{
			if (this.m.Stacks == 0 && this.m.SkillCount != ::Const.SkillCounter)
			{
				this.m.Stacks = 1;
				this.m.SkillCount = ::Const.SkillCounter;
			}
			else
			{
				this.m.Stacks = 0;
			}

			this.getContainer().getActor().setDirty(true);
		}
	}

	function onCombatStarted()
	{
		this.m.Stacks = 0;
		this.m.SkillCount = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
		this.m.SkillCount = 0;
		this.m.IsHidden = true;
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && this.m.Stacks != 0)
		{
			_properties.HitChanceMult[::Const.BodyPart.Body] = 0.0;
		}
	}

});

