//Removes the adjacent penalty to hit for 2 range tile weapons
::Const.Strings.PerkName.SpecPolearm = "Polearm Proficiency";
::Const.Strings.PerkDescription.SpecPolearm = ::MSU.Text.color(::Z.Color.Purple, "Proficiency")
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Follow Up\' (4 AP, 30 Fat):")
+ "\nWeilding a 2H weapon and not engaged in melee, perform a free attack when an ally hits a target in raange. Damage starts at 50% and drops by 10% each attack until 10%."

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 1") + " AP cost (Polearm skills)"
+ "\n " + ::MSU.Text.colorGreen("+1") + " free attack (Thrust or Prong), but does -25% Damage"
+ "\nRemoves the penalty for attacking adjacent targets"
+ "\nKnock Out, Knock Over and Strike Down have a " + ::MSU.Text.colorGreen("100%") + " chance to stun the target"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Spearwall:")
+ "\nIs no longer cancelled once an enemy overcomes it";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecPolearm].Name = ::Const.Strings.PerkName.SpecPolearm;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpecPolearm].Tooltip = ::Const.Strings.PerkDescription.SpecPolearm;

this.perk_mastery_polearm <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.mastery.polearm";
		this.m.Name = ::Const.Strings.PerkName.SpecPolearm;
		this.m.Description = ::Const.Strings.PerkDescription.SpecPolearm;
		this.m.Icon = "ui/perks/perk_10.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInPolearms = true;
		_properties.IsSpecializedInSpears = true;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.follow_up")) this.m.Container.add(::new("scripts/skills/actives/follow_up"));

		if (!this.m.Container.hasSkill("perk.ptr_king_of_all_weapons"))
			this.m.Container.add(::new("scripts/skills/effects/_king_of_all_weapons"));
		
		local actor = this.getContainer().getActor();
		if (actor.getFaction() != ::Const.Faction.Player) return;

		if (!this.m.Container.hasSkill("trait.proficiency_Polearm"))
			this.m.Container.add(::new("scripts/skills/traits/_proficiency_Polearm"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.follow_up");
		this.m.Container.removeByID("perk.ptr_king_of_all_weapons");
	}

});

