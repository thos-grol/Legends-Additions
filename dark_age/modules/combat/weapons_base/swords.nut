::mods_hookExactClass("items/weapons/oriental/saif", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/scimitar", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/named/named_shamshir", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/shamshir", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/named/named_shamshir", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

::mods_hookExactClass("items/weapons/oriental/qatal_dagger", function (o){
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Dagger;
	}
});

::mods_hookExactClass("items/weapons/named/named_qatal_dagger", function (o){
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Dagger;
	}
});

::mods_hookExactClass("items/weapons/oriental/two_handed_scimitar", function (o){
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Sword;
	}
});

::mods_hookExactClass("items/weapons/named/named_two_handed_scimitar", function (o){
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Sword;
	}
});

::mods_hookExactClass("items/weapons/oriental/two_handed_saif", function (o){
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.WeaponType = this.Const.Items.WeaponType.Cleaver | this.Const.Items.WeaponType.Sword;
	}
});
