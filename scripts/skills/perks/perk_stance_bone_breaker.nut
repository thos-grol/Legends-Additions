::Const.Strings.PerkName.StanceBoneBreaker <- "Bone Breaker";
::Const.Strings.PerkDescription.StanceBoneBreaker <- ::MSU.Text.color(::Z.Log.Color.Purple, "Stance")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Hits that stun or are against Stunned, Sleeping, or Rooted targets:")
+ "\n Have a " + ::MSU.Text.colorGreen("50%") + " chance to inflict an injury. " + ::MSU.Text.colorGreen("100%") + " for 2H"
+ "\n " + ::MSU.Text.color(::Z.Log.Color.BloodRed, "Must deal at least 5 damage to Hitpoints to trigger. If the damage was already sufficient to inflict an injury, inflict an additional injury");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceBoneBreaker].Name = ::Const.Strings.PerkName.StanceBoneBreaker;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceBoneBreaker].Tooltip = ::Const.Strings.PerkDescription.StanceBoneBreaker;

this.perk_stance_bone_breaker <- this.inherit("scripts/skills/skill", {
	m = {
		IsTargetValid = false,
		InjuryPool = null,
		ChanceOneHanded = 50,
		DamageInflictedHitpoints = 0,
		MinDamageToInflictInjury = 5,
		TargetsThisTurn = [],
		ValidEffects = [
			"effects.sleeping",
			"effects.stunned",
			"effects.net",
			"effects.web",
			"effects.rooted"
		]
	},
	function create()
	{
		this.m.ID = "perk.stance.bone_breaker";
		this.m.Name = ::Const.Strings.PerkName.StanceBoneBreaker;
		this.m.Description = ::Const.Strings.PerkDescription.StanceBoneBreaker;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Stance", true);
	}

	function onBeforeAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		this.m.InjuryPool = null;
	}

	function onBeforeTargetHit( _skill, _targetEntity, _hitInfo )
	{
		this.m.InjuryPool = _hitInfo.Injuries;
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		this.m.DamageInflictedHitpoints = _damageInflictedHitpoints;
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (this.m.DamageInflictedHitpoints < this.m.MinDamageToInflictInjury || this.m.InjuryPool == null || _targetEntity == null || this.m.TargetsThisTurn.find(_targetEntity.getID()) != null || !_targetEntity.isAlive() || _targetEntity.isDying() || _targetEntity.isAlliedWith(this.getContainer().getActor()) || !_skill.isAttack() || !this.isEnabled())
		{
			this.m.InjuryPool = null;
			return;
		}

		if (_targetEntity.getFlags().has("undead") && !_targetEntity.getFlags().has("ghoul") && !_targetEntity.getFlags().has("ghost") && !this.getContainer().hasSkill("perk.deep_impact"))
		{
			this.m.InjuryPool = null;
			return;
		}

		if (_targetEntity.getSkills().getSkillsByFunction((@(_skill) this.m.ValidEffects.find(_skill.getID()) != null).bindenv(this)).len() > 0)
		{
			local weapon = this.getContainer().getActor().getMainhandItem();
			if ((weapon != null && weapon.isItemType(this.Const.Items.ItemType.TwoHanded)) || this.Math.rand(1,100) <= this.m.ChanceOneHanded)
			{
				this.m.TargetsThisTurn.push(_targetEntity.getID());
				this.applyInjury(_targetEntity);
				this.m.InjuryPool = null;
			}
		}
	}

	function onTurnStart()
	{
		this.m.TargetsThisTurn.clear();
	}

	function onCombatStarted()
	{
		this.m.InjuryPool = null;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.TargetsThisTurn.clear();
		this.m.InjuryPool = null;
	}

	function applyInjury( _targetEntity )
	{
		if (_targetEntity.m.CurrentProperties.IsAffectedByInjuries && _targetEntity.m.CurrentProperties.ThresholdToReceiveInjuryMult != 0)
		{
			local injuries = this.m.InjuryPool;
			local potentialInjuries = [];

			foreach( inj in injuries )
			{
				if (!_targetEntity.m.Skills.hasSkill(inj.ID) && _targetEntity.m.ExcludedInjuries.find(inj.ID) == null)
					potentialInjuries.push(inj.Script);
			}

			local appliedInjury = false;

			while (potentialInjuries.len() != 0)
			{
				local r = this.Math.rand(0, potentialInjuries.len() - 1);
				local injury = this.new("scripts/skills/" + potentialInjuries[r]);

				if (injury.isValid(_targetEntity))
				{
					_targetEntity.m.Skills.add(injury);

					if (_targetEntity.isPlayerControlled() && this.isKindOf(_targetEntity, "player"))
						_targetEntity.worsenMood(this.Const.MoodChange.Injury, "Suffered an injury");

					if (this.isPlayerControlled() || !this.isHiddenToPlayer()) ::Z.Log.suffer_injury(this, injury.getNameOnly());

					appliedInjury = true;
					break;
				}
				else potentialInjuries.remove(r);
			}

			if (appliedInjury) _targetEntity.onUpdateInjuryLayer();
		}
	}
});