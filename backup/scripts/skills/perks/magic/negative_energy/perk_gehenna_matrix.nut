this.perk_gehenna_matrix <- this.inherit("scripts/skills/matrix_perk", {
	m = {},
	function create()
	{
		this.m.ID = "perk.gehenna_matrix";
		this.m.Name = ::Const.Strings.PerkName.MatrixGehenna;
		this.m.Description = ::Const.Strings.PerkDescription.MatrixGehenna;
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
		a.getFlags().add("MATRIX_BASIC_TYPE", ::Const.Magic.Type.NegativeEnergy);
		a.getFlags().add("MATRIX_SECONDARY_HAS", true);
		a.getFlags().add("MATRIX_SECONDARY_TYPE", ::Const.Magic.Type.Fire);
		//refund basic matrix perk
		a.getSkills().removeByID("perk.negative_energy_matrix");
		if (::MSU.isKindOf(a, "player"))
		{
			a.m.PerkPoints++;
			a.m.PerkPointsSpent--;
		}
	}

	function canPick()
	{
		local a = this.getContainer().getActor();
		return !a.getFlags().has("MATRIX_SECONDARY_HAS")
	}

	function onRemoved()
	{
	}

});

