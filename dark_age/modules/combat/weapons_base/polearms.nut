::mods_hookExactClass("items/weapons/warfork", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/spetum", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});


::mods_hookExactClass("items/weapons/legend_swordstaff", function (o){
	o.post_create <- function()
	{
        this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Polearm;
	}

    o.onEquip = function()
	{
		this.weapon.onEquip();
        this.addSkill(this.new("scripts/skills/actives/thrust_swordstaff"));
		this.addSkill(this.new("scripts/skills/actives/spearwall"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
		this.addSkill(this.new("scripts/skills/actives/lunge_skill"));
	}
});

::mods_hookExactClass("items/weapons/named/legend_named_swordstaff", function (o){
	o.post_create <- function()
	{
        this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Polearm;
	}

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/thrust_swordstaff"));
		this.addSkill(this.new("scripts/skills/actives/spearwall"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
		this.addSkill(this.new("scripts/skills/actives/lunge_skill"));
	}
});

::mods_hookExactClass("items/weapons/named/named_royal_lance", function (o){
	o.post_create <- function()
	{
        this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Polearm;
	}

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/thrust_swordstaff"));
		this.addSkill(this.new("scripts/skills/actives/spearwall"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
		this.addSkill(this.new("scripts/skills/actives/lunge_skill"));
	}
});

::mods_hookExactClass("items/weapons/legendary/legend_mage_swordstaff", function (o){
	o.post_create <- function()
	{
        this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Polearm;
	}

    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/thrust_swordstaff"));
		this.addSkill(this.new("scripts/skills/actives/spearwall"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
		this.addSkill(this.new("scripts/skills/actives/lunge_skill"));
		this.addSkill(this.new("scripts/skills/actives/reap_skill"));
		this.addSkill(this.new("scripts/skills/actives/swing"));
		this.addSkill(this.new("scripts/skills/actives/split"));
		this.addSkill(this.new("scripts/skills/actives/overhead_strike"));
	}
});

//remap and reproperties

::mods_hookExactClass("items/weapons/boar_spear", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/fighting_spear", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/legend_battle_glaive", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/legend_glaive", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/legend_militia_glaive", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/legend_wooden_spear", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/militia_spear", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/oriental/firelance", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Firearm;
	}
});


//named

::mods_hookExactClass("items/weapons/named/legend_named_glaive", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/named/named_goblin_spear", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/named/named_spear", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/named/named_spetum", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});



//ancient

::mods_hookExactClass("items/weapons/ancient/ancient_spear", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});

//goblin

::mods_hookExactClass("items/weapons/greenskins/goblin_spear", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm;
	}
});



