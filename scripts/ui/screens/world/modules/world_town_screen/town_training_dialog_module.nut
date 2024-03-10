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

	function has_proficiency( _bro )
	{
		foreach (proficiency in ::Z.Lib.TraininableProficiencies)
		{
			local skill = _bro.getSkills().getSkillByID(proficiency);
			if (skill != null) return true;
		}
		return false;
	}

	function has_trainable_attribute(_bro)
	{
		local ret = {};
		ret.Valid <- false;
		foreach (attribute in ::Z.Lib.TraininableAttributes)
		{
			if (_bro.getFlags().getAsInt(attribute) > 0)
			{
				ret.Valid = true;
				ret[attribute] <- true;
			}
		}
		return ret;

	}

	function queryRosterInformation()
	{
		local settlement = this.World.State.getCurrentTown();
		local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];

		foreach( b in brothers )
		{
			if (b.getSkills().hasSkill("effects.trained")) continue;
			local show_bro = false;
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

			if (has_proficiency(b))
			{
				show_bro = true;
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
				
			}

			local attr = has_trainable_attribute(b);

			if (attr.Valid)
			{
				show_bro = true;

				if ("trainable_hitpoints" in attr)
				{
					e.Training.push({
						id = 3,
						icon = "ui/perks/perk_06.png",
						name = "Strength Training",
						tooltip = "world-town-screen.training-dialog-module.Train4",
						price = 100
					});

				}

				if ("trainable_resolve" in attr)
				{
					e.Training.push({
						id = 4,
						icon = "ui/perks/perk_08.png",
						name = "Courage Training",
						tooltip = "world-town-screen.training-dialog-module.Train5",
						price = 100
					});

				}

				if ("trainable_fatigue" in attr)
				{
					e.Training.push({
						id = 5,
						icon = "ui/perks/wears_it_well.png",
						name = "Endurance Training",
						tooltip = "world-town-screen.training-dialog-module.Train6",
						price = 100
					});

				}

				if ("trainable_initiative" in attr)
				{
					e.Training.push({
						id = 6,
						icon = "ui/perks/alert_circle.png",
						name = "Speed Training",
						tooltip = "world-town-screen.training-dialog-module.Train7",
						price = 100
					});

				}

				if ("trainable_meleeskill" in attr)
				{
					e.Training.push({
						id = 7,
						icon = "ui/perks/CQC.png",
						name = "CQC Training",
						tooltip = "world-town-screen.training-dialog-module.Train8",
						price = 100
					});

				}

				if ("trainable_meleedefense" in attr)
				{
					e.Training.push({
						id = 8,
						icon = "ui/perks/perk_05.png",
						name = "Reflex Training",
						tooltip = "world-town-screen.training-dialog-module.Train9",
						price = 100
					});

				}

				if ("trainable_rangedskill" in attr)
				{
					e.Training.push({
						id = 9,
						icon = "ui/perks/perk_17.png",
						name = "Shooting Training",
						tooltip = "world-town-screen.training-dialog-module.Train10",
						price = 100
					});
				}

				if ("trainable_rangeddefense" in attr)
				{
					e.Training.push({
						id = 10,
						icon = "ui/perks/wind_reader.png",
						name = "Dodge Training",
						tooltip = "world-town-screen.training-dialog-module.Train11",
						price = 100
					});
				}
			}

			if (show_bro) roster.push(e);
			
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

		local price = 0;
		local effect = this.new("scripts/skills/effects_world/new_trained_effect");

		switch(trainingID)
		{

			case 1:
				price = 150;
				effect.m.Mode = "Proficiency";
				effect.add_proficiency(::Math.rand(2, 7));
				effect.m.Icon = "skills/status_effect_76.png";
				break;

			case 2:
				price = 300;
				effect.m.Mode = "Proficiency";
				effect.add_proficiency(::Math.rand(5, 12));
				effect.m.Icon = "skills/status_effect_77.png";
				break;

			case 3:
				price = 100;
				effect.m.Mode = "Stat";
				effect.m.Stat = "trainable_hitpoints";
				effect.m.Icon = "ui/perks/perk_06.png";
				break;

			case 4:
				price = 100;
				effect.m.Mode = "Stat";
				effect.m.Stat = "trainable_resolve";
				effect.m.Icon = "ui/perks/perk_08.png";
				break;

			case 5:
				price = 100;
				effect.m.Mode = "Stat";
				effect.m.Stat = "trainable_fatigue";
				effect.m.Icon = "ui/perks/wears_it_well.png";
				break;

			case 6:
				price = 100;
				effect.m.Mode = "Stat";
				effect.m.Stat = "trainable_initiative";
				effect.m.Icon = "ui/perks/alert_circle.png";
				break;

			case 7:
				price = 100;
				effect.m.Mode = "Stat";
				effect.m.Stat = "trainable_meleeskill";
				effect.m.Icon = "ui/perks/CQC.png";
				break;

			case 8:
				price = 100;
				effect.m.Mode = "Stat";
				effect.m.Stat = "trainable_meleedefense";
				effect.m.Icon = "ui/perks/perk_05.png";
				break;

			case 9:
				price = 100;
				effect.m.Mode = "Stat";
				effect.m.Stat = "trainable_rangedskill";
				effect.m.Icon = "ui/perks/perk_17.png";
				break;

			case 10:
				price = 100;
				effect.m.Mode = "Stat";
				effect.m.Stat = "trainable_rangeddefense";
				effect.m.Icon = "ui/perks/wind_reader.png";
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

