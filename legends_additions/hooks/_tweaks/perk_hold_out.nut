::mods_hookExactClass("skills/perks/perk_hold_out", function(o) {
    o.onUpdate = function( _properties )
	{
		_properties.NegativeStatusEffectDuration += -5;
		_properties.Hitpoints += 8;
		_properties.SurviveWithInjuryChanceMult *= 2.0;
	}
});
