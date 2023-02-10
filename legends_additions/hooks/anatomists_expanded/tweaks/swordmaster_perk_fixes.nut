//Allows swordmaster perks to be used on npcs
::mods_hookExactClass("skills/perks/perk_ptr_swordmaster_abstract", function(o)
{
    o.onAdded = function()
	{
		if (this.getContainer().getActor().getFaction() != this.Const.Faction.Player) return;

		local equippedItem = this.getContainer().getActor().getMainhandItem();
		if (equippedItem != null)
		{
			this.getContainer().getActor().getItems().unequip(equippedItem);
			this.getContainer().getActor().getItems().equip(equippedItem);
		}

		if (!this.m.IsSet && this.perk_ptr_swordmaster_abstract.onAdded())
		{
			this.getContainer().getActor().getBackground().addPerkGroup(::Const.Perks.CleaverTree.Tree);
			this.getContainer().getActor().getBackground().removePerk(::Const.Perks.PerkDefs.SpecCleaver);
			this.getContainer().getActor().getBackground().removePerk(::Const.Perks.PerkDefs.PTRSwordlike);
			this.getContainer().getActor().getBackground().removePerk(::Const.Perks.PerkDefs.PTRMauler);
			this.m.IsSet = true;
		}
	}

    o.onEquip <- function( _item )
	{
		if (this.getContainer().getActor().getFaction() != this.Const.Faction.Player) return;

        if (!this.isEnabled() || _item.getSlotType() != ::Const.ItemSlot.Mainhand) return;

		if (!this.getContainer().hasSkill("actives.decapitate"))
		{
			_item.addSkill(this.new("scripts/skills/actives/decapitate"));
		}

		if (!this.getContainer().hasSkill("perk.ptr_sanguinary"))
		{
			local skill = ::new("scripts/skills/perks/perk_ptr_sanguinary");
			skill.m.IsSerialized = false;
			_item.addSkill(skill);
		}
		if (!this.getContainer().hasSkill("perk.ptr_bloodbath"))
		{
			local skill = ::new("scripts/skills/perks/perk_ptr_bloodbath");
			skill.m.IsSerialized = false;
			_item.addSkill(skill);
		}
	}

});