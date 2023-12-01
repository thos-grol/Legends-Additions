::Const.Strings.PerkName.LegendSpecCultArmor = "Penance"
// ::Const.Strings.PerkDescription.LegendSpecCultHood = "With face obscured by a cultist hood, gain " + ::MSU.Text.colorGreen( 15 ) + "% of your base resolve as a bonus to melee and ranged defense. Also works with cultist leather hood, leather helmet, sack, decayed sack helm, warlock hood or mask of davkul.\n Also unlocks a crafting recipe to make cultist hoods and sacks.";

::Const.Strings.PerkDescription.LegendSpecCultArmor = "One has wounds but cannot be wounded..."+
"\n\n[color=" + ::Const.UI.Color.Passive + "]Passive:[/color]" +
"\n• Morale is no longer affected by allies dying or by taking damage." +
"\n• Garuntees that this character will survive if struck down with no fatalities until they have more than 4 permanent injuries." +
"\n• Reduce the effects that permenant injuries has on this character or transform the injury in some eldritch way.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecCultArmor].Tooltip = ::Const.Strings.PerkDescription.LegendSpecCultArmor;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecCultArmor].Icon = "ui/perks/penance_circle2.png";

::mods_hookExactClass("skills/perks/perk_legend_specialist_cult_armor", function (o)
{
    o.create = function()
	{
		this.m.ID = "perk.legend_specialist_cult_armor";
		this.m.Name = ::Const.Strings.PerkName.LegendSpecCultArmor;
		this.m.Description = "Reduce the effects that permenant injuries has on this character or transform the injury in some eldritch way. This character is no longer affected by allies dying or losing hitpoints.";
		this.m.Icon = "ui/perks/penance_circle2.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

    o.isHidden = function() { return false; }

	o.onUpdate = function( _properties ) 
	{
		_properties.IsAffectedByDyingAllies = false;
		_properties.IsAffectedByLosingHitpoints = false;

		local count = 0;
		local actor = this.getContainer().getActor();
        local skills = actor.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);
        foreach( s in skills )
        {
            if (s.isType(::Const.SkillType.PermanentInjury)) count += 1;
        }

		if (count < 4) _properties.SurviveWithInjuryChanceMult *= 100.0;
	}
});