::mods_hookExactClass("entity/tactical/enemies/legend_stollwurm", function (o)
{
    local onInit = o.onInit;
    o.onInit = function()
    {
        onInit();
        this.m.Skills.add(::new("scripts/skills/passives/dragons_might"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_battle_forged"));
        this.m.Skills.add(::new("scripts/skills/perks/perk_ptr_man_of_steel"));
    }
});