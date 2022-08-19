this.getroottable().anatomists_expanded.hook_scenario <- function ()
{
	::mods_hookExactClass("skills/backgrounds/anatomist_background", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.BackgroundDescription += "\n\nAfter a battle, anatomists have a chance to concoct a potion for each monster killed. The chance increases with each anatomist.";
			this.m.HiringCost = 5000;
			this.m.DailyCost = 35;
			this.m.Excluded.push("trait.greedy");
		}
	});

	::mods_hookNewObject("skills/backgrounds/anatomist_background", function (o)
	{
		o.m.PerkGroupMultipliers <- [
			[0.5, this.Const.Perks.LargeTree],
			[0.5, this.Const.Perks.SturdyTree],
			[3, this.Const.Perks.TalentedTree],
			[10, this.Const.Perks.LightArmorTree],
			[0, this.Const.Perks.HeavyArmorTree],
			[0, this.Const.Perks.MediumArmorTree],
			[0, this.Const.Perks.EntertainerClassTree],
			[3, this.Const.Perks.HealerClassTree],
			[0, this.Const.Perks.HoundmasterClassTree],
			[0, this.Const.Perks.BowTree],
			[0.4, this.Const.Perks.CrossbowTree],
			[0, this.Const.Perks.SlingTree],
			[0, this.Const.Perks.RangedTree]
		];

		o.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ApothecaryProfessionTree
			],
			Enemy = [
				::MSU.Class.WeightedContainer([
					[3, ::Const.Perks.DirewolfTree],
					[8, ::Const.Perks.GhoulTree],
					[3, ::Const.Perks.LindwurmTree],
					[8, ::Const.Perks.UnholdTree],
					[3, ::Const.Perks.AlpTree],
					[3, ::Const.Perks.SchratTree],
					[5, ::Const.Perks.VampireTree]
				])
			]
		};
	});
	
	::mods_hookExactClass("scenarios/world/anatomists_scenario", function (o)
	{
		//Remove how the scenario does loot drops and move the logic somewhere else.
		local onActorKilled = ::mods_getMember(o, "onActorKilled");
		o.onActorKilled = function( _actor, _killer, _combatID )
		{
		}
		
		local onBattleWon = ::mods_getMember(o, "onBattleWon");
		o.onBattleWon = function( _combatLoot )
		{
		}
		
		local onCombatFinished = ::mods_getMember(o, "onCombatFinished");
		o.onCombatFinished = function()
		{
			return true;
		}
		
		local onGetBackgroundTooltip = ::mods_getMember(o, "onGetBackgroundTooltip");
		o.onGetBackgroundTooltip = function( _background, _tooltip )
		{
		}

		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.Description = "[p=c][img]gfx/ui/events/event_181.png[/img][/p][p]Fueled by an unquenchable thirst for knowledge, the Anatomists have spent years dissecting the exotic and the alien. With social mores dogging their research, however, they\'ve decided to form a mercenary company to acquire new source of fresh specimens.\n\n[color=#bcad8c]Anatomists:[/color] Start with three elite anatomists and high funds. Doubles the anatomist drop chance for potions.\n[color=#bcad8c]Advanced Research:[/color] Characters with the resilient perk can withstand mutations from up to two sequences.[/p]";
		}

		//Modify the characters here and replace the function
		local onSpawnAssets = ::mods_getMember(o, "onSpawnAssets");
		o.onSpawnAssets = function()
		{
			local roster = this.World.getPlayerRoster();
			local names = [];

			for( local i = 0; i < 3; i = i )
			{
				local bro;
				bro = roster.create("scripts/entity/tactical/player");
				bro.m.HireTime = this.Time.getVirtualTimeF();
				i = ++i;
			}

			local bros = roster.getAll();
			bros[0].setStartValuesEx([
				"anatomist_background"
			]);
			bros[0].setVeteranPerks(2);
			bros[0].getBackground().m.DailyCost = 0;
			bros[0].getBackground().m.RawDescription = "{Captain? Is it alright if I call you captain? Ah, of course it is. What? No, we were not calling you by another name. Yers is a smooth costard, good sir, and we would not be of such derring-do to refer to you as a sellsword who is as ordinary as any of our coetaneous clodpolls, or state that we were in some sense importuning commerce by conducting business with a man of your particular skills. No sir, we would not. We are not children of perdition, sir.}";
			bros[0].getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
			bros[0].setPlaceInFormation(3);
			bros[0].m.Talents = [];
			local talents = bros[0].getTalents();
			talents.resize(this.Const.Attributes.COUNT, 0);
			talents[this.Const.Attributes.Bravery] = 3;
			talents[this.Const.Attributes.MeleeSkill] = 2;
			talents[this.Const.Attributes.RangedSkill] = 2;
			local items = bros[0].getItems();
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));

			bros[0].getBackground().addPerk(this.Const.Perks.PerkDefs.HoldOut, 2, false);
			bros[0].getSkills().add(this.new("scripts/skills/perks/perk_hold_out"));
			bros[0].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));

			items.equip(this.new("scripts/items/helmets/undertaker_hat"));
			items.equip(this.new("scripts/items/armor/undertaker_apron"));
			bros[1].setStartValuesEx([
				"anatomist_background"
			]);
			bros[1].setVeteranPerks(2);
			bros[1].getBackground().m.DailyCost = 0;
			bros[1].getBackground().m.RawDescription = "{Despite others\' hesitancies, I\'ve no qualms calling you a javel, sir. You are, after all, a javel. A scapegrace. Some sellsword or another, yes? I think only a man who trucks cowardice would avoid calling you what you are. That someone disrespects your intelligence, thinking you yourself know not yourself. Even I see that in you accepting who you are, you are quite a good specimen. I mean, sellsword.}";
			bros[1].getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
			bros[1].setPlaceInFormation(4);
			bros[1].m.Talents = [];
			talents = bros[1].getTalents();
			talents.resize(this.Const.Attributes.COUNT, 0);
			talents[this.Const.Attributes.Hitpoints] = 2;
			talents[this.Const.Attributes.MeleeDefense] = 2;
			talents[this.Const.Attributes.MeleeSkill] = 1;
			items = bros[1].getItems();
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));

			bros[1].getBackground().addPerk(this.Const.Perks.PerkDefs.HoldOut, 2, false);
			bros[1].getSkills().add(this.new("scripts/skills/perks/perk_hold_out"));
			bros[1].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));

			items.equip(this.new("scripts/items/helmets/physician_mask"));
			items.equip(this.new("scripts/items/armor/wanderers_coat"));
			items.equip(this.new("scripts/items/weapons/dagger"));
			bros[2].setStartValuesEx([
				"anatomist_background"
			]);
			bros[2].setVeteranPerks(2);
			bros[2].getBackground().m.DailyCost = 0;
			bros[2].getBackground().m.RawDescription = "{Though our quotidian dialogues are no doubt drollery, beneath the banausic surface I must admit I feel a touch of serotinous savagery lurking within you, coming to the fore as if my words be fire. Even our most desultory talks has me on edge, the way you stare at me with such hateful eyes. Well, know this, bounty hunter, I am no casuist, I speak in earnest. You are too fine a specimen-I mean captain to be lofting some sapskull\'s brickbats at. Understand?}";
			bros[2].getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
			bros[2].setPlaceInFormation(5);
			bros[2].m.Talents = [];
			talents = bros[2].getTalents();
			talents.resize(this.Const.Attributes.COUNT, 0);
			talents[this.Const.Attributes.MeleeSkill] = 2;
			talents[this.Const.Attributes.MeleeDefense] = 3;
			talents[this.Const.Attributes.Initiative] = 3;
			items = bros[2].getItems();
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
			items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));

			bros[2].getBackground().addPerk(this.Const.Perks.PerkDefs.HoldOut, 2, false);
			bros[2].getSkills().add(this.new("scripts/skills/perks/perk_hold_out"));
			bros[2].getSkills().add(this.new("scripts/skills/traits/player_character_trait"));

			items.equip(this.new("scripts/items/helmets/masked_kettle_helmet"));
			items.equip(this.new("scripts/items/armor/reinforced_leather_tunic"));
			items.equip(this.new("scripts/items/weapons/militia_spear"));
			this.World.Assets.getStash().add(this.new("scripts/items/supplies/smoked_ham_item"));
			this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
			// this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_beasts_item"));
			// this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_greenskins_item"));
			// this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_undead_item"));
			// this.World.Assets.getStash().add(this.new("scripts/items/misc/anatomist/research_notes_legendary_item"));

			this.World.Statistics.getFlags().set("isNecromancerPotionAcquired", false);
			this.World.Statistics.getFlags().set("isWiedergangerPotionAcquired", false);
			this.World.Statistics.getFlags().set("isFallenHeroPotionAcquired", false);
			this.World.Statistics.getFlags().set("isGeistPotionAcquired", false);
			this.World.Statistics.getFlags().set("isRachegeistPotionAcquired", false);
			this.World.Statistics.getFlags().set("isSkeletonWarriorPotionAcquired", false);
			this.World.Statistics.getFlags().set("isHonorGuardPotionAcquired", false);
			this.World.Statistics.getFlags().set("isAncientPriestPotionAcquired", false);
			this.World.Statistics.getFlags().set("isNecrosavantPotionAcquired", false);
			this.World.Statistics.getFlags().set("isLorekeeperPotionAcquired", false);
			this.World.Statistics.getFlags().set("isOrcYoungPotionAcquired", false);
			this.World.Statistics.getFlags().set("isOrcWarriorPotionAcquired", false);
			this.World.Statistics.getFlags().set("isOrcBerserkerPotionAcquired", false);
			this.World.Statistics.getFlags().set("isOrcWarlordPotionAcquired", false);
			this.World.Statistics.getFlags().set("isGoblinGruntPotionAcquired", false);
			this.World.Statistics.getFlags().set("isGoblinOverseerPotionAcquired", false);
			this.World.Statistics.getFlags().set("isGoblinShamanPotionAcquired", false);
			this.World.Statistics.getFlags().set("isDirewolfPotionAcquired", false);
			this.World.Statistics.getFlags().set("isLindwurmPotionAcquired", false);
			this.World.Statistics.getFlags().set("isUnholdPotionAcquired", false);
			this.World.Statistics.getFlags().set("isWebknechtPotionAcquired", false);
			this.World.Statistics.getFlags().set("isNachzehrerPotionAcquired", false);
			this.World.Statistics.getFlags().set("isAlpPotionAcquired", false);
			this.World.Statistics.getFlags().set("isHexePotionAcquired", false);
			this.World.Statistics.getFlags().set("isSchratPotionAcquired", false);
			this.World.Statistics.getFlags().set("isSerpentPotionAcquired", false);
			this.World.Statistics.getFlags().set("isKrakenPotionAcquired", false);
			this.World.Statistics.getFlags().set("isIjirokPotionAcquired", false);
			this.World.Statistics.getFlags().set("isIfritPotionAcquired", false);
			this.World.Statistics.getFlags().set("isHyenaPotionAcquired", false);
		}
		
	});

	// comment out anatomists being unconfident
	// update ancient priest potion effect
	::mods_hookExactClass("entity/tactical/player", function(o)
	{
		local setMoraleState = ::mods_getMember(o, "setMoraleState");
		o.setMoraleState = function( _m )
		{
			if (_m == this.Const.MoraleState.Confident && this.m.Skills.hasSkill("trait.insecure"))
			{
				return;
			}

			if (this.m.Skills.hasSkill("effects.ancient_priest_potion") && _m < 3)
			{
				return;
			}

			if (_m == this.Const.MoraleState.Fleeing && this.m.Skills.hasSkill("trait.oath_of_valor"))
			{
				return;
			}

			if (_m == this.Const.MoraleState.Confident && this.getMoraleState() != this.Const.MoraleState.Confident && this.isPlacedOnMap() && this.Time.getRound() >= 1 && ("State" in this.World) && this.World.State != null && this.World.Ambitions.hasActiveAmbition() && this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_camaraderie")
			{
				this.World.Statistics.getFlags().increment("OathtakersBrosConfident");
			}

			this.actor.setMoraleState(_m);
		}

		local checkMorale = ::mods_getMember(o, "checkMorale");
		o.checkMorale = function( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
		{
			if (_change < 0 && this.m.Skills.hasSkill("effects.ancient_priest_potion"))
			{
				this.logInfo("Reached");
				if (this.m.MoraleState < 3)
				{
					this.actor.setMoraleState(3);
				}
				return false;
			}
			
			if (_change > 0 && this.m.MoraleState == this.Const.MoraleState.Steady && this.m.Skills.hasSkill("trait.insecure"))
			{
				return false;
			}

			if (_change < 0 && this.m.MoraleState == this.Const.MoraleState.Breaking && this.m.Skills.hasSkill("trait.oath_of_valor"))
			{
				return false;
			}

			if (_change > 0 && this.m.Skills.hasSkill("trait.optimist"))
			{
				_difficulty = _difficulty + 5;
			}
			else if (_change < 0 && this.m.Skills.hasSkill("trait.pessimist"))
			{
				_difficulty = _difficulty - 5;
			}
			else if (this.m.Skills.hasSkill("trait.irrational"))
			{
				_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 10 : -10);
			}
			else if (this.m.Skills.hasSkill("trait.mad"))
			{
				_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 15 : -15);
			}

			if (_change < 0 && _type == this.Const.MoraleCheckType.MentalAttack && this.m.Skills.hasSkill("trait.superstitious"))
			{
				_difficulty = _difficulty - 10;
			}

			return this.actor.checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
		}
	});

	::mods_hookExactClass("entity/world/attached_location/herbalists_grove_location", function (o)
	{
		local onUpdateDraftList = ::mods_getMember(o, "onUpdateDraftList");
		o.onUpdateDraftList = function( _list, _gender = null )
		{
			onUpdateDraftList(_list, _gender);
			_list.push("anatomist_background");
		}
	});

	::mods_hookExactClass("entity/world/attached_location/pig_farm_location", function (o)
	{
		
		local onUpdateDraftList = ::mods_getMember(o, "onUpdateDraftList");
		o.onUpdateDraftList = function( _list, _gender = null )
		{
			onUpdateDraftList(_list, _gender);
			_list.push("anatomist_background");
		}
	});

	::mods_hookExactClass("entity/world/settlements/buildings/taxidermist_building", function (o)
	{
		
		local onUpdateDraftList = ::mods_getMember(o, "onUpdateDraftList");
		o.onUpdateDraftList = function( _list, _gender = null )
		{
			onUpdateDraftList(_list, _gender);
			_list.push("anatomist_background");
		}
	});

	this.getroottable().anatomists_expanded.addAnatomists <- function (list_of_lists)
	{
		foreach (lst in list_of_lists)
		{
			lst.push("anatomist_background");
		}

	}

	::mods_hookExactClass("entity/world/settlements/legends_coast_fort", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.getroottable().anatomists_expanded.addAnatomists(this.m.DraftLists);
		}
	});

	::mods_hookExactClass("entity/world/settlements/legends_forest_fort", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.getroottable().anatomists_expanded.addAnatomists(this.m.DraftLists);
		}
	});

	::mods_hookExactClass("entity/world/settlements/legends_snow_fort", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.getroottable().anatomists_expanded.addAnatomists(this.m.DraftLists);
		}
	});

	::mods_hookExactClass("entity/world/settlements/legends_swamp_fort", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.getroottable().anatomists_expanded.addAnatomists(this.m.DraftLists);
		}
	});

	::mods_hookExactClass("entity/world/settlements/large_coast_fort", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.DraftList.push("anatomist_background");
			this.m.DraftList.push("legend_inventor_background");
		}
	});

	::mods_hookExactClass("entity/world/settlements/large_forest_fort", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.DraftList.push("anatomist_background");
		}
	});

	::mods_hookExactClass("entity/world/settlements/large_snow_fort", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.DraftList.push("anatomist_background");
		}
	});
};