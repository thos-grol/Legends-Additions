::mods_hookExactClass("entity/tactical/player", function (o){
    
    o.setStartValuesEx = function( _backgrounds, _addTraits = true, _gender = -1, _addEquipment = true )
	{
		if (this.isSomethingToSee() && this.World.getTime().Days >= 7) _backgrounds = this.Const.CharacterPiracyBackgrounds;
	
		local background = this.new("scripts/skills/backgrounds/" + _backgrounds[this.Math.rand(0, _backgrounds.len() - 1)]);
		if (::Legends.Mod.ModSettings.getSetting("GenderEquality").getValue() == "All") 
            background.setGender(_gender);
		this.m.Skills.add(background);
		background.buildDescription();
		if (background.isBackgroundType(this.Const.BackgroundType.Female)) 
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
					traits.push(this.new("scripts/skills/traits/" + trait));
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

        //TODO: for testing
        // this.m.Skills.add(::new("scripts/skills/traits/bright_trait"));

		local attributes = background.buildPerkTree();
		
		if (this.getFlags().has("PlayerZombie")) this.m.StarWeights = background.buildAttributes("zombie", attributes);
		else if (this.getFlags().has("PlayerSkeleton")) this.m.StarWeights = background.buildAttributes("skeleton", attributes);
		else this.m.StarWeights = background.buildAttributes(null, attributes);

		background.buildDescription();

		local inTraining = this.new("scripts/skills/traits/intensive_training_trait");
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
			if (this.getFlags().has("Intelligent"))
            {
                this.fillTalentValues(2);
                if (this.getTalents()[this.Const.Attributes.MeleeDefense] > 0)
                {
                    this.getTalents()[this.Const.Attributes.MeleeDefense] = ::Math.max(::Math.rand(2,3), this.getTalents()[this.Const.Attributes.MeleeDefense]);
                    this.fillTalentValues(1);
                }
                else this.getTalents()[this.Const.Attributes.MeleeDefense] = ::Math.rand(2,3);
            }
            else this.fillTalentValues(3);
			this.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);

		}
	}
});