this._proficiency_Hammer <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Hammer";
		setWeapon("Hammer");
	}
});