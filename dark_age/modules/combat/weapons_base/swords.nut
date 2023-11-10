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

