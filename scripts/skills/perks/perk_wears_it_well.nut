::Const.Strings.PerkName.WearsItWell <- "Fitness";
::Const.Strings.PerkDescription.WearsItWell <- "Greater fitness, heavier armor..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.colorGreen("– 20%") + " Fatigue from Mainhand, Offhand, Head and Body Gear"
+ "\n\n" + ::MSU.Text.colorRed("Stacks with Brawny");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.WearsItWell].Name = ::Const.Strings.PerkName.WearsItWell;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.WearsItWell].Tooltip = ::Const.Strings.PerkDescription.WearsItWell;

this.perk_wears_it_well <- ::inherit("scripts/skills/skill", {
	m = {
		FatPenReduction = 20
	},
	function create()
	{
		this.m.ID = "perk.wears_it_well";
		this.m.Name = ::Const.Strings.PerkName.WearsItWell;
		this.m.Description = ::Const.Strings.PerkDescription.WearsItWell;
		this.m.Icon = "ui/perks/rf_wears_it_well.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate(_properties)
	{
		local actor = this.getContainer().getActor();
		local fat = actor.getItems().getStaminaModifier([::Const.ItemSlot.Body, ::Const.ItemSlot.Head]);

		local mainhand = actor.getMainhandItem();
		if (mainhand != null)
		{
			fat += mainhand.getStaminaModifier();
		}

		local offhand = actor.getOffhandItem();
		if (offhand != null)
		{
			fat += offhand.getStaminaModifier();
		}

		_properties.Stamina -= fat * this.m.FatPenReduction * 0.01;
	}
});
