this._proficiency_Polearm <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Polearm";
		setWeapon("Polearm");
	}
});