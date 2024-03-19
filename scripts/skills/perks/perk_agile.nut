::Const.Strings.PerkName.Agile <- "Might";
::Const.Strings.PerkDescription.Agile <- "Crush your enemies with your might"
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+25%") + " Strength"
+ "\n" + ::MSU.Text.colorGreen("+Exempt from orc weapon penalty");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Agile].Name = ::Const.Strings.PerkName.Agile;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Agile].Tooltip = ::Const.Strings.PerkDescription.Agile;

this.perk_agile <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.agile";
		this.m.Name = ::Const.Strings.PerkName.Agile;
		this.m.Description = ::Const.Strings.PerkDescription.Agile;
		this.m.Icon = "ui/perks/twirl_circle.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		this.getContainer().getActor().getCurrentProperties().IsProficientWithHeavyWeapons = true;
		local equippedItem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}

		equippedItem = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}
	}

	function onUpdate( _properties )
	{
		_properties.IsProficientWithHeavyWeapons = true;
		_properties.RangedSkillMult *= 1.25;

	}

});

