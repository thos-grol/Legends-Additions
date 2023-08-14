//Feature: undetected caravan robbery
::mods_hookExactClass("factions/city_state_faction", function (o)
{
    local addPlayerRelation = o.addPlayerRelation;
    o.addPlayerRelation = function(_r, _reason = "")
    {
        local chance_detection = this.Math.max(5, 60 - ::LA.get_subterfuge_chance());
        if (_reason == "Attacked them" && this.Math.rand(1.0, 100.0) > chance_detection) return;
        addPlayerRelation(_r, _reason);
    }
});

::mods_hookExactClass("factions/noble_faction", function (o)
{
    local addPlayerRelation = o.addPlayerRelation;
    o.addPlayerRelation = function(_r, _reason = "")
    {
        local chance_detection = this.Math.max(5, 60 - ::LA.get_subterfuge_chance());
        if (_reason == "Attacked them" && this.Math.rand(1, 100) > chance_detection) return;
        addPlayerRelation(_r, _reason);
    }
});

::mods_hookExactClass("factions/settlement_faction", function (o)
{
    local addPlayerRelation = o.addPlayerRelation;
    o.addPlayerRelation = function(_r, _reason = "")
    {
        local chance_detection = this.Math.max(5, 60 - ::LA.get_subterfuge_chance());
        if (_reason == "Attacked them" && this.Math.rand(1, 100) > chance_detection) return;
        addPlayerRelation(_r, _reason);
    }
});