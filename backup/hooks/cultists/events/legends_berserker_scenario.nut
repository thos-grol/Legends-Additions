::mods_hookExactClass("scenarios/world/legends_berserker_scenario", function (o)
{
	o.onSpawnAssets = function()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 1; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			i = ++i;
			i = i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_berserker_commander_background"
		]);
		bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));
		this.addScenarioPerk(bros[0].getBackground(), ::Const.Perks.PerkDefs.Berserk);
		bros[0].getFlags().set("IsPlayerCharacter", true);
		bros[0].setVeteranPerks(2);
		local talents = bros[0].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.Bravery] = 3;
		talents[::Const.Attributes.MeleeSkill] = 3;
		talents[::Const.Attributes.MeleeDefense] = 3;
		this.World.Assets.m.Money = this.World.Assets.m.Money;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo;
	}

});