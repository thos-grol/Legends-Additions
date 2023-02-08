//fixes bloodlust to count legends bleeding sources as well as bleeding injuries
::mods_hookExactClass("skills/perks/perk_ptr_bloodlust", function(o) {
	o.onBeforeAnySkillExecuted = function( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (!_skill.isAttack() || _skill.isRanged() || _targetEntity == null)
		{
			return;
		}

		this.m.ActorFatigue = null;
		this.m.BleedStacksBeforeAttack = _targetEntity.getSkills().getAllSkillsByID("effects.bleeding").len() + _targetEntity.getSkills().getAllSkillsByID("effects.legend_grazed_effect").len() + _targetEntity.getSkills().getAllSkillsByID("injury.cut_artery").len() + _targetEntity.getSkills().getAllSkillsByID("injury.cut_throat").len();
	}

    o.onAnySkillExecuted = function( _skill, _targetTile, _targetEntity, _forFree )
    {
        local actor = this.getContainer().getActor();
        if (!_skill.isAttack() || _skill.isRanged() || _targetEntity == null || _targetEntity.isAlliedWith(actor) || !::Tactical.TurnSequenceBar.isActiveEntity(actor))
        {
            return;
        }

        local bleedCount = this.m.BleedStacksBeforeAttack;

        if (_targetEntity.isAlive() && !_targetEntity.isDying())
        {
            bleedCount += _targetEntity.getSkills().getAllSkillsByID("effects.bleeding").len() + _targetEntity.getSkills().getAllSkillsByID("effects.legend_grazed_effect").len() + _targetEntity.getSkills().getAllSkillsByID("injury.cut_artery").len() + _targetEntity.getSkills().getAllSkillsByID("injury.cut_throat").len() - this.m.BleedStacksBeforeAttack;
        }

        this.m.FatigueRecoveryStacks += bleedCount;

        if (this.m.ActorFatigue == null) this.m.ActorFatigue = actor.getFatigue();

        actor.setFatigue(this.Math.max(0, this.m.ActorFatigue - this.m.ActorFatigue * (bleedCount * this.m.FatigueReductionPercentage * 0.01)));
    }

});
