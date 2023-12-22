this.antidote_item <- this.inherit("scripts/items/accessory/alchemy_potion", {
	m = {},
	function create()
	{
		this.alchemy_potion.create();
		this.m.ID = "accessory.antidote";
		this.m.Name = "Antidote";
		this.m.Description = "An antidote for various types of poisons. Tastes quite bitter.";
		this.m.SlotType = ::Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/antidote_01.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 150;
	}

	function getTooltip()
	{
		local result = this.accessory.getTooltip();
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", ::Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.accessory.onEquip();
		local skill = this.new("scripts/skills/actives/drink_antidote_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

});

