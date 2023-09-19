this._proficiency_Bow <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Bow";
		setWeapon("Bow");
	}
});