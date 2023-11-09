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

	//FEATURE_0: TRAIT IsHidden function if tome is in bag slot

	////UI

	function getName()
	{
		return "Decoding " + ;//FEATURE_0: TRAIT book name
	}

	function getTooltip()
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

		//FEATURE_0: TRAIT display all feats progress + current project
		return ret;
	}

});

