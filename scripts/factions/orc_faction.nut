this.orc_faction <- this.inherit("scripts/factions/faction", {
	m = {},
	function create()
	{
		this.faction.create();
		this.m.Type = this.Const.FactionType.Orcs;
		this.m.Base = "world_base_05";
		this.m.TacticalBase = "bust_base_orcs";
		this.m.CombatMusic = this.Const.Music.OrcsTracks;
		this.m.Footprints = this.Const.OrcFootprints;
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

