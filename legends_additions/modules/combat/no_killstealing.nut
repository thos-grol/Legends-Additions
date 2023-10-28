::mods_hookExactClass("items/item_container", function (o)
{
    function dropAll( _tile, _killer, _flip = false )
	{
		local no_killstealing = this.m.Actor.getSkills().getSkillByID("effects._nokillstealing");
        local isPlayer = this.m.Actor.getFaction() == this.Const.Faction.Player || this.isKindOf(this.m.Actor.get(), "player");
        local IsDroppingLoot = true;
		local emergency = false;

        if (no_killstealing == null) IsDroppingLoot = false;
        else 
        {
            foreach(faction in no_killstealing.m.Factions)
            {
                local player_faction_amount = 0;
                local faction_max = 0;
                local faction_max_amount = 0;

                if (faction == ::Const.Faction.Player
                    || faction == ::Const.Faction.PlayerAnimals)
                {
                    player_faction_amount += no_killstealing.m.Factions[faction];
                    if (faction_max_amount <= player_faction_amount)
                    {
                        faction_max = ::Const.Faction.Player;
                        faction_max_amount = player_faction_amount;
                    }
                }
                else
                {
                    faction_max = faction;
                    faction_max_amount = no_killstealing.m.Factions[faction];
                }
            }

            if (faction_max == ::Const.Faction.Player) IsDroppingLoot = true;
        }

		if (_tile == null)
		{
			if (this.m.Actor.isPlacedOnMap())
			{
				_tile = this.m.Actor.getTile();
				emergency = true;
			}
			else return;
		}

		for( local i = 0; i < this.Const.ItemSlot.COUNT; i = i )
		{
			for( local j = 0; j < this.m.Items[i].len(); j = j )
			{
				if (this.m.Items[i][j] == null || this.m.Items[i][j] == -1)
				{
				}
				else if (this.m.Items[i][j].isChangeableInBattle(null) || emergency)
				{
					if (IsDroppingLoot || this.m.Items[i][j].isItemType(this.Const.Items.ItemType.Legendary))
					{
						this.m.Items[i][j].drop(_tile);
					}
					else
					{
						this.m.Items[i][j].m.IsDroppedAsLoot = false;
					}
				}
				else if (!IsDroppingLoot && !this.m.Items[i][j].isItemType(this.Const.Items.ItemType.Legendary))
				{
					this.m.Items[i][j].m.IsDroppedAsLoot = false;
				}

				j = ++j;
			}

			i = ++i;
		}

		_tile.IsContainingItemsFlipped = _flip;
	}
});