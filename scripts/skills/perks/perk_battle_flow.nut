::Const.Strings.PerkName.BattleFlow = "Battle Flow";
::Const.Strings.PerkDescription.BattleFlow = "Glide through battle, like a leaf in the storm..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "When killing, once per turn:")
+ "\n" + ::MSU.Text.colorGreen("– 10% of Max Fatigue before armor penalties") + " from current fatigue"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]When hitting a melee attack:[/u]")
+ "\n"+ ::MSU.Text.colorRed("+1 stack up to 10")
+ "\n" + ::MSU.Text.colorGreen("+2 Melee Skill") + " per stack"
+ "\n" + ::MSU.Text.colorGreen("+1") + " AP at 3 stacks"
+ "\n" + ::MSU.Text.colorGreen("+2") + " AP at 6 stacks"
+ "\n" + ::MSU.Text.colorGreen("+3") + " AP at 10 stacks"
+ "\n" + ::MSU.Text.colorRed("Lose 50% of stacks when missing an attack or getting hit")
+ "\n\n" + ::MSU.Text.colorRed("Attacks at 2 tiles range only grant a stack after two successful hits");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.BattleFlow].Name = ::Const.Strings.PerkName.BattleFlow;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.BattleFlow].Tooltip = ::Const.Strings.PerkDescription.BattleFlow;

this.perk_battle_flow <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false,
		Stacks = 0,
		SkillBonusPerStack = 2,
		MaxStacks = 10,
		Distance = 0,
		APBonusBefore = 0
	},
	function create()
	{
		this.m.ID = "perk.battle_flow";
		this.m.Name = this.Const.Strings.PerkName.BattleFlow;
		this.m.Description = this.Const.Strings.PerkDescription.BattleFlow;
		this.m.Icon = "ui/perks/perk_41.png";
		this.m.Type = this.Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		if (!this.m.IsSpent)
		{
			this.m.IsSpent = true;
			local actor = this.getContainer().getActor();
			actor.setFatigue(this.Math.max(0, actor.getFatigue() - actor.getBaseProperties().Stamina * actor.getBaseProperties().StaminaMult * 0.1));
			actor.setDirty(true);
		}
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}


	//////////////////////////// Unstoppable

	function getName()
	{
		return this.m.Stacks == 0 ? this.m.Name : this.m.Name + " (x" + this.m.Stacks + ")";
	}

	function isHidden()
	{
		return this.m.Stacks == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/hitchance.png",
			text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + this.getSkillBonus() + "[/color] Melee Skill"
		});

		local APBonus = this.getAPBonus();
		if (APBonus > 0)
		{
			tooltip.push({
				id = 10,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + APBonus + "[/color] Action Point(s)"
			});
		}

		return tooltip;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.Distance = 0;
		this.m.APBonusBefore = this.getAPBonus();

		if (_skill.isAttack() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			this.m.Distance = _targetEntity.getTile().getDistanceTo(this.getContainer().getActor().getTile());
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		local actor = this.getContainer().getActor();
		if (_skill.isAttack() && ::Tactical.TurnSequenceBar.isActiveEntity(actor) &&!_targetEntity.isAlliedWith(actor))
		{
			this.m.Stacks = ::Math.minf(this.m.MaxStacks, this.m.Stacks + (this.m.Distance > 1 ? 0.5 : 1));
			actor.setActionPoints(actor.getActionPoints() + this.getAPBonus() - this.m.APBonusBefore);
		}
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		if (_skill.isAttack() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			this.m.Stacks = ::Math.floor(this.m.Stacks / 2);
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker != null && _attacker.getID() != this.getContainer().getActor().getID())
		{
			this.m.Stacks = ::Math.floor(this.m.Stacks / 2);
		}
	}

	function getSkillBonus()
	{
		return ::Math.floor(this.m.Stacks) * this.m.SkillBonusPerStack;
	}

	function getAPBonus()
	{
		if (this.m.Stacks == 10) return 3;
		if (this.m.Stacks >= 6) return 2;
		if (this.m.Stacks >= 3) return 1;
		return 0;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += this.getSkillBonus();
		_properties.ActionPoints += this.getAPBonus();
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

