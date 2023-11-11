this.bright_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.bright";
		this.m.Name = "Bright";
		this.m.Icon = "ui/traits/trait_icon_11.png";
		this.m.Description = "This character has an easier time than most with grasping new concepts and adapting to the situation.";
		this.m.Titles = [
			"the Quick",
			"the Fox",
			"Quickmind",
			"the Bright",
			"the Wise"
		];
		this.m.Excluded = [
			"trait.dumb",
			"trait.predictable"
		];
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("trait.decoding"))
			this.m.Container.add(::new("scripts/skills/traits/_decode"));

		local actor = this.getContainer().getActor();
		if (actor.getFlags().has("Intelligent")) return;

		local tier = 1;
		local roll = this.Math.rand(1, 100);
		if (roll <= 1) tier = 4; //Genius
		else if (roll <= 5) tier = 3; //Gifted
		else if (roll <= 20) tier = 2; //Above Average
		actor.getFlags().set("Intelligent", roll);
	}

	function upgrade()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Intelligent", ::Math.min(4, actor.getFlags().getAsInt("Intelligent") + 1));
	}

	function getBonus()
	{
		local actor = this.getContainer().getActor();
		switch(actor.getFlags().getAsInt("Intelligent"))
		{
			case 1:
				return 1;
			case 2:
				return 3;
			case 3:
				return 5;
			case 4:
				return 10;
		}
	}

	// Tick
	function onNewDay() //decipher
	{
		if (get_data() == null) return;
		tick();
	}

	//Helper fns

	function get_data()
	{
		local actor = this.getContainer().getActor();
		local items = actor.getItems().getAllItems();

		local tome_data = null;
		foreach(i in items)
		{
			if (i.m.ID != "misc.tome") continue;
			tome_data = i.getData();
			break;
		}
		return tome_data;
	}

	function get_current_project()
	{
		local ret = {
			Project = null,
			Complete = false
		};

		local tome_data = get_data();
		if (tome_data == null) return;

		local actor = this.getContainer().getActor();
		foreach(project in tome_data.Projects)
		{
			if (actor.getFlags().has(project.Name)) continue;
			ret.Project = project;
			break;
		}

		if (ret.Project == null) //Get meditation perk
		{
			foreach(project in tome_data.Projects)
			{
				ret.Project = project;
				ret.Complete = true;
				break;
			}
		}

		return ret
	}

	function tick()
	{
		local ret = get_current_project();
		local actor = this.getContainer().getActor();

		if (ret.Complete) //when all projects are completed
		{
			//remove the current meditation
			if (actor.getFlags().get("current_meditation") == ret.Project.Reward) return; //if it's the same meditation, why change it?

			if (actor.getSkills().hasSkill(::Const.Perks.PerkDefObjects[actor.getFlags().get("current_meditation")].ID))
				actor.getSkills().removeByID(::Const.Perks.PerkDefObjects[actor.getFlags().get("current_meditation")].ID);

			if (actor.getBackground().hasPerk(actor.getFlags().get("current_meditation")))
				actor.getBackground().removePerk(actor.getFlags().get("current_meditation"));

			::Z.Perks.add(actor, ret.Project.Reward, 0); //add the meditation in the book
			actor.getFlags().set("current_meditation", ret.Project.Reward); //add id for future removal
		}
		else
		{
			if (::Math.rand(1, 100) <= ::Math.max(getBonus() - ret.Project.BonusDifficulty, 1))
			{
				actor.getFlags().set(ret.Project.Name, true); //Mark the project as completed

				if (ret.Project.Type == "Meditation")
				{
					//if you have a meditation already, can only learn it after book is completed
					if (actor.getFlags().has("current_meditation")) return;
					::Z.Perks.add(actor, ret.Project.Reward, ret.Project.Row); //add the meditation perk bought
					actor.getFlags().set("current_meditation", ret.Project.Reward); //add id for future removal
					return;
				}
				::Z.Perks.add(actor, ret.Project.Reward, ret.Project.Row, false); //add the perk unbought
			}
		}
	}

	////UI

	function getName()
	{
		local actor = this.getContainer().getActor();
		if (!actor.getFlags().has("Intelligent")) return "Average Intelligence";
		switch(actor.getFlags().getAsInt("Intelligent"))
		{
			case 1:
				return "Average Intelligence"
			case 2:
				return "Above Average Intelligence"
			case 3:
				return "Gifted"
			case 4:
				return "Genius"
		}
	}

	function getTooltip()
	{
		return [
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
				icon = "ui/icons/special.png",
				text = "Gives the intelligent perk tree. It is impossible to obtain otherwise"
			}
			,
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Has a " + getBonus() + "% chance to decipher magical knowledge each day. A tome must be in this unit's bag slot for this to trigger"
			}
		];
	}

});

