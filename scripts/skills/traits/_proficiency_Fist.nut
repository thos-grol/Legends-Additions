this._proficiency_Fist <- this.inherit("scripts/skills/traits/_proficiency", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Fist";
		setWeapon("Fist");
	}

	function validate()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon == null;
	}
});