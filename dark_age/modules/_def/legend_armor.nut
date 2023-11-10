::mods_hookExactClass("items/legend_armor/legend_armor", function (o)
{
	o.onDamageReceived = function( _damage, _fatalityType, _attacker )
	{
		local totalDamage = _damage;
		for( local i = ::Const.Items.ArmorUpgrades.COUNT - 1; i >= 0; i = --i )
		{
			local u = this.m.Upgrades[i];
			if (u != null) totalDamage = u.onDamageReceived(totalDamage, _fatalityType, _attacker);
		}
		if (this.m.Condition == 0)
		{
			this.updateAppearance();
			return;
		}
		local prev_condition = this.m.Condition;
		this.m.Condition = this.Math.max(0, this.m.Condition - totalDamage) * 1.0;
		::Z.Log.damage_armor(this.getContainer().getActor(), this.makeName(), this.m.Condition, prev_condition, _damage);

		if (this.m.Condition == 0 && !this.m.IsIndestructible && _attacker != null && _attacker.isPlayerControlled())
			this.Tactical.Entities.addArmorParts(this.getArmorMax());
		this.updateAppearance();
	}

});