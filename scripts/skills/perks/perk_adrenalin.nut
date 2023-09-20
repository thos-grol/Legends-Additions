::Const.Strings.PerkDescription.Adrenaline = "The rush of battle, adrenaline..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Adrenaline\' (1 AP, 20 Fat):")
+ "\nThe user becomes first in the next round's turn order"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "When attacked:")
+ "\n"+::MSU.Text.colorRed("+1 stack up to 5")
+ "\n"+::MSU.Text.colorRed("stacks expire on turn end")
+ "\n" + ::MSU.Text.colorGreen("+5") + " Initiative per stack"
+ "\n" + ::MSU.Text.colorGreen("– 5%") + " Fatigue cost per stack";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Adrenaline].Tooltip = ::Const.Strings.PerkDescription.Adrenaline;

this.perk_adrenalin <- this.inherit("scripts/skills/skill", {
	m = {
		Stacks = 0,
		BonusPerStack = 5,
		MaxStacks = 5
	},
	function create()
	{
		this.m.ID = "perk.adrenaline";
		this.m.Name = this.Const.Strings.PerkName.Adrenaline;
		this.m.Description = this.Const.Strings.PerkDescription.Adrenaline;
		this.m.Icon = "ui/perks/perk_37.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.adrenaline"))
		{
			this.m.Container.add(this.new("scripts/skills/actives/adrenaline_skill"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.adrenaline");
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.1;

		if (this.m.Stacks > 0)
		{
			local bonus = this.getBonus();
			_properties.Initiative += bonus;
		}
	}

	function onAfterUpdate( _properties )
	{
		if (this.m.Stacks > 0)
		{
			foreach (skill in this.getContainer().getAllSkillsOfType(::Const.SkillType.Active))
			{
				skill.m.FatigueCostMult *= 1.0 - this.getBonus() * 0.01;
			}
		}
	}

	function onMissed( _attacker, _skill )
	{
		if (_attacker != null && _skill.isAttack())
		{
			this.m.Stacks = ::Math.min(this.m.MaxStacks, this.m.Stacks + 1);
		}
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_skill != null && _skill.isAttack() && _attacker != null && _attacker.getID() != this.getContainer().getActor().getID())
		{
			this.m.Stacks = ::Math.min(this.m.MaxStacks, this.m.Stacks + 1);
		}
	}

	function getBonus()
	{
		return this.m.Stacks * this.m.BonusPerStack;
	}

	function onTurnEnd()
	{
		this.m.Stacks = 0;
	}

	function onCombatStarted()
	{
		this.m.Stacks = 0;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Stacks = 0;
	}

});

