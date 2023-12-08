this.cultist_eyes_on_the_inside <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.eyes_on_the_inside";
		this.m.Name = "Eyes on the Inside";
		this.m.Description = "";
		this.m.Icon = "ui/perks/eyes_on_the_inside.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTurnStart()
	{
		if(this.Math.rand(1,100) > 44) return;
		local actor = this.getContainer().getActor();
		local tag = {
			User = actor
		};
		this.Time.scheduleEvent(this.TimeUnit.Virtual, 1000, this.onDelayedEffect, tag);
	}

	function onDelayedEffect( _tag )
	{
		local mytile = _tag.User.getTile();
		local actors = this.Tactical.Entities.getAllInstances();
		local enemies = [];
		local range = _tag.User.getCurrentProperties().getVision();
		local difficulty = -10; //-10 difficulty means you need about 80 resolve to ignore the check

		foreach( i in actors )
		{
			foreach( a in i )
			{
				if (!a.isAlliedWith(_tag.User) && a.getID() != _tag.User.getID() && a.getTile().getDistanceTo(mytile) <= range) enemies.push(a);
			}
		}

		if (enemies.len() == 0) return;
		local target = ::MSU.Array.rand(enemies);
		target.checkMorale(-1, difficulty, ::Const.MoraleCheckType.MentalAttack);

		local drained = target.getSkills().getSkillByID("effects.drained_effect");
		if (drained == null)
		{
			drained = target.getSkills().add(::new("scripts/skills/effects/drained_effect"));
			if (_tag.User.getSkills().hasSkill("injury.brain_damage") && _tag.User.getSkills().hasSkill("perk.legend_specialist_cult_armor"))
			{
				drained.resetTime();
			}
		}
		else
		{
			drained.resetTime();
			if (_tag.User.getSkills().hasSkill("injury.brain_damage") && _tag.User.getSkills().hasSkill("perk.legend_specialist_cult_armor"))
			{
				drained.resetTime();
			}
		}



		if (this.Math.rand(1,100) <= 50)
			this.Sound.play("sounds/cultist/eyes_on_the_inside_01.wav", 200.0, _tag.User.getPos(), this.Math.rand(95, 105) * 0.01);
		else
			this.Sound.play("sounds/cultist/eyes_on_the_inside_02.wav", 200.0, _tag.User.getPos(), this.Math.rand(95, 105) * 0.01);
		this.Tactical.EventLog.log(::Const.UI.getColorizedEntityName(target) + " has been gazed at by " + ::Const.UI.getColorizedEntityName(_tag.User));


	}

	function onUpdate( _properties )
	{
		_properties.HitpointsMult *= 1.25;
		_properties.IsAffectedByNight = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("trait.mad"))
			this.m.Container.add(::new("scripts/skills/traits/mad_trait"));
	}

});

