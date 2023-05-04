::mods_hookExactClass("entity/world/settlements/buildings/port_building", function(o) {
	o.isHidden = function()
	{
		return !this.m.Settlement.isCoastal();
	}

	o.getUITravelRoster = function()
	{
		local data = {
			Title = "Harbor",
			SubTitle = "A harbor that allows you to book passage by ship to other parts of the continent",
			HeaderImage = null,
			Roster = []
		};
		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			if (!s.isCoastal())
			{
				continue;
			}

			if (s.getID() == this.m.Settlement.getID())
			{
				continue;
			}

			if (!s.isAlliedWithPlayer() || !this.m.Settlement.getOwner().isAlliedWith(s.getFaction()))
			{
				continue;
			}

			local dest = {
				ID = s.getID(),
				EntryID = data.Roster.len(),
				ListName = "Sail to " + s.getName(),
				Name = s.getName(),
				Cost = this.getCostTo(s),
				ImagePath = s.getImagePath(),
				ListImagePath = s.getImagePath(),
				FactionImagePath = s.getOwner().getUIBannerSmall(),
				BackgroundText = s.getDescription() + "<br><br>" + this.getRandomDescription(s.getName())
			};
			data.Roster.push(dest);
		}

		return data;
	}

	o.getCostTo = function( _to )
	{
		local myTile = this.getSettlement().getTile();
		local dist = _to.getTile().getDistanceTo(myTile);
		local cost = dist * this.World.getPlayerRoster().getSize() * 0.5;
		cost = this.Math.round(cost * 0.1);
		cost = cost * 10.0;
		return cost;
	}

});
