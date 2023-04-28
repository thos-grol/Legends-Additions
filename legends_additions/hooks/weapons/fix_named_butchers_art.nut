::mods_hookExactClass("items/weapons/named/legend_named_butchers_cleaver", function (o)
{
    local create = o.create;
	o.create = function()
	{
		create();
		this.m.IconLarge = "weapons/melee/cleaver_02_named2.png";
		this.m.Icon = "weapons/melee/cleaver_02_named_70x702.png";
	}
});