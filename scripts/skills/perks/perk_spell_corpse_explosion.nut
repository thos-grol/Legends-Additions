::Const.Strings.PerkName.SpellCorpseExplosion <- "Corpse Explosion";
::Const.Strings.PerkDescription.SpellCorpseExplosion <- "A forbidden spell dangerous to both the caster and their enemies..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Corpse Explosion\' (9 AP, 20 Fat, 9 Mana):")
+ "\n Explode an undead and deal X*0.33 to X damage to all units in surrounding tiles"
+ "\n "+::MSU.Text.colorRed("The caster takes 1 to X*0.33 damage as backlash. X is that undead's hp");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellCorpseExplosion].Name = ::Const.Strings.PerkName.SpellCorpseExplosion;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.SpellCorpseExplosion].Tooltip = ::Const.Strings.PerkDescription.SpellCorpseExplosion;

this.perk_spell_corpse_explosion <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.spell.corpse_explosion";
		this.m.Name = ::Const.Strings.PerkName.SpellCorpseExplosion;
		this.m.Description = ::Const.Strings.PerkDescription.SpellCorpseExplosion;
		this.m.Icon = "ui/perks/perk_04.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.spell.corpse_explosion"))
			this.m.Container.add(::new("scripts/skills/actives/spell_corpse_explosion"));
	}

});

