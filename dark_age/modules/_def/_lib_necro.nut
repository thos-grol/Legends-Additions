//this function imprints the living's information on the corpse for use
::Z.Lib.imprint_corpse <- function(_actor, _tile)
{
    // if (_actor.getFlags().has("abomination")) return;

    local corpse = _tile.Properties.get("Corpse");
    if (corpse == null) return;
    corpse.Tile = _tile;

    corpse.Skills <- [];
    corpse.BaseProperties <- {};
    // corpse.FleshNotAllowed <- true; //this marker determines if raising flesh is disallowed

    local skills = _actor.m.Skills.m.Skills
    foreach(skill in skills)
    {
        if (!skill.isGarbage() && skill.m.ID in ::Z.Map) corpse.Skills.push(skill);
    }

    corpse.BaseProperties["Bravery"] <- _actor.m.BaseProperties.Bravery;
    corpse.BaseProperties["Initiative"] <- _actor.m.BaseProperties.Initiative;
    corpse.BaseProperties["MeleeSkill"] <- _actor.m.BaseProperties.MeleeSkill;
    corpse.BaseProperties["RangedSkill"] <- _actor.m.BaseProperties.RangedSkill;
    corpse.BaseProperties["MeleeDefense"] <- _actor.m.BaseProperties.MeleeDefense;
    corpse.BaseProperties["RangedDefense"] <- _actor.m.BaseProperties.RangedDefense;
    corpse.BaseProperties["Armor"] <- _actor.m.BaseProperties.Armor;

    if (!corpse.IsResurrectable)
    {
        if (corpse.BaseProperties["MeleeSkill"] >= corpse.BaseProperties["RangedSkill"])
            corpse.Type = "scripts/entity/tactical/enemies/flesh_abomination";
        else corpse.Type = "scripts/entity/tactical/enemies/flesh_abomination_ranged";
    }
}

::Z.Lib.apply_miasma <- function(_tile, _entity)
{
    this.Tactical.spawnIconEffect("decay", _tile, this.Const.Tactical.Settings.SkillIconOffsetX, this.Const.Tactical.Settings.SkillIconOffsetY, this.Const.Tactical.Settings.SkillIconScale, this.Const.Tactical.Settings.SkillIconFadeInDuration, this.Const.Tactical.Settings.SkillIconStayDuration, this.Const.Tactical.Settings.SkillIconFadeOutDuration, this.Const.Tactical.Settings.SkillIconMovement);
    local sounds = [];

    if (_entity.getFlags().has("human"))
    {
        sounds = [
            "sounds/humans/human_coughing_01.wav",
            "sounds/humans/human_coughing_02.wav",
            "sounds/humans/human_coughing_03.wav",
            "sounds/humans/human_coughing_04.wav"
        ];
    }
    else
    {
        sounds = [
            "sounds/enemies/miasma_appears_01.wav",
            "sounds/enemies/miasma_appears_02.wav",
            "sounds/enemies/miasma_appears_03.wav"
        ];
    }

    this.Sound.play(sounds[this.Math.rand(0, sounds.len() - 1)], this.Const.Sound.Volume.Actor, _entity.getPos());


    local tile_effect = _tile.Properties.Effect;
    local decay = ::new("scripts/skills/effects/decay_effect");
    decay.setActor(tile_effect.Actor);
    decay.setDamage((tile_effect.Damage));
    target.getSkills().add(decay);

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
            if (_info.Name.len() != 0) this.m.Name = "Flesh Abomination (" + _info.Name + ")";
            else if (_info.CorpseName.len() != 0) this.m.Name = "Flesh Abomination (" + _info.CorpseName + ")";

            if (_info.Description.len() != 0)
            {
                this.m.Description = _info.Description;
            }
        }

        if ("Skills" in _info)
        {
            foreach(skill in _info.Skills)
            {
                if (!getSkills().hasSkill(skill.m.ID)) getSkills().add(skill)
            }
        }

        if ("BaseProperties" in _info)
        {
            this.m.BaseProperties.Bravery = _info.BaseProperties["Bravery"];
            this.m.BaseProperties.Initiative = _info.BaseProperties["Initiative"];
            this.m.BaseProperties.MeleeSkill = _info.BaseProperties["MeleeSkill"];
            this.m.BaseProperties.RangedSkill = _info.BaseProperties["RangedSkill"];
            this.m.BaseProperties.MeleeDefense = _info.BaseProperties["MeleeDefense"];
            this.m.BaseProperties.RangedDefense = _info.BaseProperties["RangedDefense"];
        }

        this.m.Skills.update();

	}

});