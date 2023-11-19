::Const.Strings.PerkName.SpellHaunt <- "Haunt";
::Const.Strings.PerkDescription.SpellHaunt <- "Undead rise!..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Reanimate\' (4 AP, 20 Fat, 1 Mana):")
+ "\n";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellHaunt].Name = ::Const.Strings.PerkName.SpellHaunt;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellHaunt].Tooltip = ::Const.Strings.PerkDescription.SpellHaunt;

this.perk_spell_haunt <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.spell.haunt";
		this.m.Name = ::Const.Strings.PerkName.SpellHaunt;
		this.m.Description = ::Const.Strings.PerkDescription.SpellHaunt;
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

