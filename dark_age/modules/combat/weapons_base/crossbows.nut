::mods_hookExactClass("items/weapons/light_crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 1;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -6;
		this.m.Condition = 40.0;
		this.m.ConditionMax = 40.0;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 65;
		this.m.ArmorDamageMult = 0.6;
		this.m.DirectDamageMult = 0.55;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();

		local shoot = this.new("scripts/skills/actives/shoot_bolt");
		shoot.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(shoot);

        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});

::mods_hookExactClass("items/weapons/crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 1;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -8;
		this.m.Condition = 48.0;
		this.m.ConditionMax = 48.0;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.75;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();

		local shoot = this.new("scripts/skills/actives/shoot_bolt");
		shoot.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(shoot);

        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});

::mods_hookExactClass("items/weapons/named/named_crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 1;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -12;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.RegularDamage = 60;
		this.m.RegularDamageMax = 80;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.75;
		this.randomizeValues();
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();

		local shoot = this.new("scripts/skills/actives/shoot_bolt");
		shoot.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(shoot);

        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});

::mods_hookExactClass("items/weapons/heavy_crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.RangeMin = 1;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -12;
		this.m.Condition = 64.0;
		this.m.ConditionMax = 64.0;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 90;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.75;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();

		local shoot = this.new("scripts/skills/actives/shoot_bolt");
		shoot.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(shoot);

        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});

::mods_hookExactClass("items/weapons/greenskins/goblin_crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.Condition = 72;
		this.m.ConditionMax = 72;
		this.m.RangeMin = 1;
		this.m.RangeMax = 7;
		this.m.RangeIdeal = 7;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 70;
		this.m.RegularDamageMax = 110;
		this.m.ArmorDamageMult = 0.75;
		this.m.DirectDamageMult = 0.75;
    }

    o.onEquip = function()
	{
		this.weapon.onEquip();

		local shoot = this.new("scripts/skills/actives/shoot_stake");
		shoot.m.DirectDamageMult = this.m.DirectDamageMult;
		this.addSkill(shoot);

        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});


