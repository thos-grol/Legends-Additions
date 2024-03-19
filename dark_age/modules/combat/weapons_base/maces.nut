//Maces to Hammers
::mods_hookExactClass("items/weapons/barbarians/claw_club", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/barbarians/two_handed_spiked_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/greenskins/goblin_staff", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/greenskins/legend_bough", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/greenskins/orc_metal_club", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/greenskins/orc_wooden_club", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/named/legend_named_military_goedendag", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/named/legend_named_shovel", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/named/named_heavy_southern_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/named/named_lute", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Musical | ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/named/named_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/named/named_polemace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/named/named_two_handed_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/named/named_two_handed_spiked_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/oriental/heavy_southern_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/oriental/light_southern_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/oriental/nomad_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/oriental/polemace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/bludgeon", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/goedendag", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/legend_military_goedendag", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/legend_shovel", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/legend_two_handed_club", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/lute", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Musical | ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/morning_star", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/two_handed_flanged_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/two_handed_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/winged_mace", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/wooden_stick", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.WeaponType = ::Const.Items.WeaponType.Hammer;
    }
});

::mods_hookExactClass("items/weapons/military_pick", function (o){
    local create = o.create;
    o.create = function()
    {
        create();
        this.m.ShieldDamage = 0;
		this.m.Condition = 56.0;
		this.m.ConditionMax = 56.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 35;
		this.m.RegularDamageMax = 50;
		this.m.ArmorDamageMult = 1.5;
		this.m.DirectDamageMult = 0.5;
    }
});
