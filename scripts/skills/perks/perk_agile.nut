::Const.Strings.PerkName.Agile <- "Agile";
::Const.Strings.PerkDescription.Agile <- "Twist and dodge like a slippery snake"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("+10") + " Melee Defense"
+ "\n"+::MSU.Text.colorGreen("+10") + " Ranged Defense"
+ "\n"+::MSU.Text.colorRed("Invalid if a shield is equipped");

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

	function isEnabled()
	{
		local offhand = this.getContainer().getActor().getItems().getItemAtSlot(::Const.ItemSlot.Offhand);
		if (offhand != null && offhand.isItemType(::Const.Items.ItemType.Shield)) return false;
		return true;
	}

	function onUpdate( _properties )
	{
		if (!isEnabled()) return;
		_properties.MeleeDefense += 10;
		_properties.RangedDefense += 10;

	}

});

