this._proficiency_Polearm <- this.inherit("scripts/skills/traits/_proficiency", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Polearm";
		setWeapon("Polearm");
	}

	function validate()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Polearm);
	}
});