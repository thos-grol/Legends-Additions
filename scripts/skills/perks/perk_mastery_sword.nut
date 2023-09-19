::Const.Strings.PerkName.SpecSword = "Sword Proficiency";
::Const.Strings.PerkDescription.SpecSword = ::MSU.Text.color(::Z.Log.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Swords)"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Ending turn, with sword equipped:[/u]")
+ "\n "+"Riposte. If impossible, Return Favor"
+ "\n "+::MSU.Text.colorRed("Invalid with less than 15 Fatigue remaining");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSword].Name = ::Const.Strings.PerkName.SpecSword;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSword].Tooltip = ::Const.Strings.PerkDescription.SpecSword;

this.perk_mastery_sword <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.sword";
		this.m.Name = this.Const.Strings.PerkName.SpecSword;
		this.m.Description = this.Const.Strings.PerkDescription.SpecSword;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
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

