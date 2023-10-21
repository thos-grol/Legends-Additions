::mods_hookExactClass("items/weapons/light_crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();

    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shoot_bolt"));
        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});

::mods_hookExactClass("items/weapons/crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();

    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shoot_bolt"));
        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});

::mods_hookExactClass("items/weapons/named/named_crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();

    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shoot_bolt"));
        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});

::mods_hookExactClass("items/weapons/heavy_crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();

    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shoot_bolt"));
        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});

::mods_hookExactClass("items/weapons/greenskins/goblin_crossbow", function (o){
    local create = o.create;
    o.create = function()
    {
        create();

    }

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shoot_stake"));
        if (!this.m.IsLoaded) this.addSkill(this.new("scripts/skills/actives/reload_bolt"));
	}
});


