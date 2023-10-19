
::Const.Strings.PerkName.SpecSpear = "Spear Proficiency";
::Const.Strings.PerkDescription.SpecSpear = ::MSU.Text.color(::Z.Log.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 25%") + " skill fatigue (Spears)"
+ "\n " + ::MSU.Text.colorGreen("0%") + " adjacent hit penalty (Spetum and Warfork)"

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "With spear equipped:")
+ "\n " + ::MSU.Text.colorGreen("+1") + " free attack (Thrust or Prong), but does -25% Damage"
+ "\n\n"+::MSU.Text.colorGreen("+5") + " melee defense against an opponent per hit (up to +20)"
+ "\n"+::MSU.Text.colorRed("Invalid if a shield is equipped. When taking damage, the bonus against the source is lost")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Spearwall:")
+ "\nIs no longer cancelled once an enemy overcomes it";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSpear].Name = ::Const.Strings.PerkName.SpecSpear;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecSpear].Tooltip = ::Const.Strings.PerkDescription.SpecSpear;

this.perk_mastery_spear <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.spear";
		this.m.Name = ::Const.Strings.PerkName.SpecSpear;
		this.m.Description = ::Const.Strings.PerkDescription.SpecSpear;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInSpears = true;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("perk.ptr_king_of_all_weapons"))
			this.m.Container.add(::new("scripts/skills/effects/_king_of_all_weapons"));

		if (!this.m.Container.hasSkill("perk.ptr_a_better_grip"))
			this.m.Container.add(::new("scripts/skills/effects/_spear_advantage"));

		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Spear"))
			this.m.Container.add(::new("scripts/skills/traits/_proficiency_Spear"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("perk.ptr_king_of_all_weapons");
		this.m.Container.removeByID("perk.ptr_a_better_grip");
	}

});

