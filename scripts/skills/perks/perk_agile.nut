::Const.Strings.PerkName.Agile <- "Agile";
::Const.Strings.PerkDescription.Agile <- "Twist and dodge like a slippery snake"
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
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
		this.m.Name = this.Const.Strings.PerkName.Agile;
		this.m.Description = this.Const.Strings.PerkDescription.Agile;
		this.m.Icon = "ui/perks/twirl_circle.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isEnabled()
	{
		local offhand = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		if (offhand =! null && !offhand.isItemType(::Const.Items.ItemType.Shield)) return false;
		return true;
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 10;
		_properties.RangedDefense += 10;
	}

});

