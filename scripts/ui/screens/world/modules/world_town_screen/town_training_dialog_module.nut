this.town_training_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {},
	function create()
	{
		this.m.ID = "TrainingDialogModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.ui_module.destroy();
	}

	function clear()
	{
	}

	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}

	function queryRosterInformation()
	{
		local settlement = this.World.State.getCurrentTown();
		local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];

		foreach( b in brothers )
		{
			if (b.getSkills().hasSkill("effects.trained"))
			{
				continue;
			}

			local background = b.getBackground();
			local e = {
				ID = b.getID(),
				Name = b.getName(),
				Level = b.getLevel(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription(),
				Training = [],
				Effects = []
			};
			e.Training.push({
				id = 0,
				icon = "skills/status_effect_75.png",
				name = "Sparring Fight",
				tooltip = "world-town-screen.training-dialog-module.Train1",
				price = 50
			});
			e.Training.push({
				id = 1,
				icon = "skills/status_effect_76.png",
				name = "Veteran\'s Lessons",
				tooltip = "world-town-screen.training-dialog-module.Train2",
				price = 150
			});
			e.Training.push({
				id = 2,
				icon = "skills/status_effect_77.png",
				name = "Rigorous Schooling",
				tooltip = "world-town-screen.training-dialog-module.Train3",
				price = 300
			});
			roster.push(e);
		}

		return {
			Title = "Training Hall",
			SubTitle = "Have your company train for combat and learn from veterans",
			Roster = roster,
			Assets = this.m.Parent.queryAssetsInformation()
		};
	}

	function onTrain( _data )
	{
		local entityID = _data[0];
		local trainingID = _data[1];
		local settlement = this.World.State.getCurrentTown();
		local entity = this.Tactical.getEntityByID(entityID);

		if (entity.getSkills().hasSkill("effects.trained"))
		{
			return null;
		}

		local has_proficiency = false;
		local proficiencies = [
			"trait.proficiency_Axe",
			"trait.proficiency_Cleaver",
			"trait.proficiency_Sword",
			"trait.proficiency_Mace",
			"trait.proficiency_Hammer",
			"trait.proficiency_Flail",
			"trait.proficiency_Spear",
			"trait.proficiency_Polearm",
			"trait.proficiency_Fist",
			"trait.proficiency_Ranged",
		];
		foreach (proficiency in proficiencies)
		{
			local skill = entity.getSkills().getSkillByID(proficiency);
			if (skill != null)
			{
				has_proficiency = true;
				break;
			}
		}

		if (!has_proficiency) return null;

		local price = 0;
		local effect = this.new("scripts/skills/effects_world/new_trained_effect");

		switch(trainingID)
		{
		case 0:
			price = this.Math.round(50);
			effect.add_proficiency(::Math.rand(0, 5));
			effect.m.Icon = "skills/status_effect_75.png";
			break;

		case 1:
			price = this.Math.round(150);
			effect.add_proficiency(::Math.rand(2, 7));
			effect.m.Icon = "skills/status_effect_76.png";
			break;

		case 2:
			price = this.Math.round(300);
			effect.add_proficiency(::Math.rand(5, 12));
			effect.m.Icon = "skills/status_effect_77.png";
			break;
		}

		this.World.Assets.addMoney(-price);
		entity.getSkills().add(effect);
		local background = entity.getBackground();
		local e = {
			ID = entity.getID(),
			Name = entity.getName(),
			Level = entity.getLevel(),
			ImagePath = entity.getImagePath(),
			ImageOffsetX = entity.getImageOffsetX(),
			ImageOffsetY = entity.getImageOffsetY(),
			BackgroundImagePath = background.getIconColored(),
			BackgroundText = background.getDescription(),
			Training = [],
			Effects = []
		};
		e.Effects.push({
			id = effect.getID(),
			icon = effect.getIcon()
		});
		local r = {
			Entity = e,
			Assets = this.m.Parent.queryAssetsInformation()
		};
		return r;
	}

});

