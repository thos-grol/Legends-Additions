this._proficiency_Flail <- this.inherit("scripts/skills/traits/_proficiency", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Flail";
		setWeapon("Flail");
	}

	function validate()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Flail);
	}
});