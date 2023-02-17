//1. Modify Anatomist Background
::mods_hookExactClass("skills/backgrounds/anatomist_background", function (o)
{
	local create = o.create;
	o.create = function()
	{
		create();
		this.m.BackgroundDescription = "Part scientist and part surgeon, Anatomists are unaccustomed to battle but well served by steady hands. Anatomists can concoct sequence potions from the remains of monsters.";
		this.m.HiringCost = 6000;
		this.m.DailyCost = 25;
		this.m.Excluded.push("trait.greedy");

		this.m.PerkGroupMultipliers <- [
			[0.5, ::Const.Perks.LargeTree],
			[0.5, ::Const.Perks.SturdyTree],
			[0, ::Const.Perks.OrganisedTree],
			[6, ::Const.Perks.TalentedTree],
			[0, ::Const.Perks.MediumArmorTree],
			[3, ::Const.Perks.LightArmorTree],
			[1, ::Const.Perks.HeavyArmorTree],
			[0, ::Const.Perks.EntertainerClassTree],
			[3, ::Const.Perks.HealerClassTree],
			[0, ::Const.Perks.HoundmasterClassTree],
			[0, ::Const.Perks.BowTree],
			[0, ::Const.Perks.ThrowingTree],
			[0, ::Const.Perks.CrossbowTree],
			[0, ::Const.Perks.SlingTree],
			[0, ::Const.Perks.RangedTree]
		];

		this.m.PerkTreeDynamic = {
			Profession = [
				::Const.Perks.ApothecaryProfessionTree
			],
			Enemy = [
				::MSU.Class.WeightedContainer([
					[6, ::Const.Perks.DirewolfTree],
					[6, ::Const.Perks.GhoulTree],
					[3, ::Const.Perks.LindwurmTree],
					[6, ::Const.Perks.GoblinTree],
					[6, ::Const.Perks.OrcTree],
					[3, ::Const.Perks.UnholdTree],
					[3, ::Const.Perks.AlpTree],
					[3, ::Const.Perks.SchratTree],
					[3, ::Const.Perks.VampireTree]
				])
			]
		};
	}

	o.getBackgroundTooltip <- function()
	{
		local ret = [
			{
				id = 3,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "Has a chance (depending on the monster) to concoct sequence potions from all monsters killed in battle"
			}
		];
		return ret;
	}

	//Fixes bug where anatomist background overwrites background super method without making any changes??? Now you can see projected perk stats
	o.getTooltip = function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getContainer() != null)
		{
			ret.extend(this.getBackgroundTooltip());
			ret.extend(this.getAttributesTooltip());
		}

		return ret;
	}
});

