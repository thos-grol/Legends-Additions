::mods_hookExactClass("skills/legend_favoured_enemy_skill", function(o)
{

	o.onUpdate = function( _properties )
	{
		//if perk id hasn't been added yet, and you have more than 50 kills of that favored enemy,
		if (!this.getContainer().getActor().getFlags().has(this.m.ID) && this.getTotalKillStats().Kills >= 50)
		{
			this.logInfo("Adding perk point for flag: " + this.m.ID);
			this.getContainer().getActor().getFlags().add(this.m.ID);
			this.getContainer().getActor().m.PerkPoints += 1;
		}

		if (this.m.BraveryMult == 1.0) return;
		if (!("Entities" in this.Tactical)) return;
		if (this.Tactical.Entities == null) return;


		local actors = this.Tactical.Entities.getAllInstancesAsArray();

		foreach( a in actors )
		{
			foreach( vt in this.m.ValidTypes )
			{
				if (a.getType() == vt)
				{
					_properties.BraveryMult *= this.m.BraveryMult;
					return;
				}
			}
		}
	}

	o.getTooltip = function()
	{
		local stats = this.getTotalKillStats();
		local resp = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + stats.HitChance + "%[/color] Melee Skill due to being a favored enemy"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + stats.HitChance + "%[/color] Range Skill due to being a favored enemy"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/damage_dealt.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + ::Math.floor((stats.HitMult - 1.0) * 100.0) + "%[/color] Max Damage due to being a favored enemy"
			}
		];

		if (this.m.BraveryMult > 1)
		{
			resp.push({
				id = 15,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + ::Math.floor((this.m.BraveryMult - 1.0) * 100.0) + "%[/color] Resolve due to being a favored enemy"
			});
		}

		resp.push({
			id = 15,
			type = "hint",
			icon = "ui/icons/special.png",
			text = stats.Kills + " favored enemy kills"
		});

		if (!this.getContainer().getActor().getFlags().has(this.m.ID))
		{
			resp.push({
				id = 15,
				type = "hint",
				icon = "ui/icons/special.png",
				text = "When you kill 50 of these favored enemies, refund the point spent on this perk."
			});
		}
		return resp;
	}

});


::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul = "Studying these monstrosities has given you insights into the strengths and weaknesses of the pallid necrophilic flesh devourers.  Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting nachzehrers. Additionally, this bonus increases the more Nachzehrers you kill. The bonus depends on how powerful the Nachzehrer is, between [color=" + ::Const.UI.Color.PositiveValue + "]+1%[/color] per Nachzherer, and [color=" + ::Const.UI.Color.PositiveValue + "]+1.5%[/color] per Skin Ghoul you kill. Taking this perk unlocks an extremely difficult legendary contract to hunt elite nachzehrers, also known as Skin Ghouls. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyGhoul].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyGhoul;


::Const.Strings.PerkDescription.LegendFavouredEnemyHexen = "Understanding the techniques of the malevolent crones gives you protection against their coven.  Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and resolve while fighting hexe. Additionally, this bonus increases the more Hexe you kill at a rate of [color=" + ::Const.UI.Color.PositiveValue + "]+0.5%[/color] per Hexe you kill. Taking this perk unlocks a difficult legendary contract to hunt a coven leader. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyHexen].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyHexen;


::Const.Strings.PerkDescription.LegendFavouredEnemyAlps = "Preparing for the nightmare creepers gives you techniques against their haggard curses.  Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and resolve while fighting alps. Additionally, this bonus increases the more Alps you kill, at a rate of [color=" + ::Const.UI.Color.PositiveValue + "]+0.35%[/color] per Alp you kill. Taking this perk unlocks an extremely difficult legendary contract to hunt a fire breathing nightmare demon. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyAlps].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyAlps;


::Const.Strings.PerkDescription.LegendFavouredEnemyUnhold = "These gigantic ravenous creatures are dangerous but stupid, that can be used to your advantage. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting unholds. Additionally, this bonus increases the more Unholds you kill at a rate of [color=" + ::Const.UI.Color.PositiveValue + "]+0.5%[/color] damage per unhold killed. Taking this perk unlocks an extremely difficult legendary contract to hunt a stone skinned Mountain Unhold. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyUnhold].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyUnhold;


