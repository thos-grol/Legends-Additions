::mods_hookExactClass("entity/tactical/actor", function (o)
{
    o.rollEquipment <- function() //iterate through all items and roll them
    {
        foreach( item in this.getItems().getAllItems() )
        {
            if (!("m" in item)) continue;
            if ("roll_values" in item) item.roll_values();
        }
    }
});

::mods_hookNewObject("entity/tactical/tactical_entity_manager", function ( o ) //hook to roll equipment after adding it
{
    o.setupEntity = function( _e, _t )
	{
		_e.setWorldTroop(_t);
		_e.setFaction(_t.Faction);

		if (("Callback" in _t) && _t.Callback != null)
		{
			_t.Callback(_e, "Tag" in _t ? _t.Tag : null);
		}

		if (_t.Variant != 0)
		{
			_e.makeMiniboss();
		}

		_e.assignRandomEquipment();
		_e.rollEquipment();

		if (("Name" in _t) && _t.Name != "")
		{
			_e.setName(_t.Name);
			_e.m.IsGeneratingKillName = false;
		}

		if (!this.World.getTime().IsDaytime && _e.getBaseProperties().IsAffectedByNight)
		{
			_e.getSkills().add(this.new("scripts/skills/special/night_effect"));
		}
	};

});

