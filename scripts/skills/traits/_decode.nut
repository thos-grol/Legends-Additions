this._decode <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.decoding";
		this.m.Name = "Decoding";
		this.m.Icon = "ui/traits/trait_icon_11.png"; //FEATURE_0: TRAIT tome icon
		this.m.Description = "Linguistic analysis... Theory formulation... Lemma abstraction...";
		this.m.Titles = [];
		this.m.Excluded = [];
		this.m.IsHidden = true;
	}

	////UI

	function isHidden()
	{
		return get_data() == null;
	}

	function getTooltip()
	{
		local data = get_data();
		local ret = [
			{
				id = 1,
				type = "title",
				text = "Decoding " get_data().Name
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		foreach(project in data.Projects)
		{
			ret.push({
				id = 3,
				type = "text",
				icon = ::Const.Perks.PerkDefObjects[project.Reward].Icon,
				text = project.Name
			});
		}

		local current_project = get_current_project();
		local actor = this.getContainer().getActor();


		if (current_project.Complete) //when all projects are completed
		{
			//remove the current meditation
			if (actor.getFlags().get("current_meditation") == current_project.Project.Reward)
				ret.push({
					id = 3,
					type = "text",
					icon = "ui/tooltips/warning.png",
					text = "Already has this meditation, nothing will occur"
				});
			ret.push({
				id = 3,
				type = "text",
				icon = ::Const.Perks.PerkDefObjects[ret.Project.Reward].Icon,
				text = "Replacing meditation perk with: " + project.Name
			});

		}
		else
		{
			if (ret.Project.Type == "Meditation")
			{
				//if you have a meditation already, can only learn it after book is completed
				if (actor.getFlags().has("current_meditation"))
					ret.push({
						id = 3,
						type = "text",
						icon = ::Const.Perks.PerkDefObjects[ret.Project.Reward].Icon,
						text = "Researching " + project.Name + ", but will not swap meditation. Keep the tome in bag after finishing all projects to do this!"
					});
				else ret.push({
					id = 3,
					type = "text",
					icon = ::Const.Perks.PerkDefObjects[ret.Project.Reward].Icon,
					text = "Current Project: " + project.Name
				});
			}
			else ret.push({
				id = 3,
				type = "text",
				icon = ::Const.Perks.PerkDefObjects[ret.Project.Reward].Icon,
				text = "Current Project: " + project.Name
			});
		}

		return ret;
	}

	//helper

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

});

