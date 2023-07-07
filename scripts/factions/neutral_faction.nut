this.undead_faction <- this.inherit("scripts/factions/faction", {
	m = {},
	function create()
	{
		this.faction.create();
		this.m.Type = this.Const.FactionType.Neutral;
		this.m.Base = "world_base_10";
		this.m.TacticalBase = "bust_base_beasts";
		this.m.CombatMusic = this.Const.Music.BeastsTracks;
		this.m.Footprints = this.Const.BeastFootprints;
		this.m.PlayerRelation = 0.0;
		this.m.IsHidden = true;
		this.m.IsRelationDecaying = false;
	}

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);
	}

});

