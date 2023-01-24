this.perk_negative_energy_matrix <- this.inherit("scripts/skills/matrix_perk", {
	m = {},
	function create()
	{
		this.m.ID = "perk.negative_energy_matrix";
		this.m.Name = ::Const.Strings.PerkName.NegativeEnergyMatrix;
		this.m.Description = ::Const.Strings.PerkDescription.NegativeEnergyMatrix;
		this.m.Icon = "ui/perks/deathtouch_circle.png";
		this.m.IconDisabled = "ui/perks/deathtouch_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
		this.m.School = ::Const.Magic.Type.NegativeEnergy;
	}

	function onAddedSuccessful()
	{
		local a = this.getContainer().getActor();
		a.getFlags().add("MATRIX_BASIC_HAS", true);
		a.getFlags().add("MATRIX_BASIC_TYPE", this.m.School);
	}

	function onRemoved()
	{
	}

});