::Const.Strings.PerkDescription.LegendFavouredEnemyLindwurm = "Understanding the morphology of these noxious serpents opens up weak spots in their scales. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting lindwurms or serpents. Additionally, this bonus increases the more Lindwurms you kill at a rate of [color=" + ::Const.UI.Color.PositiveValue + "]+0.9%[/color] damage per Lindwurm killed. Taking this perk unlocks an extremely difficult legendary contract to hunt a burrowing Stollwurm. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyLindwurm].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyLindwurm;


::Const.Strings.PerkDescription.LegendFavouredEnemyDirewolf = "The vicious jaws of a direwolf can tear limbs asunder. In the heat of their blood soaked frenzy, they leave themselves open for counter attack. Understanding these weaknesses grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting direwolves or hyenas. Additionally, this bonus increases the more wolves you kill at a rate of [color=" + ::Const.UI.Color.PositiveValue + "]+0.15%[/color] damage per direwolf. Taking this perk unlocks an extremely difficult legendary contract to hunt the great white wolf. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyDirewolf].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyDirewolf;


::Const.Strings.PerkDescription.LegendFavouredEnemySpider = "These skittering deadly bugs can be bested by studying the behaviour of arachnids. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting webnechts. Additionally, this bonus increases the more webnechts you kill at a rate of [color=" + ::Const.UI.Color.PositiveValue + "]+0.12%[/color] per webnecht you kill. Taking this perk unlocks a legendary contract to hunt extremely poisonous Redback Webnecht. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemySpider].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySpider;


::Const.Strings.PerkDescription.LegendFavouredEnemySchrat = "The strong branches of a living tree are deadly foes, but trees can be felled with the right knowledge. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] bonus to melee skill, ranged skill and maximum damage while fighting schrats or golems. Additionally, this bonus increases at a rate of [color=" + ::Const.UI.Color.PositiveValue + "]+0.7%[/color] per schrat you kill. Taking this perk unlocks a legendary contract to hunt an endlessly multiplying Heartwood Schrat. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemySchrat].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySchrat;


::Const.Strings.PerkDescription.LegendFavouredEnemyOrk = "These marauding brutes are a force to be reckoned with, though their fighting style lacks finesse and can be countered with the right techniques. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting orcs.  Also increases spawn rate of orc champions. Additionally, this bonus increases the more Orcs you kill, the rate depends on how powerful the orc is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.14%[/color] per orc young, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.8%[/color] per Orc Behemoth you kill. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyOrk].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyOrk;


::Const.Strings.PerkDescription.LegendFavouredEnemyGoblin = "Forces may be gathering to take over the world, but ask someone else, I have no interest in anything but goblins. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting goblins. Also increases spawn rate of goblin champions. Additionally, this bonus increases the more Goblins you kill, the rate depends on how powerful the goblin is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.15%[/color] per goblin fighter, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.35%[/color] per Goblin Overseer you kill. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyGoblin].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyGoblin;


::Const.Strings.PerkDescription.LegendFavouredEnemyVampire = "The terrifying abilities of the Necrosavants and Embalmed are developed over time beyond memory. Their techniques are honed to perfection, but that also makes them predictable. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting Necrosavants and Embalmed. Additionally, this bonus increases at a rate of [color=" + ::Const.UI.Color.PositiveValue + "]+0.3% to +0.4%[/color] per necrosavant or Embalmed killed. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyVampire].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyVampire;


::Const.Strings.PerkDescription.LegendFavouredEnemySkeleton = "The legions from the ancient empire still harass this world, yet their connection to the world of the living can be severed. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting skeletons. Also increases spawn rate of skeleton champions. Additionally, this bonus increases the more Skeletons you kill, the rate depends on how powerful the skeleton is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.14%[/color] per light skeleton, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.4%[/color] per Skeleton Priest you kill. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemySkeleton].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySkeleton;


::Const.Strings.PerkDescription.LegendFavouredEnemyZombie = "Shambling corpses come wave on wave, rising sleepless from their graves. They lose something crucial in death, and that can be exploited. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting wiedergangers. Also increases spawn rate of fallen heroes. Bonus increases the more Wiederganger you kill, the rate depends on how powerful the wiederganger is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.05%[/color] per weideganger, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.25%[/color] per Fallen Hero. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyZombie].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyZombie;


::Const.Strings.PerkDescription.LegendFavouredEnemyNoble = "Soldiers in glittering armor and colourful pennants, their pride shall be their undoing. No gods, no masters. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage against noble soldiers. Also increases spawn rate of noble champions. Additionally, this bonus increases the more noble soldiers you kill, the rate depends on how powerful the noble soldier is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.2%[/color] per footman, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.4%[/color] per Knight you kill. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyNoble].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyNoble;


