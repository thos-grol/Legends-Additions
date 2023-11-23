::Const.Strings.PerkName.PatternRecognition <- "Pattern Recognition";
::Const.Strings.PerkDescription.PatternRecognition <- "Abstract patterns from a stream of data..."
+ "\n"+ ::MSU.Text.colorRed("Necessary to survive consuming a mage sequence")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "On attack or attacked:")
+ "\n"+ ::MSU.Text.colorRed("+1 stack against that opponent")
+ "\n" + ::MSU.Text.colorGreen("+1") + " Melee Skill and Melee Defense at 1 stack"
+ "\n" + ::MSU.Text.colorGreen("+3") + " Melee Skill and Melee Defense at 2 stacks"
+ "\n" + ::MSU.Text.colorGreen("+6") + " Melee Skill and Melee Defense at 3 stacks"
+ "\n" + ::MSU.Text.colorGreen("+10") + " Melee Skill and Melee Defense at 4 stacks"
+ "\n"+ ::MSU.Text.colorRed("Every subsequent stack adds 1 Melee Skill and Melee Defense");


::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PatternRecognition].Name = ::Const.Strings.PerkName.PatternRecognition;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PatternRecognition].Tooltip = ::Const.Strings.PerkDescription.PatternRecognition;

this.perk_pattern_recognition <- this.inherit("scripts/skills/skill", {
	m = {
		Opponents = []
	},
	function create()
	{
		this.m.ID = "perk.pattern_recognition";
		this.m.Name = this.Const.Strings.PerkName.PatternRecognition;
		this.m.Description = "This character is quick to understand the fighting style of %their% opponents, getting better at fighting them as the combat draws on.";
		this.m.Icon = "ui/perks/pattern_recognition.png";
		this.m.IconMini = "pattern_recognition_mini";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Opponents.len() == 0;
	}

	function getOpponentEntry(_entityID)
	{
		foreach (opponentEntry in this.m.Opponents)
		{
			if (opponentEntry.EntityID == _entityID)
			{
				return opponentEntry;
			}
		}

		return null;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push(
			{
				id = 10,
				type = "text",
				icon = "ui/icons/plus.png",
				text = "Increased Melee Skill and Melee Defense"
			}
		);

		foreach (opponentEntry in this.m.Opponents)
		{
			local opponent = this.Tactical.getEntityByID(opponentEntry.EntityID);
			if (opponent == null || !opponent.isPlacedOnMap() || !opponent.isAlive() || opponent.isDying())
			{
				continue;
			}

			tooltip.push(
				{
					id = 10,
					type = "text",
					icon = "ui/orientation/" + opponent.getOverlayImage() + ".png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getBonus(opponentEntry) + "[/color] against " + opponent.getName()
				}
			);
		}

		return tooltip;
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		local targetEntity = _targetTile.getEntity();
		if (!_skill.isRanged() && targetEntity != null)
		{
			local opponentEntry = this.getOpponentEntry(targetEntity.getID());
			if (opponentEntry != null)
			{
				_tooltip.push({
					icon = "ui/tooltips/positive.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonus(opponentEntry) + "%[/color] " + this.getName()
				});
			}
		}
	}

	function onGetHitFactorsAsTarget( _skill, _targetTile, _tooltip )
	{
		if (_skill.isRanged()) return;

		local opponentEntry = this.getOpponentEntry(_skill.getContainer().getActor().getID());
		if (opponentEntry != null)
		{
			_tooltip.push({
				icon = "ui/tooltips/negative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]" + this.getBonus(opponentEntry) + "%[/color] Pattern Recognition"
			});
		}
	}

	function getBonus( _opponentEntry )
	{
		local bonus = 0;
		for (local i = 1; i <= _opponentEntry.Stacks; i++)
		{
			bonus += bonus >= 10 ? 1 : i;
		}

		return bonus;
	}

	function procIfApplicable(_entity, _skill)
	{
		local actor = this.getContainer().getActor();

		if (!actor.isPlacedOnMap() || actor.getMoraleState() == this.Const.MoraleState.Fleeing)
		{
			return;
		}

		if (_skill == null || !_skill.isAttack() || _skill.isRanged() || _entity == null || _entity.isAlliedWith(actor))
		{
			return;
		}

		foreach (opponentEntry in this.m.Opponents)
		{
			if (opponentEntry.EntityID == _entity.getID())
			{
				opponentEntry.Stacks += 1;
				return;
			}
		}

		this.m.Opponents.push({EntityID = _entity.getID(), Stacks = 1});
	}

	function onMissed( _attacker, _skill )
	{
		this.procIfApplicable(_attacker, _skill);
	}

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		this.procIfApplicable(_attacker, _skill);
	}

	function onUpdate( _properties )
	{
		for (local i = this.m.Opponents.len() - 1; i >= 0; i--)
		{
			local e = this.Tactical.getEntityByID(this.m.Opponents[i].EntityID);
			if (e == null || !e.isAlive())
			{
				this.m.Opponents.remove(i);
			}
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!_targetEntity.isAlive() || _targetEntity.isDying())
		{
			return;
		}

		this.procIfApplicable(_targetEntity, _skill);
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.procIfApplicable(_targetEntity, _skill);
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity != null && _skill != null && !_skill.isRanged() && _skill.isAttack())
		{
			local opponentEntry = this.getOpponentEntry(_targetEntity.getID());
			if (opponentEntry != null)
			{
				_properties.MeleeSkill += this.getBonus(opponentEntry);
			}
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_attacker != null && _skill != null && !_skill.isRanged() && _skill.isAttack())
		{
			local opponentEntry = this.getOpponentEntry(_attacker.getID());
			if (opponentEntry != null)
			{
				_properties.MeleeDefense += this.getBonus(opponentEntry);
			}
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Opponents.clear();
	}
});
