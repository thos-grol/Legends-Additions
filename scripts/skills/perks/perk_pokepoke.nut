::Const.Strings.PerkName.PokePoke <- "Poke Poke";
::Const.Strings.PerkDescription.PokePoke <- "Poke poke poke poke..."
+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Thrust, Glaive Slash, Prong:")
+ "\n " + ::MSU.Text.colorGreen("– 1") + " AP cost";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PokePoke].Name = ::Const.Strings.PerkName.PokePoke;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.PokePoke].Tooltip = ::Const.Strings.PerkDescription.PokePoke;

this.perk_pokepoke <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.pokepoke";
		this.m.Name = ::Const.Strings.PerkName.PokePoke;
		this.m.Description = ::Const.Strings.PerkDescription.PokePoke;
		this.m.Icon = "ui/perks/pokepoke.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAfterUpdate(_properties)
	{
		local skills = [];

		skills.push(this.getContainer().getSkillByID("actives.thrust"));
		skills.push(this.getContainer().getSkillByID("actives.legend_glaive_slash"));
		skills.push(this.getContainer().getSkillByID("actives.prong"));

		foreach (s in skills)
		{
			if (s != null && s.m.ActionPointCost > 0)
			{
				s.m.ActionPointCost -= 1;
			}
		}
	}
});