::Const.Strings.PerkDescription.LegendFavouredEnemyBandit = "Villainous scum, hiding in the dark and stealing from good folk. The bandits must be purged to restore order in the world. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage against bandits. Also increases spawn rate of bandit champions. Additionally, this bonus increases the more bandits you kill, the rate depends on how powerful the bandit is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.03%[/color] per Bandit Rabble, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.3%[/color] per Bandit Leader you kill. Taking this perk unlocks  contract to wage war on army of bandits. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyBandit].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyBandit;


::Const.Strings.PerkDescription.LegendFavouredEnemyBarbarian = "Savages, naught but savages. Civilization must be brought to those godless brutes. They may be strong, but they lack skill. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting barbarians. Also increases spawn rate of barbarian champions. Additionally, this bonus increases the more barbarians you kill, the rate depends on how powerful the barbarian is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.15%[/color] per Barbarian Thrall, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.35%[/color] per Barbarian Champion you kill. Taking this perk unlocks  contract to escort dangerous barbarian prisoner. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyBarbarian].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyBarbarian;


::Const.Strings.PerkDescription.LegendFavouredEnemyArcher = "Some may claim to be the greatest shot in the land, but none have outshot you yet. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting archers. Bonus increases the more archers you kill. This includes Master Archers, Bandit Marksmen and poachers, Militia Archers, Arbalesters and Goblin Ambushers. The bonus depends on how powerful the archer is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.08%[/color] per Bandit Poacher, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.4%[/color] per Master Archer you kill. Also reduces the penalty for targets behind cover by 33%. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyArcher].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyArcher;


::Const.Strings.PerkDescription.LegendFavouredEnemySwordmaster = "The path to martial prowess is beset by the fake and the weak. Only one can be the greatest swordsman. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting elite swordsmen. Bonus increases the more swordsmen you kill. This includes Hedgeknights, Knights, Zweihanders, Swordmasters, Bandit Leaders and Sergeants.  The bonus depends on how powerful the swordsman is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.3%[/color] per Bandit Leader, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.4%[/color] per Knight you kill. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemySwordmaster].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySwordmaster;


::Const.Strings.PerkDescription.LegendFavouredEnemyMercenary = "Mercenaries are the worst, no cause, no principles, no honour. They seek only coin, so they shall find only death. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting mercenaries. Bonus increases the more mercenaries, wardogs and bountyhunters you kill.  The bonus depends on how powerful the mercenary is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.09%[/color] per Wardog, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.3%[/color] per Mercenary you kill. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyMercenary].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyMercenary;


::Const.Strings.PerkDescription.LegendFavouredEnemyCaravan = "Civilians are weak and powerless. Their pitiful lives are pathetic, they should be grateful to behold true might in their dying moments. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting civilians. Bonus increases the more civilians you kill. Includes Peasants, Caravan Hands, Caravan Guards, Militia, Militia Veterans, Militia Captains and Militia Archers.  The bonus depends on how powerful the civilian is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.04%[/color] per Peasant, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.2%[/color] per Militia Captain you kill. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyCaravan].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyCaravan;


::Const.Strings.PerkDescription.LegendFavouredEnemySoutherner = "The southern city states are horrific, their slavery and conscription are afronts to human dignity. Their power must be overthrown. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage against southerners. Bonus increases the more southerners you kill. This includes Gunners, Officers, Engineers, Assassins, Conscripts, and more.  The bonus depends on how powerful the southerner is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.08%[/color] per Conscript, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.4%[/color] per Veteran Manhunter you kill. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemySoutherner].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemySoutherner;


::Const.Strings.PerkDescription.LegendFavouredEnemyNomad = "The southern nomads are uncivilised heathens, without even towns to their name, they must be brought to heel. Grants [color=" + ::Const.UI.Color.PositiveValue + "]+5%[/color] base bonus to melee skill, ranged skill and maximum damage while fighting nomads. Bonus increases the more nomads you kill. This includes Nomadic outlaws, cutthroats, Desert Stalkers, Slaves, Executioners and more.  The bonus depends on how powerful the nomad is, between [color=" + ::Const.UI.Color.PositiveValue + "]+0.08%[/color] per Nomad Cutthroat, and [color=" + ::Const.UI.Color.PositiveValue + "]+0.4%[/color] per Executioner you kill. When you kill 50 of these enemies, add an extra perk point.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendFavouredEnemyNomad].Tooltip = ::Const.Strings.PerkDescription.LegendFavouredEnemyNomad;

