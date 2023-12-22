::mods_hookExactClass("entity/tactical/enemies/spider_eggs", function (o)
{
    o.onSpawn = function( _tile )
	{
		if (_tile.IsEmpty) return;
		if (!_tile.IsOccupiedByActor || _tile.getEntity().getType() != ::Const.EntityType.SpiderEggs) return;
		if (this.Tactical.Entities.isEnemyRetreating()) return;


		local tile;

		for( local i = 0; i < 6; i = i )
		{
			if (_tile.hasNextTile(i))
			{
                local nextTile = _tile.getNextTile(i);
				if (!nextTile.IsEmpty || ::Math.abs(nextTile.Level - _tile.Level) > 1)
				{
				}
				else
				{
					tile = nextTile;
					break;
				}
			}
			i = ++i;
		}

		if (tile != null)
		{
			local spawn = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/spider", tile.Coords);
			spawn.setSize(::Math.rand(60, 75) * 0.01);
            spawn.m.Skills.removeByID("actives.web");
			spawn.setFaction(this.getFaction());
			spawn.m.XP = spawn.m.XP / 2;
			local allies = this.Tactical.Entities.getInstancesOfFaction(this.getFaction());

			foreach( a in allies )
			{
				if (a.getType() == ::Const.EntityType.Hexe)
				{
					spawn.getSkills().add(::new("scripts/skills/effects/fake_charmed_effect"));
					break;
				}
			}

			++this.m.Count;
		}

		if (this.m.Count < 4) this.registerSpawnEvent();
		else this.killSilently();
	}

});