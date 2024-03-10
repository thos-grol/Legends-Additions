::mods_hookExactClass("items/weapons/legend_voulge", function (o){
    o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Cleaver;
	}
});

::mods_hookExactClass("items/weapons/legend_military_voulge", function (o){
    o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Cleaver;
	}
});

::mods_hookExactClass("items/weapons/named/legend_named_voulge", function (o){
    o.post_create <- function()
	{
		this.m.WeaponType = ::Const.Items.WeaponType.Polearm | ::Const.Items.WeaponType.Cleaver;
	}
});
