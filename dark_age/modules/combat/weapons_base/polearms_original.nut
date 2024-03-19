::mods_hookExactClass("items/weapons/billhook", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Cleaver;
	}
});

::mods_hookExactClass("items/weapons/hooked_blade", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Cleaver;
	}
});

::mods_hookExactClass("items/weapons/legend_halberd", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Axe;
	}
});

::mods_hookExactClass("items/weapons/pike", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
		this.m.Description = "A long pike used that can thrust at 3 distance and keep the enemy at bay.";

	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale_long");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		this.addSkill(impale);
		this.addSkill(this.new("scripts/skills/actives/repel"));
	}
});

::mods_hookExactClass("items/weapons/ancient/bladed_pike", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
		this.m.Description = "A long, ancient pike used to attack over 3 tile distance and keep the enemy at bay.";
		this.m.IconLarge = "weapons/melee/bladed_pike_01.png";

	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale_long");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		this.addSkill(impale);
		this.addSkill(this.new("scripts/skills/actives/repel"));
	}
});

::mods_hookExactClass("items/weapons/ancient/broken_bladed_pike", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
		this.m.Description = "A bladed pike with a broken tip that can attack at 3 tile range. Not all weapons stand the test of time. Once used to attack over some distance and keeping the enemy at bay.";

	}

	o.onEquip = function()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale_long");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		this.addSkill(impale);
		this.addSkill(this.new("scripts/skills/actives/repel"));
	}
});

::mods_hookExactClass("items/weapons/named/named_pike", function (o){
	o.onEquip = function()
	{
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale_long");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		this.addSkill(impale);
		this.addSkill(this.new("scripts/skills/actives/repel"));
	}
});



::mods_hookExactClass("items/weapons/ancient/warscythe", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Cleaver;
	}
});

::mods_hookExactClass("items/weapons/named/named_warscythe", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Cleaver;
	}
});


::mods_hookExactClass("items/weapons/named/legend_named_halberd", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Axe;
	}
});


::mods_hookExactClass("items/weapons/named/named_billhook", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Cleaver;
	}
});

::mods_hookExactClass("items/weapons/oriental/swordlance", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Sword;
	}
});

::mods_hookExactClass("items/weapons/named/named_swordlance", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Sword;
	}
});

