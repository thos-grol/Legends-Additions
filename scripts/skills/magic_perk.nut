this.magic_perk <- this.inherit("scripts/skills/skill", {
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

	function onAddedSuccessful()
	{
	}

	function canPick()
	{
		local Flags = this.getContainer().getActor().getFlags();
		if (!Flags.has("MATRIX_BASIC_HAS")) return false;
		if (Flags.get("MATRIX_BASIC_TYPE") == this.getSchool()) return true;
		if (this.getSchool() == this.Const.Magic.Type.Neutral) return true;
		
		if (!Flags.has("MATRIX_SECONDARY_HAS")) return false;
		if (Flags.get("MATRIX_SECONDARY_TYPE") == this.getSchool()) return true;
	
		return false;
	}

	function getSchool()
	{
		return this.m.School;
	}

});

