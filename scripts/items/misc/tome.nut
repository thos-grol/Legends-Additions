//FEATURE_0: TOME create tome data structure
this.tome <- this.inherit("scripts/items/item", {
	m = {
        Tome = ""
    },
	function create()
	{
		this.item.create();
		this.m.ID = "misc.tome";
		this.m.Name = "Tome";
		this.m.Description = "A well preserved tome";
		this.m.Icon = "loot/inventory_loot_08.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc | this.Const.Items.ItemType.Loot;
		this.m.IsDroppedAsLoot = true;
		this.m.Value = 595;
	}

    //FEATURE_0: TOME function getData()

    function getData()
    {

    }

    function set_tome(_str) //called on enemy drops
    {
        this.m.Tome = _str;
    }

    //////////////////////

	function getName()
    {
        return //FEATURE_0 TOME get Name:
    }

    function getTooltip()
	{
		//FEATURE_0: TOME getTooltip
        local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/combat/armor_leather_impact_03.wav", this.Const.Sound.Volume.Inventory);
	}

    //FEATURE_0: TOME serialize type

});

