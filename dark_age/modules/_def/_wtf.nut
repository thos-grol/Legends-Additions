::mods_hookExactClass("entity/world/settlement", function(o) {
	o.updateRoster <- function( _force = false )
	{
		local daysPassed = (this.Time.getVirtualTimeF() - this.m.LastRosterUpdate) / this.World.getTime().SecondsPerDay;
		if (!_force && this.m.LastRosterUpdate != 0 && daysPassed < 2) return;
		if (this.m.RosterSeed != 0) ::Math.seedRandom(this.m.RosterSeed);
		this.m.RosterSeed = ::Math.floor(this.Time.getRealTime() + ::Math.rand());
		this.m.LastRosterUpdate = this.Time.getVirtualTimeF();

		if (::Math.rand(1,100) <= 33) return; //33% chance to not get any roster

		local roster = this.World.getRoster(this.getID());
		local allbros = roster.getAll();
		local current = [];

		for( local i = 0; i < allbros.len(); i = i )
		{
			if (allbros[i].isStabled())
			{
				continue;
			}
			else
			{
				current.push(allbros[i]);
			}

			i = ++i;
		}

		local iterations = ::Math.max(1, daysPassed / 2);
		local activeLocations = 0;

		foreach( loc in this.m.AttachedLocations )
		{
			if (loc.isActive())
			{
				activeLocations = ++activeLocations;
				activeLocations = activeLocations;
				activeLocations = activeLocations;
			}
		}

		local rosterMin = 3;
		local rosterMax = 3;

		if (this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation() < 50)
		{
			rosterMin = rosterMin * (this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation() / 50.0);
			rosterMax = rosterMax * (this.World.FactionManager.getFaction(this.m.Factions[0]).getPlayerRelation() / 50.0);
		}

		rosterMin = rosterMin + this.World.Assets.m.RosterSizeAdditionalMin;
		rosterMax = rosterMax + this.World.Assets.m.RosterSizeAdditionalMax;

		if (iterations < 7)
		{
			for( local i = 0; i < iterations; i = i )
			{
				for( local maxRecruits = ::Math.rand(::Math.max(0, rosterMax / 2 - 1), rosterMax - 1); current.len() > maxRecruits;  )
				{
					local n = ::Math.rand(0, current.len() - 1);
					roster.remove(current[n]);
					current.remove(n);
				}

				i = ++i;
				i = i;
			}
		}
		else
		{
			for( local i = 0; i < current.len(); i = i )
			{
				roster.remove(current[i]);
				i = ++i;
				i = i;
			}

			current = [];
		}

		local maxRecruits = ::Math.rand(rosterMin, rosterMax);
		local draftList;
		draftList = this.getDraftList();

		foreach( loc in this.m.AttachedLocations )
		{
			loc.onUpdateDraftList(draftList);
		}

		foreach( b in this.m.Buildings )
		{
			if (b != null)
			{
				b.onUpdateDraftList(draftList);
			}
		}

		foreach( s in this.m.Situations )
		{
			s.onUpdateDraftList(draftList);
		}

		this.World.Assets.getOrigin().onUpdateDraftList(draftList, this);

		while (maxRecruits > current.len())
		{
			local bro = roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx(draftList);
			this.World.Assets.getOrigin().onGenerateBro(bro);
			current.push(bro);
		}

		this.updateStables(_force);
		this.World.Assets.getOrigin().onUpdateHiringRoster(roster);
	}
});
