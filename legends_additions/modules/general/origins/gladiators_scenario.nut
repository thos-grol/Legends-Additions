::mods_hookExactClass("scenarios/world/deserters_scenario", function(o) { 
    o.onSpawnAssets = function()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 3; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.setStartValuesEx([
				"gladiator_origin_background"
			]);
			bro.getSkills().removeByID("trait.survivor");
			bro.getSkills().removeByID("trait.greedy");
			bro.getSkills().removeByID("trait.loyal");
			bro.getSkills().removeByID("trait.disloyal");
			bro.getSkills().add(this.new("scripts/skills/traits/arena_champion_trait"));
			bro.getFlags().set("ArenaFightsWon", 25);
			bro.getFlags().set("ArenaFights", 25);
			bro.setPlaceInFormation(3 + i);
			bro.getFlags().set("IsPlayerCharacter", true);
			bro.getSprite("miniboss").setBrush("bust_miniboss_gladiators");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.m.PerkPoints = 6;
			bro.m.LevelUps = 6;
			bro.m.Level = 7;
			bro.m.Talents = [];
			bro.m.Attributes = [];
			bro.setVeteranPerks(2);
            bro.m.HiringCost = 0;
		    bro.getBaseProperties().DailyWage = 0;
			i = ++i;
		}

		local bros = roster.getAll();
		local a;
		local u;
		bros[0].setTitle("the Lion");
		bros[0].getSkills().add(this.new("scripts/skills/traits/glorious_resolve_trait"));
		bros[0].getTalents().resize(this.Const.Attributes.COUNT, 0);
		bros[0].getTalents()[this.Const.Attributes.MeleeDefense] = 2;
		bros[0].getTalents()[this.Const.Attributes.Fatigue] = 2;
		bros[0].getTalents()[this.Const.Attributes.MeleeSkill] = 3;
		bros[0].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		a = this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/gladiator_harness"
			]
		]);
		a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		bros[0].getItems().equip(a);
		a = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/gladiator_helmet",
				13
			]
		]);
		bros[0].getItems().equip(a);
		bros[0].getItems().equip(this.new("scripts/items/weapons/scimitar"));
		bros[0].getItems().equip(this.new("scripts/items/tools/throwing_net"));
		bros[0].improveMood(0.75, "Eager to prove himself outside the arena");
		bros[0].setVeteranPerks(2);
		bros[1].setTitle("the Bear");
		bros[1].getSkills().add(this.new("scripts/skills/traits/glorious_endurance_trait"));
		bros[1].getTalents().resize(this.Const.Attributes.COUNT, 0);
		bros[1].getTalents()[this.Const.Attributes.Hitpoints] = 3;
		bros[1].getTalents()[this.Const.Attributes.Fatigue] = 2;
		bros[1].getTalents()[this.Const.Attributes.Bravery] = 2;
		bros[1].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		a = this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/gladiator_harness"
			]
		]);
		a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_heavy_gladiator_upgrade"));
		bros[1].getItems().equip(a);
		a = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/gladiator_helmet",
				15
			]
		]);
		bros[1].getItems().equip(a);
		bros[1].getItems().equip(this.new("scripts/items/weapons/oriental/heavy_southern_mace"));
		bros[1].getItems().equip(this.new("scripts/items/shields/oriental/metal_round_shield"));
		bros[1].improveMood(0.75, "Eager to prove himself outside the arena");
		bros[1].setVeteranPerks(2);
		bros[2].setTitle("the Viper");
		bros[2].getSkills().add(this.new("scripts/skills/traits/glorious_quickness_trait"));
		bros[2].getTalents().resize(this.Const.Attributes.COUNT, 0);
		bros[2].getTalents()[this.Const.Attributes.MeleeDefense] = 2;
		bros[2].getTalents()[this.Const.Attributes.Initiative] = 3;
		bros[2].getTalents()[this.Const.Attributes.MeleeSkill] = 2;
		bros[2].fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
		a = this.Const.World.Common.pickArmor([
			[
				1,
				"oriental/gladiator_harness"
			]
		]);
		a.setUpgrade(this.new("scripts/items/legend_armor/armor_upgrades/legend_light_gladiator_upgrade"));
		bros[2].getItems().equip(a);
		a = this.Const.World.Common.pickHelmet([
			[
				1,
				"oriental/gladiator_helmet",
				14
			]
		]);
		bros[2].getItems().equip(a);
		bros[2].getItems().equip(this.new("scripts/items/weapons/oriental/qatal_dagger"));
		bros[2].getItems().equip(this.new("scripts/items/tools/throwing_net"));
		bros[2].improveMood(0.75, "Eager to prove himself outside the arena");
		bros[2].setVeteranPerks(2);
		bros[0].getBackground().m.RawDescription = "{%fullname% thinks muscles make for glory. Wrong. Captain, it is I, " + bros[2].getName() + ", who commands the ladies of this realm. Need not ask me how. Behold! Look at it! Look at the size of it! Yeah. That\'s what I thought. Fools, train all you want, you can\'t have this!}";
		bros[0].getBackground().buildDescription(true);
		bros[1].getBackground().m.RawDescription = "{%fullname% is not the best warrior here, let\'s be clear. Captain, look at my muscles, is it not I, " + bros[0].getName() + ", who commands the greatest reward of life: the fear of one\'s own enemies! Look, if I lather a little and catch the light, the muscles gleam. Would it not be that the heavens were mistakened for above, when all the women say they find them right here, particularly here, upon my glorious pecs?}";
		bros[1].getBackground().buildDescription(true);
		bros[2].getBackground().m.RawDescription = "{Why are you looking at %fullname%? Captain, it is I, " + bros[1].getName() + ", who is your greatest gladiator. I am the one who swept the legs of a lindwurm and choked it out with its own tail! What you bastards say? You call that a tall tale? Pah! \'Tis a horizontal lizard at best.}";
		bros[2].getBackground().buildDescription(true);
		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() - 9);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/dried_lamb_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		this.World.Assets.m.Money = 200;
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts / 2;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine / 2;
		this.World.Assets.m.Ammo = 0;
	}
});