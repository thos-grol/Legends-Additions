::mods_hookExactClass("items/weapons/wooden_stick", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Condition = 32.0;
		this.m.ConditionMax = 32.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 20;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 0.5;
		this.m.DirectDamageMult = 0.4;
    }
});

::mods_hookExactClass("items/weapons/legend_hoe", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.ShieldDamage = 20;
		this.m.Condition = 30.0;
		this.m.ConditionMax = 30.0;
		this.m.StaminaModifier = -4;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.3;
		this.m.DirectDamageAdd = -0.05;
    }
});

::mods_hookExactClass("items/weapons/legend_wooden_spear", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Condition = 20.0;
		this.m.ConditionMax = 20.0;
		this.m.StaminaModifier = -6;
		this.m.RegularDamage = 15;
		this.m.RegularDamageMax = 25;
		this.m.ArmorDamageMult = 0.45;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = -0.05;
    }
});

::mods_hookExactClass("items/weapons/legend_hammer", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Condition = 44.0;
		this.m.ConditionMax = 44.0;
		this.m.StaminaModifier = -5;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 35;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.5;
		this.m.DirectDamageAdd = -0.1;
    }
});

::mods_hookExactClass("items/weapons/pickaxe", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.ShieldDamage = 0;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.5;
    }
});





