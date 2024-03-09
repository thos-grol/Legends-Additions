this.raiders_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.raiders";
		this.m.Name = "Northern Raiders";
		this.m.Description = "[p=c][img]gfx/ui/events/event_135.png[/img][/p][p]For all your adult life you have been raiding and pillaging in these lands. But with the local peasantry poor as mice, you may want to finally expand into the profitable field of mercenary work - that is, if your potential employers are willing to forgive your past transgressions.\n[color=#bcad8c]Warband:[/color] Start with three experienced barbarians, and increased chance of finding [color=#c90000]bloodthirsty brutes, barbarians, killers and assassins[/color].\n[color=#bcad8c]Pillagers:[/color] You have a higher chance to get any items from slain enemies as loot[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 180;
		this.m.StartingBusinessReputation = -50;
		this.m.IsFixedLook = true;
		this.m.StartingRosterTier = ::Const.Roster.getTierForSize(27);
		this.m.RosterTierMax = ::Const.Roster.getTierForSize(27);
	}

	function isValid()
	{
		return ::Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();

		for( local i = 0; i < 4; i = i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			i = ++i;
			i = i;
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"barbarian_scenario_background"
		]);
		bros[0].getBackground().m.RawDescription = "A sturdy warrior, %name% has been through many campaigns of raiding and pillaging. Although a man of few words, the raider is an absolutely vicious specimen in battle. Even for a raider, what he does to defeated villagers irks many. It is likely he came with you to satiate his more sadistic lusts.";
		bros[0].improveMood(1.0, "Had a successful raid");
		bros[0].setPlaceInFormation(3);
		bros[0].setVeteranPerks(2);
		bros[0].m.PerkPoints = 7;
		bros[0].m.LevelUps = 7;
		bros[0].m.Level = 8;
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.MeleeSkill] = 3;
		talents[::Const.Attributes.Initiative] = 3;
		talents[::Const.Attributes.MeleeDefense] = 3;
		bros[0].getFlags().set("Lucky", 3);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));
		local armor = this.new("scripts/items/legend_armor/cloth/legend_sackcloth");
		local plate = this.new("scripts/items/legend_armor/plate/legend_reinforced_animal_hide_armor");
		armor.setUpgrade(plate);
		items.equip(armor);
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/bear_headpiece"
			]
		]));
		bros[1].setStartValuesEx([
			"barbarian_scenario_background"
		]);
		bros[1].getBackground().m.RawDescription = "%name% was a boy when taken from a southern village and raised amongst the barbarians of the wastes. While he learned the language and culture, he never fit in and was a constant victim of cruel jokes and games. You are not sure if he has followed you to return home or to get away from his northern \'family\'.";
		bros[1].improveMood(1.0, "Had a successful raid");
		bros[1].setPlaceInFormation(4);
		bros[1].setVeteranPerks(2);
		bros[1].m.PerkPoints = 7;
		bros[1].m.LevelUps = 7;
		bros[1].m.Level = 8;
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.MeleeSkill] = 3;
		talents[::Const.Attributes.Initiative] = 3;
		talents[::Const.Attributes.MeleeDefense] = 3;
		bros[1].getFlags().set("Lucky", 3);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));
		local armor = this.new("scripts/items/legend_armor/cloth/legend_sackcloth");
		local plate = this.new("scripts/items/legend_armor/plate/legend_scrap_metal_armor");
		armor.setUpgrade(plate);
		items.equip(armor);
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_headband"
			]
		]));
		bros[2].setStartValuesEx([
			"barbarian_scenario_background"
		]);
		bros[2].getBackground().m.RawDescription = "Barbarian raiders often take from lands foreign to them. Most see their raids as a matter of material and women, but occasionally they will enslave formidable boys with great potential. %name%, a northerner, was such a child and he was raised to be a raider himself. Half his life was with his primitive clan, and the other half with those who took him. This has made him as hardy and brutish a warrior as one can get.";
		bros[2].improveMood(1.0, "Had a successful raid");
		bros[2].setPlaceInFormation(5);
		bros[2].setVeteranPerks(2);
		bros[2].m.PerkPoints = 7;
		bros[2].m.LevelUps = 7;
		bros[2].m.Level = 8;
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.MeleeSkill] = 3;
		talents[::Const.Attributes.MeleeDefense] = 3;
		talents[::Const.Attributes.Initiative] = 3;
		bros[2].getFlags().set("Lucky", 3);
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));
		local armor = this.new("scripts/items/legend_armor/cloth/legend_sackcloth_patched");
		local plate = this.new("scripts/items/legend_armor/plate/legend_hide_and_bone_armor");
		armor.setUpgrade(plate);
		items.equip(armor);
		items.equip(::Const.World.Common.pickHelmet([
			[
				1,
				"barbarians/leather_helmet"
			]
		]));

		bros[3].setStartValuesEx([
			"monk_background"
		]);
		bros[3].getBackground().m.RawDescription = "The man who put you on the path, you believe %name% may serve some greater role to your attaining immense treasures. You have seen northern gimps and one-armed men who would best him in combat, but his knowledge and intelligence may be sharper blades in good time.";
		bros[3].improveMood(2.0, "Thinks he managed to convince you to give up raiding and pillaging");
		bros[3].setPlaceInFormation(13);
		bros[3].setVeteranPerks(2);
		bros[3].m.PerkPoints = 2;
		bros[3].m.LevelUps = 2;
		bros[3].m.Level = 3;
		bros[3].m.Talents = [];

		local talents = bros[3].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.RangedSkill] = 3;
		talents[::Const.Attributes.Hitpoints] = 3;
		talents[::Const.Attributes.Initiative] = 3;
		local bright = ::new("scripts/skills/traits/bright_trait");
		bros[3].getFlags().set("Lucky", 3);
		bros[3].getSkills().add(bright);
		bros[3].getBackground().addPerkGroup(::Const.Perks.IntelligentTree.Tree);
		bros[3].getBackground().addPerkGroup(::Const.Perks.LargeTree.Tree);

		// //FIXME: PLACEHOLDER remove test perks

		// ::Z.Perks.add(bros[3], ::Const.Perks.PerkDefs.WinterMage, 0);
		// ::Z.Perks.add(bros[3], ::Const.Perks.PerkDefs.MeditationOmenOfDecay, 0);
		// ::Z.Perks.add(bros[3], ::Const.Perks.PerkDefs.SpellReanimate, 0);
		// ::Z.Perks.add(bros[3], ::Const.Perks.PerkDefs.SpellMarkofDecay, 0);
		// ::Z.Perks.add(bros[3], ::Const.Perks.PerkDefs.ResearchRottenOffering, 0);
		// ::Z.Perks.add(bros[3], ::Const.Perks.PerkDefs.ResearchMiasmaBody, 0);
		// ::Z.Perks.add(bros[3], ::Const.Perks.PerkDefs.SpellCorpseExplosion, 0);
		// ::Z.Perks.add(bros[3], ::Const.Perks.PerkDefs.TrialByFire, 0);

		this.World.Assets.addBusinessReputation(this.m.StartingBusinessReputation);
		this.World.Assets.addMoralReputation(-30.0);

		this.World.Assets.getStash().add(this.new("scripts/items/trade/furs_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/furs_item"));

		this.World.Assets.m.Money = 100;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo / 2;
	}

	function onSpawnPlayer()
	{
		local randomVillage;
		local northernmostY = 0;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = i )
		{
			local v = this.World.EntityManager.getSettlements()[i];

			if (v.getTile().SquareCoords.Y > northernmostY && !v.isMilitary() && !v.isIsolatedFromRoads() && v.getSize() <= 2)
			{
				northernmostY = v.getTile().SquareCoords.Y;
				randomVillage = v;
			}

			i = ++i;
			i = i;
		}

		randomVillage.setLastSpawnTimeToNow();
		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = ::Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.X - 2), ::Math.min(::Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 2));
			local y = ::Math.rand(::Math.max(2, randomVillageTile.SquareCoords.Y - 2), ::Math.min(::Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 2));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == ::Const.World.TerrainType.Ocean || tile.Type == ::Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		local attachedLocations = randomVillage.getAttachedLocations();
		local closest;
		local dist = 99999;

		foreach( a in attachedLocations )
		{
			if (a.getTile().getDistanceTo(randomVillageTile) < dist)
			{
				dist = a.getTile().getDistanceTo(randomVillageTile);
				closest = a;
			}
		}

		if (closest != null)
		{
			closest.setActive(false);
			closest.spawnFireAndSmoke();
		}

		local s = this.new("scripts/entity/world/settlements/situations/raided_situation");
		s.setValidForDays(5);
		randomVillage.addSituation(s);
		local nobles = this.World.FactionManager.getFactionsOfType(::Const.FactionType.NobleHouse);
		local houses = [];

		foreach( n in nobles )
		{
			local closest;
			local dist = 9999;

			foreach( s in n.getSettlements() )
			{
				local d = s.getTile().getDistanceTo(randomVillageTile);

				if (d < dist)
				{
					dist = d;
					closest = s;
				}
			}

			houses.push({
				Faction = n,
				Dist = dist
			});
		}

		houses.sort(function ( _a, _b )
		{
			if (_a.Dist > _b.Dist)
			{
				return 1;
			}
			else if (_a.Dist < _b.Dist)
			{
				return -1;
			}

			return 0;
		});

		for( local i = 0; i < 1; i = i )
		{
			houses[i].Faction.addPlayerRelation(-200.0, "You are considered outlaws and barbarians");
			i = ++i;
			i = i;
		}

		houses[1].Faction.addPlayerRelation(18.0);
		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y /2);
		this.World.Assets.updateLook(5);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/barbarians_02.ogg"
			], ::Const.Music.CrossFadeTime);
			this.World.Events.fire("event.raiders_scenario_intro");
		}, null);
	}

	function isDroppedAsLoot( _item )
	{
		return ::Math.rand(1, 100) <= 15;
	}

	function onHiredByScenario( bro )
	{
		if (!bro.getBackground().isBackgroundType(::Const.BackgroundType.Outlaw))
		{
			bro.worsenMood(0.5, "Is uncomfortable with joining raiders");
		}
		else
		{
			bro.improveMood(1.5, "Is excited at becoming a raider");
		}
	}

	function onUpdateHiringRoster( _roster, _settlement )
	{
		// this.addBroToRoster(_roster, "thief_background", 5);
		// this.addBroToRoster(_roster, "killer_on_the_run_background", 5);

		// this.addBroToRoster(_roster, "barbarian_background", 10);
		// this.addBroToRoster(_roster, "assassin_background", 20);
	}

	function onGenerateBro( bro )
	{
		if (!bro.getBackground().isBackgroundType(::Const.BackgroundType.Outlaw))
		{
			bro.m.HiringCost = ::Math.floor(bro.m.HiringCost * 1.5);
			bro.getBaseProperties().DailyWageMult *= 1.5;
			bro.getSkills().update();
			bro.worsenMood(0.5, "Is uncomfortable with joining raiders");
		}
		else
		{
			bro.m.HiringCost = ::Math.floor(bro.m.HiringCost * 0.9);
			bro.getBaseProperties().DailyWageMult *= 0.9;
			bro.getSkills().update();
			bro.improveMood(1.5, "Is excited at becoming a raider");
			local r;
			r = ::Math.rand(0, 9);

			if (r == 0)
			{
				bro.getSkills().add(this.new("scripts/skills/traits/bloodthirsty_trait"));
			}

			if (r == 1)
			{
				bro.getSkills().add(this.new("scripts/skills/traits/deathwish_trait"));
			}

			if (r == 2)
			{
				bro.getSkills().add(this.new("scripts/skills/traits/drunkard_trait"));
			}

			if (r == 3)
			{
				bro.getSkills().add(this.new("scripts/skills/traits/cocky_trait"));
			}

			if (r == 4)
			{
				bro.getSkills().add(this.new("scripts/skills/traits/brute_trait"));
			}
		}
	}

});

