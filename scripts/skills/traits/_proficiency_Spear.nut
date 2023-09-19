this._proficiency_Spear <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Spear";
		setWeapon("Spear");
	}
});