::mods_hookExactClass("items/weapons/oriental/handgonne", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 2;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RangeMaxBonus = 1;
		this.m.StaminaModifier = -14;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 95;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.25;
		this.m.IsEnforcingRangeLimit = true;
    }
});

::mods_hookExactClass("items/weapons/named/named_handgonne", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 2;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RangeMaxBonus = 1;
		this.m.StaminaModifier = -14;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.RegularDamage = 55;
		this.m.RegularDamageMax = 95;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.25;
		this.m.IsEnforcingRangeLimit = true;
		this.randomizeValues();
    }
});