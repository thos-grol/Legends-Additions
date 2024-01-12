::mods_hookExactClass("items/weapons/greenskins/orc_flail_2h", function (o){
    o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Flail | ::Const.Items.WeaponType.Cleaver;
	}
});

::mods_hookExactClass("items/weapons/named/named_orc_flail_2h", function (o){
    o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Flail | ::Const.Items.WeaponType.Cleaver;
	}
});
