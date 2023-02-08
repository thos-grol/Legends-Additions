::mods_hookExactClass("entity/tactical/player", function(o)
{
	local setMoraleState = o.setMoraleState;
	o.setMoraleState = function( _m )
	{
		if (_m == ::Const.MoraleState.Confident && this.m.Skills.hasSkill("trait.insecure")) return;
		if (this.m.Skills.hasSkill("effects.ancient_priest_potion") && _m < 3) return;
		if (_m == ::Const.MoraleState.Fleeing && this.m.Skills.hasSkill("trait.oath_of_valor")) return;

		if (_m == ::Const.MoraleState.Confident && this.getMoraleState() != ::Const.MoraleState.Confident && this.isPlacedOnMap() && this.Time.getRound() >= 1 && ("State" in this.World) && this.World.State != null && this.World.Ambitions.hasActiveAmbition() && this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_camaraderie")
		{
			this.World.Statistics.getFlags().increment("OathtakersBrosConfident");
		}

		this.actor.setMoraleState(_m);
	}

	local checkMorale = o.checkMorale;
	o.checkMorale = function( _change, _difficulty, _type = ::Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		if (_change < 0 && this.m.Skills.hasSkill("effects.ancient_priest_potion"))
		{
			if (this.m.MoraleState < 3) this.actor.setMoraleState(3);
			return false;
		}

		if (_change > 0 && this.m.MoraleState == ::Const.MoraleState.Steady && this.m.Skills.hasSkill("trait.insecure")) return false;
		if (_change < 0 && this.m.MoraleState == ::Const.MoraleState.Breaking && this.m.Skills.hasSkill("trait.oath_of_valor")) return false;

		if (_change > 0 && this.m.Skills.hasSkill("trait.optimist"))
		{
			_difficulty = _difficulty + 5;
		}
		else if (_change < 0 && this.m.Skills.hasSkill("trait.pessimist"))
		{
			_difficulty = _difficulty - 5;
		}
		else if (this.m.Skills.hasSkill("trait.irrational"))
		{
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 10 : -10);
		}
		else if (this.m.Skills.hasSkill("trait.mad"))
		{
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 15 : -15);
		}

		if (_change < 0 && _type == ::Const.MoraleCheckType.MentalAttack && this.m.Skills.hasSkill("trait.superstitious")) _difficulty = _difficulty - 10;

		return this.actor.checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}
});