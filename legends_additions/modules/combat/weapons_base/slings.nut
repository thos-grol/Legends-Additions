::mods_hookExactClass("items/weapons/legend_sling", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.StaminaModifier = -4;
		this.m.RangeMin = 2;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.35;
    }
});

::mods_hookExactClass("items/weapons/oriental/nomad_sling", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.StaminaModifier = -6;
		this.m.RangeMin = 2;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.35;
    }
});

::mods_hookExactClass("items/weapons/legend_slingstaff", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -12;
		this.m.Condition = 100.0;
		this.m.ConditionMax = 100.0;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 1.125;
		this.m.DirectDamageMult = 0.75;
    }
});

