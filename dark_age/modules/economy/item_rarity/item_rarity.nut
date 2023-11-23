::mods_hookNewObject("items/item_container", function ( o )
{
    local equip = o.equip;
    o.equip = function ( _item )
    {
        if (_item == null) return false;
        try {
            _item.roll_values();
        } catch(exception) {}
        return equip(_item);
    };
});

