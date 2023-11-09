//TODO: PERK corpse explosion

::Const.Strings.PerkName.SpellCorpseExplosion <- "Resilient";
::Const.Strings.PerkDescription.SpellCorpseExplosion <- "Blink and you miss me..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("– 1 duration for negative status effects")
+ "\n"+::MSU.Text.colorGreen("+8") + " Hitpoints"
+ "\n"+::MSU.Text.colorGreen("+33%") + " chance to survive being struck down (Base: 33%)";

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

	function onUpdate( _properties )
	{
		_properties.NegativeStatusEffectDuration += -1;
		_properties.Hitpoints += 8;
		_properties.SurviveWithInjuryChanceMult *= 2.0;
	}

});

