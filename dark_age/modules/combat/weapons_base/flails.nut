::mods_hookExactClass("items/weapons/greenskins/orc_flail_2h", function (o){
    o.post_create <- function()
	{
        this.m.WeaponType = ::Const.Items.WeaponType.Flail | ::Const.Items.WeaponType.Cleaver;
	}

    o.onEquip = function()
	{
		this.weapon.onEquip();
        this.addSkill(this.new("scripts/skills/actives/pound_berserk_chain"));
		this.addSkill(this.new("scripts/skills/actives/thresh_berserk_chain"));
	}
});

::mods_hookExactClass("items/weapons/named/named_orc_flail_2h", function (o){
    o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Flail | ::Const.Items.WeaponType.Cleaver;
	}

    o.onEquip = function()
	{
		this.weapon.onEquip();
        this.addSkill(this.new("scripts/skills/actives/pound_berserk_chain"));
		this.addSkill(this.new("scripts/skills/actives/thresh_berserk_chain"));
	}
});
