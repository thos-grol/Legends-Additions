this.cultist_faction <- this.inherit("scripts/factions/faction", {
	m = {},
	function create()
	{
		this.faction.create();
		this.m.Type = ::Const.FactionType.Cultists;
		this.m.Banner = 13;
		this.m.Base = "world_base_07";
		this.m.TacticalBase = "bust_base_bandits";
		this.m.CombatMusic = ::Const.Music.BanditTracks;
		this.m.PlayerRelation = 0.0;
		this.m.IsHidden = true;
		this.m.IsRelationDecaying = false;
	}

	function addTrait( _list )
	{
		this.m.Deck = [];
		foreach( c in _list )
		{
			local card = this.new(c);
			card.setFaction(this);
			this.m.Deck.push(card);
		}
	}

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);
	}

	function getSettlementSpawn()
	{
		return this.getLairs().len() <= 4;
	}

	function getLairs(){
		local lairs = []
		foreach (location in this.getSettlements())
		{
			if (location != null 
				&& (location.m.TypeID == "location.cultist_camp"
				|| location.m.TypeID == "location.cultist_hideout")
			)
				lairs.push(location);
		}
		return lairs;
	}
	
	function hasLairs(){
		return this.getLairs().len() != 0
	}

});

