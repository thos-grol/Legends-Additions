::Const.Strings.PerkName.WinterMage <- "Winter Mage";
::Const.Strings.PerkDescription.WinterMage <- ::MSU.Text.color(::Z.Log.Color.Purple, "Class")
+ "\nWinter is the principle of silence, of endings, and of those things that are not quite dead"
+ "\nAn ingenious formula that converts actuality into spirituality"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\nVitality Conversion: " + ::MSU.Text.colorRed("-25") + " Hitpoints"
+ "\n" + ::MSU.Text.colorGreen("1") + " Mana & Mana pool"
+ "\nEnables the casting of Winter aspect magic";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.WinterMage].Name = ::Const.Strings.PerkName.WinterMage;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.WinterMage].Tooltip = ::Const.Strings.PerkDescription.WinterMage;

this.perk_class_winter_mage <- this.inherit("scripts/skills/skill", {
	m = {
	},
	function create()
	{
		this.m.ID = "perk.class.winter_mage";
		this.m.Name = ::Const.Strings.PerkName.WinterMage;
		this.m.Description = ::Const.Strings.PerkDescription.WinterMage;
		this.m.Icon = "ui/perks/perk_29.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.Hitpoints -= 25;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("neutral", true);
		actor.getFlags().set("winter", true);

		if (!this.m.Container.hasSkill("trait.mana_pool"))
			this.m.Container.add(::new("scripts/skills/traits/mana_pool_trait"));


	}

});