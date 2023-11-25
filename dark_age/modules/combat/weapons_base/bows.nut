::mods_hookExactClass("items/weapons/greenskins/goblin_bow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Condition = 52.0;
		this.m.ConditionMax = 52.0;
		this.m.StaminaModifier = -3;
		this.m.RangeMin = 2;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 0.55;
		this.m.DirectDamageMult = 0.35;
        this.m.Draw3 <- 60;
        this.m.Draw4 <- 50;
        this.m.Draw5 <- 40;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}
});

::mods_hookExactClass("items/weapons/wonky_bow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -6;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.5;
		this.m.DirectDamageMult = 0.35;
		this.m.AdditionalAccuracy = -15;
        this.m.Draw3 <- 70;
        this.m.Draw4 <- 60;
        this.m.Draw5 <- 50;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}
});

::mods_hookExactClass("items/weapons/short_bow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.StaminaModifier = -4;
		this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 0.5;
		this.m.DirectDamageMult = 0.35;
        this.m.Draw3 <- 65;
        this.m.Draw4 <- 55;
        this.m.Draw5 <- 45;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}
});

::mods_hookExactClass("items/weapons/greenskins/goblin_heavy_bow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Condition = 62.0;
		this.m.ConditionMax = 62.0;
		this.m.StaminaModifier = -4;
		this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.35;
        this.m.Draw3 <- 75;
        this.m.Draw4 <- 65;
        this.m.Draw5 <- 55;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}
});

::mods_hookExactClass("items/weapons/named/named_goblin_heavy_bow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Condition = 62.0;
		this.m.ConditionMax = 62.0;
		this.m.StaminaModifier = -4;
		this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.35;
        this.m.Draw3 <- 75;
        this.m.Draw4 <- 65;
        this.m.Draw5 <- 55;
		this.randomizeValues();
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}
});

::mods_hookExactClass("items/weapons/oriental/composite_bow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.StaminaModifier = -6;
		this.m.RangeMin = 2;
		this.m.RangeMax = 6;
		this.m.RangeIdeal = 6;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.35;
        this.m.Draw3 <- 75;
        this.m.Draw4 <- 65;
        this.m.Draw5 <- 55;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}
});

::mods_hookExactClass("items/weapons/hunting_bow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -6;
		this.m.Condition = 80.0;
		this.m.ConditionMax = 80.0;
		this.m.RegularDamage = 40;
		this.m.RegularDamageMax = 60;
		this.m.ArmorDamageMult = 0.55;
		this.m.DirectDamageMult = 0.35;

        this.m.Draw3 <- 90;
        this.m.Draw4 <- 75;
        this.m.Draw5 <- 60;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}
});

::mods_hookExactClass("items/weapons/war_bow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -6;
		this.m.Condition = 100.0;
		this.m.ConditionMax = 100.0;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.35;

        this.m.Draw3 <- 95;
        this.m.Draw4 <- 80;
        this.m.Draw5 <- 65;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}
});

::mods_hookExactClass("items/weapons/named/named_warbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 2;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -6;
		this.m.Condition = 100.0;
		this.m.ConditionMax = 100.0;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.35;
		this.randomizeValues();

        this.m.Draw3 <- 95;
        this.m.Draw4 <- 80;
        this.m.Draw5 <- 65;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/aimed_shot"));
	}
});