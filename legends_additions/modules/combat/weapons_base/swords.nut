::mods_hookExactClass("items/weapons/oriental/saif", function (o){
    o.onEquip = function()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/gash_skill"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}
});

