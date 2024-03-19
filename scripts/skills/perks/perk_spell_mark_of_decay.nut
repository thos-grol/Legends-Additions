::Const.Strings.PerkName.SpellMarkofDecay <- "Mark of Decay";
::Const.Strings.PerkDescription.SpellMarkofDecay <- "All will decay until there is silence and cold..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Mark of Decay\' (6 AP, 20 Fat, 2 Mana):")
+ "\n" + "Inflict "+::MSU.Text.colorGreen("Mark of Decay")
+ "\n" + "Inflict "+::MSU.Text.colorGreen("1")+" Decay"

+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Mark of Decay: (Duration: 3)")
+ "\n " + ::MSU.Text.color(::Z.Color.BloodRed, "On turn start, inflict 25% of the unit's Endurance as fatigue damage")
+ "\n\n" + ::MSU.Text.color(::Z.Color.BloodRed, "Decay: (Duration: 3, Stackable)")
+ "\n " + ::MSU.Text.color(::Z.Color.BloodRed, "On wait or turn end, inflict 5 damage");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellMarkofDecay].Name = ::Const.Strings.PerkName.SpellMarkofDecay;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellMarkofDecay].Tooltip = ::Const.Strings.PerkDescription.SpellMarkofDecay;

this.perk_spell_mark_of_decay <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.spell.mark_of_decay";
		this.m.Name = ::Const.Strings.PerkName.SpellMarkofDecay;
		this.m.Description = ::Const.Strings.PerkDescription.SpellMarkofDecay;
		this.m.Icon = "ui/perks/perk_04.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.spell.mark_of_decay"))
			this.m.Container.add(::new("scripts/skills/actives/spell_mark_of_decay"));
	}

});

