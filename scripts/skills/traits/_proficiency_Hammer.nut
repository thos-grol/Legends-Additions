this._proficiency_Hammer <- this.inherit("scripts/skills/traits/_proficiency", {
	m = {},
	function create()
	{
		this._proficiency.create();
		this.m.ID = "trait.proficiency_Hammer";
		setWeapon("Hammer");
	}

	function validate()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(::Const.Items.WeaponType.Hammer);
	}

	function getDetails( _tooltip )
	{
		local actor = this.getContainer().getActor();
		local amount = 0;

		if (actor.getFlags().has(getFlagStore()))
			amount = actor.getFlags().getAsInt(getFlagStore());

		_tooltip.push({
			id = 6,
			type = "text",
			icon = "ui/icons/melee_skill.png",
			text = "Bludgeon Proficiency: " + ::MSU.Text.color(::Z.Color.BloodRed, amount + " / " + this.m.ProficiencyMax)
		});
		return _tooltip;
	}
});