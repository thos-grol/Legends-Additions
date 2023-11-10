::Const.Strings.PerkName.SpellFleshServant <- "Flesh Servant";
::Const.Strings.PerkDescription.SpellFleshServant <- "Undead rise!..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Flesh Servant\' (4 AP, 20 Fat, 1 Mana):")
+ "\n";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellFleshServant].Name = ::Const.Strings.PerkName.SpellFleshServant;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellFleshServant].Tooltip = ::Const.Strings.PerkDescription.SpellFleshServant;

this.perk_spell_flesh_servant <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.spell.flesh_servant";
		this.m.Name = ::Const.Strings.PerkName.SpellFleshServant;
		this.m.Description = ::Const.Strings.PerkDescription.SpellFleshServant;
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

