this.perk_negative_energy_hand <- this.inherit("scripts/skills/magic_perk", {
	m = {},
	function create()
	{
		this.m.ID = "perk.negative_energy_hand";
		this.m.Name = ::Const.Strings.PerkName.NegativeEnergyHand;
		this.m.Description = ::Const.Strings.PerkDescription.NegativeEnergyHand;
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
		if (!this.m.Container.hasSkill("actives.negative_energy_hand"))
		{
			this.m.Container.add(::new("scripts/skills/actives/negative_energy_hand"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.negative_energy_hand");
	}

});

