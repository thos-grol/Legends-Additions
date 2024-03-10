this.perk_legend_favoured_enemy_swordmaster <- this.inherit("scripts/skills/legend_favoured_enemy_skill", {
	m = {},
	function create()
	{
		this.legend_favoured_enemy_skill.create();
		this.m.ID = "perk.legend_favoured_enemy_swordmaster";
		this.m.Name = this.Const.Strings.PerkName.LegendFavouredEnemySwordmaster;
		this.m.Description = this.Const.Strings.PerkDescription.LegendFavouredEnemySwordmaster;
		this.m.Icon = "ui/perks/favoured_knight_01.png";
		this.m.ValidTypes = this.Const.LegendMod.FavoriteSwordmaster;
		this.m.NoRefund <- true;
	}

});

