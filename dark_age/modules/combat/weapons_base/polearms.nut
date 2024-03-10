::mods_hookExactClass("items/weapons/warfork", function (o){
	o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Spear | ::Const.Items.WeaponType.Polearm;
	}
});

::mods_hookExactClass("items/weapons/legend_swordstaff", function (o){
	o.post_create <- function()
	{
        this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Polearm;
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
        this.m.WeaponType = this.Const.Items.WeaponType.Sword | this.Const.Items.WeaponType.Spear | this.Const.Items.WeaponType.Polearm;
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

