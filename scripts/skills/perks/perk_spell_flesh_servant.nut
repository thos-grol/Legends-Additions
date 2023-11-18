::Const.Strings.PerkName.SpellFleshServant <- "Flesh Servant";
::Const.Strings.PerkDescription.SpellFleshServant <- "Bind flesh to server!..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Bind Flesh Servant\' (6 AP, 20 Fat, 2 Mana):")
+ "\nBinds any valid corpse as a flesh servant to be summoned. The servant keeps the dead's perks and stats."
+ "\n "+::MSU.Text.colorRed("Usable once per battle")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "\'Summon Flesh Servant\' (6 AP, 20 Fat, 2 Mana):")
+ "\nSummons the bound flesh servant"
+ "\n "+::MSU.Text.colorRed("Usable once per battle")
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
		if (!this.m.Container.hasSkill("actives.spell.flesh_servant_bind"))
			this.m.Container.add(::new("scripts/skills/actives/spell_flesh_servant_bind"));

		if (!this.m.Container.hasSkill("actives.spell.flesh_servant_summon"))
			this.m.Container.add(::new("scripts/skills/actives/spell_flesh_servant_summon"));
	}

});