//2. Modify Anatomist Origin
::mods_hookExactClass("scenarios/world/anatomists_scenario", function (o)
{
	//Remove how the scenario does loot drops and move the logic somewhere else.
	o.onActorKilled = function( _actor, _killer, _combatID ){}
	o.onBattleWon = function( _combatLoot ){}
	o.onCombatFinished = function(){return true;}
	o.onGetBackgroundTooltip = function( _background, _tooltip ){}

	local create = o.create;
	o.create = function()
	{
		create();
		this.m.Description = "[p=c][img]gfx/ui/events/event_181.png[/img][/p][p]Fueled by an unquenchable thirst for knowledge, the Anatomists have spent years dissecting the exotic and the alien. With social mores dogging their research, however, they\'ve decided to form a mercenary company to acquire new source of fresh specimens.\n\n[color=#bcad8c]Anatomists:[/color] Start with three elite anatomists and high funds.\n[color=#bcad8c]Advanced Research:[/color] Characters with the resilient perk can withstand mutations from up to two sequences.[/p]";
	}

	//Modify the characters here and replace the function
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
		// bros[0].getBackground().m.RawDescription = "{Captain? Is it alright if I call you captain? Ah, of course it is. What? No, we were not calling you by another name. Yers is a smooth costard, good sir, and we would not be of such derring-do to refer to you as a sellsword who is as ordinary as any of our coetaneous clodpolls, or state that we were in some sense importuning commerce by conducting business with a man of your particular skills. No sir, we would not. We are not children of perdition, sir.}";
		bros[0].getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
		bros[0].setPlaceInFormation(3);
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.Bravery] = 3;
		talents[::Const.Attributes.MeleeSkill] = 2;
		talents[::Const.Attributes.MeleeDefense] = 1;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Offhand));

		::LA.addPerk(bros[0], ::Const.Perks.PerkDefs.HoldOut, 2);
		bros[0].getSkills().add(::new("scripts/skills/traits/player_character_trait"));
		items.equip(::new("scripts/items/helmets/undertaker_hat"));
		items.equip(::new("scripts/items/armor/undertaker_apron"));

		// ::LA.addPerk(bros[0], ::Const.Perks.PerkDefs.LegendSpecCultHood, 1);
		// ::LA.addPerk(bros[0], ::Const.Perks.PerkDefs.SacrificialRitual, 2);
		// ::LA.addPerk(bros[0], ::Const.Perks.PerkDefs.LegendSpecCultArmor, 5);
		
		// items.equip(::new("scripts/items/weapons/legend_mystic_staff"));


		bros[1].setStartValuesEx([
			"anatomist_background"
		]);
		bros[1].setVeteranPerks(2);
		bros[1].getBackground().m.DailyCost = 0;
		// bros[1].getBackground().m.RawDescription = "{Despite others\' hesitancies, I\'ve no qualms calling you a javel, sir. You are, after all, a javel. A scapegrace. Some sellsword or another, yes? I think only a man who trucks cowardice would avoid calling you what you are. That someone disrespects your intelligence, thinking you yourself know not yourself. Even I see that in you accepting who you are, you are quite a good specimen. I mean, sellsword.}";
		bros[1].getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
		bros[1].setPlaceInFormation(4);
		bros[1].m.Talents = [];
		talents = bros[1].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.Hitpoints] = 2;
		talents[::Const.Attributes.MeleeDefense] = 2;
		talents[::Const.Attributes.MeleeSkill] = 1;
		items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Offhand));

		::LA.addPerk(bros[1], ::Const.Perks.PerkDefs.HoldOut, 2);
		bros[1].getSkills().add(::new("scripts/skills/traits/player_character_trait"));

		items.equip(::new("scripts/items/helmets/physician_mask"));
		items.equip(::new("scripts/items/armor/wanderers_coat"));
		items.equip(::new("scripts/items/weapons/dagger"));

		bros[2].setStartValuesEx([
			"anatomist_background"
		]);
		bros[2].setVeteranPerks(2);
		bros[2].getBackground().m.DailyCost = 0;
		// bros[2].getBackground().m.RawDescription = "{Though our quotidian dialogues are no doubt drollery, beneath the banausic surface I must admit I feel a touch of serotinous savagery lurking within you, coming to the fore as if my words be fire. Even our most desultory talks has me on edge, the way you stare at me with such hateful eyes. Well, know this, bounty hunter, I am no casuist, I speak in earnest. You are too fine a specimen-I mean captain to be lofting some sapskull\'s brickbats at. Understand?}";
		bros[2].getSprite("miniboss").setBrush("bust_miniboss_lone_wolf");
		bros[2].setPlaceInFormation(5);
		bros[2].m.Talents = [];
		talents = bros[2].getTalents();
		talents.resize(::Const.Attributes.COUNT, 0);
		talents[::Const.Attributes.MeleeSkill] = 2;
		talents[::Const.Attributes.MeleeDefense] = 3;
		talents[::Const.Attributes.Initiative] = 3;
		items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(::Const.ItemSlot.Offhand));

		::LA.addPerk(bros[2], ::Const.Perks.PerkDefs.HoldOut, 2);
		bros[2].getSkills().add(::new("scripts/skills/traits/player_character_trait"));

		items.equip(::new("scripts/items/helmets/masked_kettle_helmet"));
		items.equip(::new("scripts/items/armor/reinforced_leather_tunic"));
		items.equip(::new("scripts/items/weapons/militia_spear"));
		this.World.Assets.getStash().add(::new("scripts/items/supplies/smoked_ham_item"));
		this.World.Assets.getStash().add(::new("scripts/items/supplies/mead_item"));
	}

});

::mods_hookExactClass("skills/backgrounds/paladin_background", function (o)
{
	//Fixes bug where anatomist background overwrites background super method without making any changes??? Now you can see projected perk stats
	o.getTooltip = function()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (this.getContainer() != null)
		{
			ret.extend(this.getBackgroundTooltip());
			ret.extend(this.getAttributesTooltip());
		}

		return ret;
	}
});

