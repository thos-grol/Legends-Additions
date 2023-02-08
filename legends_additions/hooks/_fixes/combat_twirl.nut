//Escape artist auto break free from nets on start of turn, also gives chance to dodge net using ranged defence.
::Const.Strings.PerkDescription.LegendTwirl = "Practice in physical movement with a partner has given the ability to take the lead and move someone\'s body in a twirling movement. The \'Rotation\' skill, it can now target enemies. If you don't have \'Rotation\', it will grant you the skill while this perk is active.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendTwirl].Tooltip = ::Const.Strings.PerkDescription.LegendTwirl;

::mods_hookExactClass("skills/perks/perk_legend_twirl", function (o)
{
    o.onAdded <- function()
	{
        if (!this.m.Container.hasSkill("actives.rotation"))
		{
			this.m.Container.add(::new("scripts/skills/actives/rotation"));
		}
	}

    o.onRemoved <- function()
	{
		this.m.Container.removeByID("actives.rotation");
	}
});