::mods_hookExactClass("entity/tactical/enemies/legend_bandit_veteran", function (o)
{
    local onInit = o.onInit;
    o.onInit = function()
    {
        onInit();
        local roll = ::Math.rand(1.0, 100.0);
        if (roll <= 15.0)
        {
            if (roll <= 5.0) this.add_potion("ghoul", true);
            else if (roll <= 10.0) this.add_potion("direwolf", false);
            else if (roll <= 15.0) this.add_potion("direwolf", true);
        }
    }
});