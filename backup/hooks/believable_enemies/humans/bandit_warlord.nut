//bandits
::mods_hookExactClass("entity/tactical/enemies/legend_bandit_warlord", function (o)
{
    local onInit = o.onInit;
    o.onInit = function()
    {
        onInit();
        local roll = ::Math.rand(1.0, 100.0);
        if (roll <= 20.0)
        {
            if (roll <= 4.0) this.add_potion("ghoul", true);
            else if (roll <= 8.0) this.add_potion("ghoul", false);
            else if (roll <= 12.0) this.add_potion("orc", true);
            else if (roll <= 16.0) this.add_potion("orc", false);
            else if (roll <= 20.0) this.add_potion("necrosavant", true);
        }
    }

    local assignRandomEquipment = o.assignRandomEquipment;
    o.assignRandomEquipment = function()
    {
        assignRandomEquipment();
        if (this.actor.getFlags().has("orc_8"))
        {
            local weapons = [
                "weapons/greenskins/orc_axe",
                "weapons/greenskins/orc_cleaver",
                "weapons/greenskins/orc_axe_2h",
                "weapons/greenskins/orc_axe_2h"
            ];

            if (this.m.Items.getItemAtSlot(::Const.ItemSlot.Mainhand).isNamed())
            {
                weapons = [
                    "weapons/named/named_orc_cleaver",
                    "weapons/named/named_orc_axe_2h",
                    "weapons/named/named_orc_flail_2h",
                    "weapons/named/named_orc_axe"
                ];
            }

            this.m.Items.unequip(this.m.Items.getItemAtSlot(::Const.ItemSlot.Mainhand));
            this.m.Items.unequip(this.m.Items.getItemAtSlot(::Const.ItemSlot.Offhand));

            this.m.Items.equip(::new("scripts/items/" + weapons[::Math.rand(0, weapons.len() - 1)]));
        }
    }
});