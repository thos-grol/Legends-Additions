//this function imprints the living's information on the corpse for use
::Z.Lib.imprint_corpse <- function(_actor, _tile)
{
    local corpse = _tile.Properties.get("Corpse");

    corpse.Skills <- [];
    corpse.BaseProperties <- {};
    // corpse.FleshNotAllowed <- true; //this marker determines if raising flesh is disallowed

    local skills = _actor.m.Skills.m.Skills
    foreach(skill in skills)
    {
        if (!skill.isGarbage()) corpse.Skills.push(skill);
    }

    corpse.BaseProperties["Bravery"] <- _actor.m.BaseProperties.Bravery;
    corpse.BaseProperties["Initiative"] <- _actor.m.BaseProperties.Initiative;
    corpse.BaseProperties["MeleeSkill"] <- _actor.m.BaseProperties.MeleeSkill;
    corpse.BaseProperties["RangedSkill"] <- _actor.m.BaseProperties.RangedSkill;
    corpse.BaseProperties["MeleeDefense"] <- _actor.m.BaseProperties.MeleeDefense;
    corpse.BaseProperties["RangedDefense"] <- _actor.m.BaseProperties.RangedDefense;

    if (!corpse.IsResurrectable)
    {
        if (corpse.BaseProperties["MeleeSkill"] >= corpse.BaseProperties["RangedSkill"])
            corpse.Type = "scripts/entity/tactical/enemies/flesh_abomination";
        else corpse.Type = "scripts/entity/tactical/enemies/flesh_abomination_ranged";
    }
}

::mods_hookExactClass("entity/tactical/actor", function (o)
{
	o.onResurrected = function( _info )
	{
		this.setFaction(_info.Faction);

        if (_info.IsResurrectable)
		{
            this.getItems().clear();
            _info.Items.transferTo(this.getItems());

            if (_info.Name.len() != 0)
            {
                this.m.Name = _info.Name;
            }

            if (_info.Description.len() != 0)
            {
                this.m.Description = _info.Description;
            }

            this.m.Hitpoints = this.getHitpointsMax() * _info.Hitpoints;
            this.m.XP = this.Math.floor(this.m.XP * _info.Hitpoints);
            this.m.BaseProperties.Armor = _info.Armor;
            this.onUpdateInjuryLayer();
		}
        else
        {
            if (_info.Name.len() != 0)
            {
                this.m.Name = "Flesh Abomination (" + _info.Name + ")";
            }

            if (_info.Description.len() != 0)
            {
                this.m.Description = _info.Description;
            }
        }

        if ("Skills" in _info)
        {
            foreach(skill in corpse.Skills)
            {
                getSkills().add(skill)
            }
        }

        if ("BaseProperties" in _info)
        {
            this.m.BaseProperties.Bravery = corpse.BaseProperties["Bravery"];
            this.m.BaseProperties.Initiative = corpse.BaseProperties["Initiative"];
            this.m.BaseProperties.MeleeSkill = corpse.BaseProperties["MeleeSkill"];
            this.m.BaseProperties.RangedSkill = corpse.BaseProperties["RangedSkill"];
            this.m.BaseProperties.MeleeDefense = corpse.BaseProperties["MeleeDefense"];
            this.m.BaseProperties.RangedDefense = corpse.BaseProperties["RangedDefense"];
        }

        this.m.Skills.update();

	}

});