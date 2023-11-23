::Const.Strings.PerkName.Duelist = "Duelist";
::Const.Strings.PerkDescription.Duelist = "Become one with your weapon..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Offhand empty or has throwable item:")
+ "\n" + ::MSU.Text.colorGreen("+25%") + " armor ignore"
+ "\n\n" + ::MSU.Text.colorRed("Bucklers and parrying daggers gain half of this bonus");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Duelist].Name = ::Const.Strings.PerkName.Duelist;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Duelist].Tooltip = ::Const.Strings.PerkDescription.Duelist;

this.perk_duelist <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.duelist";
		this.m.Name = ::Const.Strings.PerkName.Duelist;
		this.m.Description = ::Const.Strings.PerkDescription.Duelist;
		this.m.Icon = "skills/passive_03.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local items = this.getContainer().getActor().getItems();
		local off = items.getItemAtSlot(::Const.ItemSlot.Offhand);

		if (this.getContainer().hasSkill("injury.missing_hand") || off == null && !items.hasBlockedSlot(::Const.ItemSlot.Offhand) || off != null && off.isItemType(::Const.Items.ItemType.Tool))
		{
			_properties.DamageDirectAdd += 0.25;
		}

		if (off != null)
		{
			if (off.getID() == "weapon.legend_parrying_dagger" || off.getID() == "shield.buckler" || off.getID() == "weapon.legend_hand_crossbow")
			{
				_properties.DamageDirectAdd += 0.12;
			}
		}
	}

});

