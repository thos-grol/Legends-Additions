this._proficiency_Cleaver <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Cleaver";
		setWeapon("Cleaver");
	}
});