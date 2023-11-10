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

	//FEATURE_0: BRIGHT create tome data structure before proceeding

	function onNewDay() //decipher
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
		if (tome_data == null) return;

		foreach(project in tome_data.Projects)
		{

		}
		//get current project
		//tick progress
	}

	//Helper fns

	function progress_current_project()
	{
		local ret = get_current_project();

		if (ret.Complete)
		{

		}
		else
		{

		}

		//FEATURE_0: BRIGHT progress_current_project
		check for tome_id flag existence: tome_id + "_progress"
		//get's the current perk to learn,
		//if there is no more projects then
			//set project to replace meditation perk if it is different
			//else
	}


	function get_current_project()
	{
		//FEATURE_0:  BRIGHT get_current_meditation_perk
		local ret = {
			Project = null,
			Complete = false
		};
		local project_flag = null;
		for projects in map[tome_id]
		{
			if (actor.hasflag(projects.flag)) continue;
			ret.push(projects.flag);
			break;
		}

		if (ret.Project == null)
		{
			ret.Project = //meditation_flag;
			ret.Complete = true;
		}

		return ret
	}

	function reward_current_project()
	{
		//FEATURE_0:  BRIGHT progress_current_project
		if (meditationproject)
		{
			if (no meditation perk)
				add_meditation_perk()
			else if (full completion && different meditation perk)
			{
				swap it out
			}
			return;
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

