//makes direwolf ractial legendary
::mods_hookExactClass("skills/racial/werewolf_racial", function (o)
{
    o.onUpdate = function( _properties )
	{
		local healthMissing = _properties.Hitpoints - this.getContainer().getActor().getHitpoints();
		local additionalDamage = this.Math.floor(healthMissing * 0.5);

		if (additionalDamage > 0)
		{
			_properties.DamageRegularMin += additionalDamage;
			_properties.DamageRegularMax += additionalDamage;
		}
	}
});