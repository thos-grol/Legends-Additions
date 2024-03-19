::mods_hookExactClass("entity/tactical/player", function (o){

    o.onInit = function()
	{
		this.human.onInit();
		this.m.Skills.add(this.new("scripts/skills/special/stats_collector"));
		this.m.Skills.add(this.new("scripts/skills/special/weapon_breaking_warning"));
		this.m.Skills.add(this.new("scripts/skills/special/no_ammo_warning"));
		this.m.Skills.add(this.new("scripts/skills/effects/battle_standard_effect"));
		this.m.Skills.add(this.new("scripts/skills/actives/break_ally_free_skill"));
		this.m.Skills.add(this.new("scripts/skills/effects/realm_of_nightmares_effect"));
		this.m.Skills.add(this.new("scripts/skills/special/legend_horserider_skill"));
		this.m.Skills.add(this.new("scripts/skills/effects/legend_veteran_levels_effect"));

		if (::Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		this.setFaction(::Const.Faction.Player);
		this.m.Items.setUnlockedBagSlots(2);
		this.m.Skills.add(this.new("scripts/skills/special/bag_fatigue"));
		this.setDiscovered(true);
	}

	o.setStartValuesEx = function( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		if (this.isSomethingToSee() && this.World.getTime().Days >= 7) _backgrounds = ::Const.CharacterPiracyBackgrounds;

		local background = ::new("scripts/skills/backgrounds/" + _backgrounds[::Math.rand(0, _backgrounds.len() - 1)]);
		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() != "Disabled")
            background.setGender(_gender);
		this.m.Skills.add(background);
		background.buildDescription();
		if (background.isBackgroundType(::Const.BackgroundType.Female))
            this.setGender(1);


		//Add traits before trees, so traits can determine trait trees.
        local maxTraits = 0;
		if (_addTraits)
		{
			local maxTraits = 2;
			local traits = [
				background
			];

			if (background.m.IsGuaranteed.len() > 0)
			{
				maxTraits = maxTraits - background.m.IsGuaranteed.len();

				foreach( trait in background.m.IsGuaranteed )
				{
					traits.push(::new("scripts/skills/traits/" + trait));
				}
			}

			this.pickTraits(traits, maxTraits);

			for( local i = 1; i < traits.len(); i = i )
			{
				this.m.Skills.add(traits[i]);

				if (traits[i].getContainer() != null)
				{
					traits[i].addTitle();
				}

				i = ++i;
			}
		}


		// this.m.Skills.add(::new("scripts/skills/traits/bright_trait"));
        // this.m.Skills.add(::new("scripts/skills/traits/teamplayer_trait"));

		local attributes = background.buildPerkTree();

		if (this.getFlags().has("PlayerZombie")) this.m.StarWeights = background.buildAttributes("zombie", attributes);
		else if (this.getFlags().has("PlayerSkeleton")) this.m.StarWeights = background.buildAttributes("skeleton", attributes);
		else this.m.StarWeights = background.buildAttributes(null, attributes);

		local b = getBaseProperties();
		this.getFlags().set("trainable_hitpoints", ::Math.max(0, 60 - b.Hitpoints));
		this.getFlags().set("trainable_resolve", ::Math.max(0, 60 - b.Bravery));
		this.getFlags().set("trainable_fatigue", ::Math.max(0, 120 - b.Stamina));
		this.getFlags().set("trainable_initiative", ::Math.max(0, 120 - b.Initiative));
		
		this.getFlags().set("trainable_meleeskill", ::Math.max(0, 60 - b.MeleeSkill));
		this.getFlags().set("trainable_meleedefense", ::Math.max(0, 10 - b.MeleeDefense));

		this.getFlags().set("trainable_rangedskill", ::Math.max(0, 60 - b.RangedSkill));
		this.getFlags().set("trainable_rangeddefense", ::Math.max(0, 10 - b.RangedDefense));

		background.buildDescription();

		if (_addEquipment) background.addEquipment();

		if (this.getFlags().has("PlayerZombie")) background.setAppearance("zombie");
		else if (this.getFlags().has("PlayerSkeleton")) background.setAppearance("skeleton");
		else background.setAppearance();

		background.buildDescription(true);
		this.m.Skills.update();
		local p = this.m.CurrentProperties;
		this.m.Hitpoints = p.Hitpoints;

		if (_addTraits)
		{
			this.fillTalentValues(3);
			this.fillAttributeLevelUpValues(::Const.XP.MaxLevelWithPerkpoints - 1);
		}
	}

	o.fillTalentValues = function( _num, _force = false )
	{
		this.m.Talents.resize(::Const.Attributes.COUNT, 0);
		if (this.getBackground() != null && this.getBackground().isBackgroundType(::Const.BackgroundType.Untalented) && !_force) return;

		local max = 3;
		local num = 0;

		if (num < max && (this.getFlags().has("Commander") || this.getFlags().has("Tenacious")))
		{
			this.getTalents()[::Const.Attributes.Bravery] = ::Math.rand(2,3);
			num++;
		}

		if (num < max && this.getFlags().has("Calm"))
		{
			this.getTalents()[::Const.Attributes.RangedDefense] = ::Math.rand(1,3);
			num++;
		}

		if (num < max && this.getFlags().has("Fit"))
		{
			this.getTalents()[::Const.Attributes.Fatigue] = ::Math.rand(1,3);
			num++;
		}

		if (num < max && this.getFlags().has("Large"))
		{
			this.getTalents()[::Const.Attributes.RangedSkill] = ::Math.rand(1,3);
			num++;
		}
		
		if (num < max && this.getFlags().has("Sturdy"))
		{
			this.getTalents()[::Const.Attributes.Hitpoints] = ::Math.rand(1,3);
			num++;
		}

		if (num < max && this.getFlags().has("Agile"))
		{
			this.getTalents()[::Const.Attributes.Initiative] = ::Math.rand(1,3);
			num++;
		}

		
	}

	o.isPerkUnlockable = function( _id )
	{
		if (this.m.PerkPoints == 0 || this.hasPerk(_id)) return false;
		local perk = this.getBackground().getPerk(_id);
		if (perk == null) return false;

		if (::Z.Perks.isDestiny(_id))
		{
			if (this.m.Level < 11) return false; //is level 11
			if (this.getFlags().has("Destiny")) return false; //has a destiny already
		}

		if (::Z.Perks.isStance(_id))
		{
			if (!::Z.Perks.verifyStance(actor, _id)) return false; //has required mastery
			if (this.getFlags().has("Stance")) return false; //has a stance already
		}


		if (this.m.PerkPointsSpent >= perk.Unlocks) return true;
		return false;
	}

	o.updateLevel = function()
	{
		while (this.m.Level < ::Const.LevelXP.len() && this.m.XP >= ::Const.LevelXP[this.m.Level] && this.m.Level < 11)
		{
			++this.m.Level;
			++this.m.LevelUps;

			if (this.m.Level <= ::Const.XP.MaxLevelWithPerkpoints)
			{
				++this.m.PerkPoints;
			}

			if (this.m.Level >= 10 && this.m.Skills.hasSkill("perk.student") && !this.getFlags().has("Student"))
			{
				++this.m.PerkPoints;
				this.getFlags().set("Student", true)
			}

			if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null)
			{
				this.World.Assets.getOrigin().onUpdateLevel(this);
			}

			if (this.m.Level == 11)
			{
				this.updateAchievement("OldAndWise", 1, 1);
			}

			if (this.m.Level == 11 && this.m.Skills.hasSkill("trait.player"))
			{
				this.updateAchievement("TooStubbornToDie", 1, 1);
			}
		}
	}

	o.updateLevel_limit_break <- function()
	{
		if (this.m.Level >= 11) return;
		++this.m.Level;
		++this.m.LevelUps;
		++this.m.PerkPoints;

		if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null)
		{
			this.World.Assets.getOrigin().onUpdateLevel(this);
		}
	}

	o.getStashModifier = function() //pasting function here, doing the same with other functions fixed problems for some reason so trying it here??? also adding try catch just in case
	{
		try
		{
			local broStash = this.getBackground().getModifiers().Stash;
			local item = this.getItems().getItemAtSlot(::Const.ItemSlot.Accessory);

			if (item != null)
			{
				broStash = broStash + item.getStashModifier();
			}

			local skills = [
				"perk.legend_skillful_stacking",
				"perk.legend_efficient_packing"
			];

			foreach( s in skills )
			{
				local skill = this.getSkills().getSkillByID(s);

				if (skill != null)
				{
					broStash = broStash + skill.getModifier();
				}
			}

			return broStash;
		}catch(exception)
		{
			return ::Const.LegendMod.ResourceModifiers.Ammo[4];
		}


	}

	o.checkMorale = function( _change, _difficulty, _type = this.Const.MoraleCheckType.Default, _showIconBeforeMoraleIcon = "", _noNewLine = false )
	{
		if (_change > 0 && this.m.MoraleState == this.Const.MoraleState.Steady && this.m.Skills.hasSkill("trait.insecure"))
		{
			return false;
		}

		if (_change > 0 && this.m.MoraleState == this.Const.MoraleState.Steady && ("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin().getID() == "scenario.anatomists")
		{
			return false;
		}

		if (_change < 0 && this.m.MoraleState == this.Const.MoraleState.Breaking && this.m.Skills.hasSkill("effects.ancient_priest_potion"))
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
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 20 : -20);
		}
		else if (this.m.Skills.hasSkill("trait.mad"))
		{
			_difficulty = _difficulty + (this.Math.rand(0, 1) == 0 ? 40 : -40);
		}

		if (_change < 0 && _type == this.Const.MoraleCheckType.MentalAttack && this.m.Skills.hasSkill("trait.superstitious"))
		{
			_difficulty = _difficulty - 10;
		}

		return this.actor.checkMorale(_change, _difficulty, _type, _showIconBeforeMoraleIcon, _noNewLine);
	}
});