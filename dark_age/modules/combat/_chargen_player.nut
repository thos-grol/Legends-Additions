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

		if (this.Const.DLC.Unhold)
		{
			this.m.Skills.add(this.new("scripts/skills/actives/wake_ally_skill"));
		}

		this.setFaction(this.Const.Faction.Player);
		this.m.Items.setUnlockedBagSlots(2);
		this.m.Skills.add(this.new("scripts/skills/special/bag_fatigue"));
		this.setDiscovered(true);
	}

	o.setStartValuesEx = function( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		if (this.isSomethingToSee() && this.World.getTime().Days >= 7) _backgrounds = ::Const.CharacterPiracyBackgrounds;

		local background = ::new("scripts/skills/backgrounds/" + _backgrounds[this.Math.rand(0, _backgrounds.len() - 1)]);
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

		background.buildDescription();

		local inTraining = ::new("scripts/skills/traits/intensive_training_trait");
		if (!this.getSkills().hasSkill("trait.intensive_training_trait")) this.m.Skills.add(inTraining);


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


		local attributes = [];
		local weights = [];
		local totalWeight = 0;

		if (this.getFlags().has("Intelligent"))
		{
			this.getTalents()[::Const.Attributes.MeleeDefense] = ::Math.rand(2,3);
			_num -= 1;
		}

		if (this.getFlags().has("Commander"))
		{
			this.getTalents()[::Const.Attributes.Bravery] = ::Math.rand(2,3);
			_num -= 1;
		}

		for( local i = 0; i < this.m.StarWeights.len(); i = i )
		{
			if (this.m.Talents[i] != 0)
			{
			}
			else if (this.getBackground() != null && this.getBackground().getExcludedTalents().find(i) != null)
			{
			}
			else
			{
				if (this.getFlags().has("PlayerZombie") && (i == ::Const.Attributes.Bravery || i == ::Const.Attributes.Fatigue || i == ::Const.Attributes.Initiative))
				{
					continue;
				}
				else if (this.getFlags().has("PlayerSkeleton") && (i == ::Const.Attributes.Bravery || i == ::Const.Attributes.Fatigue || i == ::Const.Attributes.Hitpoints))
				{
					continue;
				}

				attributes.push(i);
				weights.push(this.m.StarWeights[i]);
				totalWeight = totalWeight + this.m.StarWeights[i];
			}

			i = ++i;
		}

		for( local done = 0; done < _num; done = done )
		{
			local weight = this.Math.rand(1, totalWeight);
			local totalhere = 0;

			for( local i = 0; i < attributes.len(); i = i )
			{
				if (weight > totalhere && weight <= totalhere + weights[i])
				{
					local r = this.Math.rand(1, 100);
					local j = attributes[i];

					if (r <= 60)
					{
						this.m.Talents[j] = 1;
					}
					else if (r <= 90)
					{
						this.m.Talents[j] = 2;
					}
					else
					{
						this.m.Talents[j] = 3;
					}

					attributes.remove(i);
					totalWeight = totalWeight - weights[i];
					weights.remove(i);
					break;
				}
				else
				{
					totalhere = totalhere + weights[i];
				}

				i = ++i;
			}

			done = ++done;
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
		while (this.m.Level < this.Const.LevelXP.len() && this.m.XP >= this.Const.LevelXP[this.m.Level])
		{
			++this.m.Level;
			++this.m.LevelUps;

			if (this.m.Level <= this.Const.XP.MaxLevelWithPerkpoints)
			{
				++this.m.PerkPoints;
			}

			if (this.m.Level == 10 && this.m.Skills.hasSkill("perk.student"))
			{
				++this.m.PerkPoints;
			}

			if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null)
			{
				this.World.Assets.getOrigin().onUpdateLevel(this);
			}

			if (this.m.Level == 10)
			{
				this.updateAchievement("OldAndWise", 1, 1);
			}

			if (this.m.Level == 10 && this.m.Skills.hasSkill("trait.player"))
			{
				this.updateAchievement("TooStubbornToDie", 1, 1);
			}
		}
	}
});