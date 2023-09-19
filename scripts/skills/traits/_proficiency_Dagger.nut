this._proficiency_Dagger <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Dagger";
		setWeapon("Dagger");
	}
});