::mods_hookExactClass("items/legend_helmets/legend_helmet", function (o)
{
	o.onDamageReceived = function( _damage, _fatalityType, _attacker )
	{
		local totalDamage = _damage;

		for( local i = this.m.Upgrades.len() - 1; i >= 0; i = --i )
		{
			if (this.m.Upgrades[i] == null || i == ::Const.Items.HelmetUpgrades.ExtraVanity)
			{
			}
			else
			{
				totalDamage = this.m.Upgrades[i].onDamageReceived(totalDamage, _fatalityType, _attacker);
			}
		}

		if (this.m.Condition == 0)
		{
			this.updateAppearance();
			return;
		}

		local prev_condition = this.m.Condition;
		this.m.Condition = ::Math.max(0, this.m.Condition - totalDamage) * 1.0;

		if (this.m.Condition == 0 && !this.m.IsIndestructible)
		{
			::Z.Log.damage_armor(this.getContainer().getActor(), this.makeName(), this.m.Condition, prev_condition, _damage);

			if (_attacker != null && _attacker.isPlayerControlled())
			{
				this.Tactical.Entities.addArmorParts(this.getArmorMax());
			}
		}
		else
		{
			::Z.Log.damage_armor(this.getContainer().getActor(), this.makeName(), this.m.Condition, prev_condition, _damage);
		}

		this.updateAppearance();
	}

    //WTF??? asks for slot 5, but helmets have slots 0-4. Just use try catch
    o.getUpgrade = function( _slot = -1 )
	{
		if (_slot != -1)
		{
			try {
				return this.m.Upgrades[_slot];
			} catch(exception) {
				return null;
			}
		}

		foreach( u in this.m.Upgrades )
		{
			if (u != null)
			{
				return u;
			}
		}

		return null;
	}
});