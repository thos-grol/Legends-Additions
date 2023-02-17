::Const.Strings.PerkName.LegendSpecCultHood = "Devotion"
// ::Const.Strings.PerkDescription.LegendSpecCultHood = "With face obscured by a cultist hood, gain " + ::MSU.Text.colorGreen( 15 ) + "% of your base resolve as a bonus to melee and ranged defense. Also works with cultist leather hood, leather helmet, sack, decayed sack helm, warlock hood or mask of davkul.\n Also unlocks a crafting recipe to make cultist hoods and sacks.";

::Const.Strings.PerkDescription.LegendSpecCultHood = "In Pain we find the truth of ourselves. We have no identity beyond servitude, our glory is agony."+
"\n\n[color=" + ::Const.UI.Color.Passive + "][u]Passive:[/u][/color]" +
"\n• With face obscured by a cultist hood, gain " + ::MSU.Text.colorGreen( 15 ) + "% of your base resolve as a bonus to melee and ranged defense." +
"\n• Unwillingness to avoid pain decreases the effectiveness of the Dodge to 5% of initiative." + 
"\n• Each permenant injury increases this bonus by  " + ::MSU.Text.colorGreen( "5%" ) +
"\n• Also works with cultist leather hood, leather helmet, sack, decayed sack helm, warlock hood or mask of davkul." +
"\n• Unlocks a crafting recipe to make cultist hoods and sacks.";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecCultHood].Name = ::Const.Strings.PerkName.LegendSpecCultHood;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecCultHood].Tooltip = ::Const.Strings.PerkDescription.LegendSpecCultHood;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendSpecCultHood].Icon = "ui/perks/dedication_circle2.png";

::mods_hookExactClass("skills/perks/perk_legend_specialist_cult_hood", function (o)
{
    o.create = function()
	{
		this.m.ID = "perk.legend_specialist_cult_hood";
		this.m.Name = ::Const.Strings.PerkName.LegendSpecCultHood;
		this.m.Description = ::Const.Strings.PerkDescription.LegendSpecCultHood;
		this.m.Icon = "ui/perks/dedication_circle2.png";
		this.m.Type = ::Const.SkillType.Perk | ::Const.SkillType.StatusEffect;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

    o.getTooltip <- function()
	{
		local actor = this.getContainer().getActor();
        local resolve = actor.getCurrentProperties().getBravery();
        local multiplier = 0.15;
        local skills = actor.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);
        foreach( s in skills )
        {
            if (s.isType(::Const.SkillType.PermanentInjury)) multiplier += 0.05;
        }
        local total = this.Math.floor(resolve * multiplier);

		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = "In Pain we find the truth of ourselves. We have no identity beyond servitude, our glory is agony."
			},
            {
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = ::MSU.Text.colorGreen( multiplier * 100 ) + "% of resolve is added to defenses."
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "+" + ::MSU.Text.colorGreen( total ) + " Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "+" + ::MSU.Text.colorGreen( total ) + " Ranged Defense"
			}
		];

		if (actor.getSkills().hasSkill("perk.perk_legend_specialist_cult_armor"))
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Penance: This character's morale is no longer affected by their allies dying or by taking damage."
			});
		}

		return ret;
	}

    o.onAfterUpdate = function( _properties )
	{
		if (this.getCultistPieces().len() > 0)
		{
            local actor = this.getContainer().getActor();
            local resolve = actor.getCurrentProperties().getBravery();
            local multiplier = 0.15;
            local skills = actor.getSkills().getAllSkillsOfType(::Const.SkillType.Injury);

            foreach( s in skills )
            {
                if (s.isType(::Const.SkillType.PermanentInjury)) multiplier += 0.05;
            }

            local total = this.Math.floor(resolve * multiplier);

			_properties.MeleeDefense += total;
			_properties.RangedDefense += total;
		}
	}
});

::mods_hookExactClass("skills/effects/dodge_effect", function (o)
{
	o.getTooltip = function()
	{
		local actor = this.getContainer().getActor();
		local initiative = this.Math.floor(actor.getInitiative() * (actor.getSkills().hasSkill("perk.legend_specialist_cult_hood") ? 0.05 : 0.15));
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + initiative + "[/color] Melee Defense"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + ::Const.UI.Color.PositiveValue + "]+" + initiative + "[/color] Ranged Defense"
			}
		];
	}

	o.onAfterUpdate = function( _properties )
	{
		local actor = this.getContainer().getActor();
		local initiative = this.Math.floor(actor.getInitiative() * (actor.getSkills().hasSkill("perk.legend_specialist_cult_hood") ? 0.05 : 0.15));
		_properties.MeleeDefense += this.Math.max(0, initiative);
		_properties.RangedDefense += this.Math.max(0, initiative);
	}

});