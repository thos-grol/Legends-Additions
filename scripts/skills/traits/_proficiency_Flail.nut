this._proficiency_Flail <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Flail";
		setWeapon("Flail");
	}
});