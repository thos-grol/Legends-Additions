::Const.Strings.PerkName.SpellReanimate <- "Reanimate";
::Const.Strings.PerkDescription.SpellReanimate <- "Undead rise!..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Reanimate\' (6 AP, 20 Fat, 2 Mana):")
+ "\n Reanimate an undead to fight for the caster. The undead will keep it's stats and perks in life, except for Hitpoints."
+ "\n "+::MSU.Text.colorRed("Undead are resistant to damage. If a weiderganger cannot be resurrected will create a flesh abomination instead");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellReanimate].Name = ::Const.Strings.PerkName.SpellReanimate;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellReanimate].Tooltip = ::Const.Strings.PerkDescription.SpellReanimate;

this.perk_spell_reanimate <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.spell.reanimate";
		this.m.Name = ::Const.Strings.PerkName.SpellReanimate;
		this.m.Description = ::Const.Strings.PerkDescription.SpellReanimate;
		this.m.Icon = "ui/perks/perk_04.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.spell.reanimate"))
			this.m.Container.add(::new("scripts/skills/actives/spell_reanimate"));
	}

});

