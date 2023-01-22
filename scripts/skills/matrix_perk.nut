this.matrix_perk <- this.inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		School = this.Const.Magic.Type.Neutral
	},
	function create()
	{
	}

	function onAdded()
	{
		if (!this.canPick())
		{
			this.removeSelf();
			if (::MSU.isKindOf(this.getContainer().getActor(), "player"))
			{
				this.getContainer().getActor().m.PerkPoints++;
				this.getContainer().getActor().m.PerkPointsSpent--;
			}
			return false;
		}
		this.onAddedSuccessful();
		return true;
	}

	function canPick()
	{
		local a = this.getContainer().getActor();
		if (!a.getSkills().hasSkill("trait.mana_pool")) return false;
		return !a.getFlags().has("MATRIX_BASIC_HAS")
	}

	function onAddedSuccessful()
	{
	}

	

});

