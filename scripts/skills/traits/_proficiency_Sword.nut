this._proficiency_Sword <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Sword";
		setWeapon("Sword");
	}
});