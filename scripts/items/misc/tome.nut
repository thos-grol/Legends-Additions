//TODO: test
this.tome <- this.inherit("scripts/items/item", {
	m = {
        Tome = ::MSU.Table.randValue(::B.Info.Tomes).ID
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
		this.m.Value = 1000;
	}

    function getData()
    {
		return ::B.Info.Tomes[this.m.Tome];
    }

    function set_tome(_str) //called on enemy drops
    {
        this.m.Tome = _str;
    }

    //////////////////////

	function getName()
    {
        return ::B.Info.Tomes[this.m.Tome].Name:
    }

	function getDescription()
    {
        return ::B.Info.Tomes[this.m.Tome].Description:
    }

    function getTooltip()
	{
        local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = "The gods are dead, the dharma has ended. Perhaps our last hope is blasphemy - absorb the weirdness and remnants of the gods as a pathway to ascension." + "\n\n" +this.getDescription()
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

	function onSerialize( _out )
	{
		this.item.onSerialize(_out);
		_out.writeString(this.m.Tome);
	}

	function onDeserialize( _in )
	{
		this.item.onDeserialize(_in);
		this.m.Tome = _in.readString();
	}

});
