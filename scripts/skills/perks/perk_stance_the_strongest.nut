::Const.Strings.PerkName.StanceTheStrongest <- "The Strongest";
::Const.Strings.PerkDescription.StanceTheStrongest <- ::MSU.Text.color(::Z.Color.Purple, "Stance")
+ "\nThe strongest are undeterred no matter what they face"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Upon taking damage:")
+ "\nParry the attack and strike back"
+ "\n"+::MSU.Text.colorRed("Triggers only once per turn. Retaliation only works at 1 tile range");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceTheStrongest].Name = ::Const.Strings.PerkName.StanceTheStrongest;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.StanceTheStrongest].Tooltip = ::Const.Strings.PerkDescription.StanceTheStrongest;

this.perk_stance_the_strongest <- this.inherit("scripts/skills/skill", {
	m = {
		Active = false,
		Immunity = true
	},
	function create()
	{
		this.m.ID = "perk.stance.the_strongest";
		this.m.Name = ::Const.Strings.PerkName.StanceTheStrongest;
		this.m.Description = ::Const.Strings.PerkDescription.StanceTheStrongest;
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

	function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
	{
		if (_attacker == null) return;
		local slam = _attacker.getSkills().getSkillByID("perk.stance.seismic_slam");
		if (slam != null) return;

		slam = _attacker.getSkills().getSkillByID("perk.class.continuance_knight");
		if (slam != null) return;

		if (!this.m.Active)
		{
			this.m.Immunity = false;
			return;
		}
		if (!_skill.m.IsAttack) return;

		local actor = this.getContainer().getActor();
		this.m.Active = false;
		this.Sound.play("sounds/general/parry.wav", 200.0, actor.getPos());

		//negate the damage
		_properties.DamageReceivedRegularMult *= 0;
		_properties.DamageReceivedArmorMult *= 0;

		//perform a riposte if possible
		this.Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(actor) + " parried the strike");

		if (_attacker != null
			&& !_attacker.isAlliedWith(actor)
			&& _attacker.getTile().getDistanceTo(actor.getTile()) == 1
			&& ::Tactical.TurnSequenceBar.getActiveEntity() != null && ::Tactical.TurnSequenceBar.getActiveEntity().getID() == _attacker.getID()
			&& _skill != null
		)
			{
				local skill = actor.m.Skills.getAttackOfOpportunity();
				if (skill != null)
				{
					local info = {
						User = actor,
						Skill = skill,
						TargetTile = _attacker.getTile()
					};
					::Time.scheduleEvent(this.TimeUnit.Virtual, ::Const.Combat.RiposteDelay, this.onRiposte, info);
				}
			}
	}

	function onRiposte( _info )
	{
		_info.Skill.useForFree(_info.TargetTile);
	}

	function onTurnStart()
	{
		this.m.Active = true;
		this.m.Immunity = true;
	}

	function onTurnEnd()
	{
		if (!this.getContainer().getActor().getSkills().hasSkill("effects._riposte_debuff"))
			this.m.Container.add(::new("scripts/skills/effects/_riposte_debuff"));
	}

	function onCombatStarted()
	{
		this.m.Active = true;
		this.m.Immunity = true;
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Active = false;
	}

	function onUpdate( _properties )
	{
		if (this.m.Immunity)
		{
			_properties.IsImmuneToStun = true;
			_properties.IsImmuneToDaze = true;
			_properties.IsImmuneToBleeding = true;
			_properties.IsImmuneToPoison = true;
		}
	}

});

