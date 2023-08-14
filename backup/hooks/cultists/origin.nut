::mods_hookExactClass("scenarios/world/cultists_scenario", function(o) {
    o.onSpawnAssets = function()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 5; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.getSprite("socket").setBrush("bust_base_orcs");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.getSkills().add(this.new("scripts/skills/traits/cultist_fanatic_trait"));

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
			i = ++i;
			i = i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"legend_magister_background"
		]);
		bros[0].getBackground().m.RawDescription = "When %name% joined, the cultist warmly called you captain, saying \"tis a proper manner to pursue the path into the Black from whence we came\".";
		bros[0].getSkills().add(this.new("scripts/skills/perks/perk_rally_the_troops"));
		this.addScenarioPerk(bros[0].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[0].setPlaceInFormation(2);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/battle_whip"));
        bros[0].m.PerkPoints = 4;
		bros[0].m.LevelUps = 4;
		bros[0].m.Level = 5;


		bros[1].setStartValuesEx([
			"legend_husk_background"
		]);
		bros[1].getBackground().m.RawDescription = "%name% found you upon the road, stating with certainty you were a mercenary captain. You wore but ordinary cloth at that moment, but %name% said that by Davkul\'s darkness you had an aura of wanted Black about you.";
		this.addScenarioPerk(bros[1].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[1].setPlaceInFormation(3);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
        bros[1].m.PerkPoints = 4;
		bros[1].m.LevelUps = 4;
		bros[1].m.Level = 5;

		bros[2].setStartValuesEx([
			"cultist_background"
		]);
		bros[2].getBackground().m.RawDescription = "A quiet figure, %name% has shadows beneath the fingerprints, running like the brine beneath a pallid shore. When you exchanged a handshake, it was as though you could hear the hissing of your sanity.";
		this.addScenarioPerk(bros[2].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[2].setPlaceInFormation(4);
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"cultist_leather_hood"
			]
		]));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_wraps"
			]
		]));
        bros[2].m.PerkPoints = 4;
		bros[2].m.LevelUps = 4;
		bros[2].m.Level = 5;

		bros[3].setStartValuesEx([
			"cultist_background"
		]);
		bros[3].getBackground().m.RawDescription = "%name% banded with you outside a tavern. The first time you saw the cultist, there were scars running up %name%\'s arms and across veins that could not be survived. But each morning it appears as though the scars move, slowly creeping in one direction: toward the forehead.";
		this.addScenarioPerk(bros[3].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[3].setPlaceInFormation(5);
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.new("scripts/items/weapons/pickaxe"));
		items.equip(this.Const.World.Common.pickHelmet([
			[
				1,
				"cultist_hood"
			]
		]));
		items.equip(this.Const.World.Common.pickArmor([
			[
				1,
				"leather_wraps"
			]
		]));
        bros[3].m.PerkPoints = 4;
		bros[3].m.LevelUps = 4;
		bros[3].m.Level = 5;

		bros[4].setStartValuesEx([
			"legend_lurker_background"
		]);
		bros[4].getBackground().m.RawDescription = "%name% banded with you outside a tavern. The first time you saw the cultist, there were scars running up %name%\'s arms and across veins that could not be survived. But each morning it appears as though the scars move, slowly creeping in one direction: toward the forehead.";
		this.addScenarioPerk(bros[4].getBackground(), this.Const.Perks.PerkDefs.LegendTrueBeliever);
		bros[4].setPlaceInFormation(6);
        bros[4].m.PerkPoints = 4;
		bros[4].m.LevelUps = 4;
		bros[4].m.Level = 5;

		local items = bros[4].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/legend_sling"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money + 300;
	}
});
