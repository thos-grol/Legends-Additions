this._proficiency_Dagger <- this.inherit("scripts/skills/traits/_proficiency", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Dagger";
		setWeapon("Dagger");
	}

	function validate()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Dagger);
	}
});