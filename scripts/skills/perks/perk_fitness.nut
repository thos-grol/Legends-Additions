::Const.Strings.PerkName.Fitness <- "Fitness";
::Const.Strings.PerkDescription.Fitness <- "Greater fitness, heavier armor..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("– 20%") + " Fatigue from Mainhand, Offhand, Head and Body Gear"
+ "\n" + ::MSU.Text.colorGreen("– 50%") + " effect of Fatigue on Agility"
+ "\n\n" + ::MSU.Text.colorRed("Stacks with Brawny");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Fitness].Name = ::Const.Strings.PerkName.Fitness;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Fitness].Tooltip = ::Const.Strings.PerkDescription.Fitness;

this.perk_fitness <- ::inherit("scripts/skills/skill", {
	m = {
		FatPenReduction = 20
	},
	function create()
	{
		this.m.ID = "perk.fitness";
		this.m.Name = ::Const.Strings.PerkName.Fitness;
		this.m.Description = ::Const.Strings.PerkDescription.Fitness;
		this.m.Icon = "ui/perks/fitness.png";
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
		if (mainhand != null) fat += mainhand.getStaminaModifier();
		local offhand = actor.getOffhandItem();
		if (offhand != null) fat += offhand.getStaminaModifier();

		_properties.Stamina -= fat * this.m.FatPenReduction * 0.01;
		_properties.FatigueToInitiativeRate *= 0.5;
	}
});
