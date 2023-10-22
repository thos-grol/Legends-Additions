::mods_hookExactClass("items/shields/shield", function (o)
{
    o.onUpdateProperties = function( _properties )
	{
		if (this.m.Condition == 0) return;
		_properties.MeleeDefense += this.m.MeleeDefense;
		_properties.RangedDefense += this.m.RangedDefense;
		_properties.Stamina += this.m.StaminaModifier;
	}

});

//nerf tower shield stamina

::mods_hookExactClass("items/shields/legend_faction_tower_shield", function (o)
{
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -40;
	}
});

::mods_hookExactClass("items/shields/legend_tower_shield", function (o)
{
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -40;
	}
});

::mods_hookExactClass("items/shields/ancient/legend_mummy_tower_shield", function (o)
{
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -40;
	}
});

::mods_hookExactClass("items/shields/ancient/tower_shield", function (o)
{
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.StaminaModifier = -40;
	}
});

