::Const.Strings.PerkName.SpecSword = "Sword Proficiency";
::Const.Strings.PerkDescription.SpecSword = ::MSU.Text.color(::Z.Log.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Swords)"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Ending turn, with sword equipped:")
+ "\nRiposte"
+ "\n "+::MSU.Text.colorRed("Invalid with less than 15 Fatigue remaining. If the sword cannot riposte, missing attackers will have a 50% to be dazed")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.BloodRed, "Daze: (Duration: 2)")
+ "\n "+::MSU.Text.colorRed("– 50% Fatigue")
+ "\n "+::MSU.Text.colorRed("– 50% Initiative");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSword].Name = ::Const.Strings.PerkName.SpecSword;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSword].Tooltip = ::Const.Strings.PerkDescription.SpecSword;

this.perk_mastery_sword <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.sword";
		this.m.Name = ::Const.Strings.PerkName.SpecSword;
		this.m.Description = ::Const.Strings.PerkDescription.SpecSword;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInSwords = true;
	}

	function onAdded()
	{
		this.getContainer().add(::new("scripts/skills/actives/en_garde_toggle"));

		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Sword"))
			this.m.Container.add(this.new("scripts/skills/traits/_proficiency_Sword"));
	}

	function onRemoved()
	{
		this.getContainer().removeByID("actives.en_garde_toggle");
	}

});

