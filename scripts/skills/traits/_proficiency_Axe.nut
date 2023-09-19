this._proficiency_Axe <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Axe";
		setWeapon("Axe");
	}
});