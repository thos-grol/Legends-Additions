this.grazed_kidney_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.grazed_kidney";
		this.m.Name = "Grazed Kidney";
		this.m.Description = "Abdominal pain, blood in the urine and always the danger of infection. A grazed kidney is a severe risk to the life of any character, draining their constitution.";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_37";
		this.m.Icon = "ui/injury/injury_icon_37.png";
		this.m.IconMini = "injury_icon_37_mini";
		this.m.InfectionChance = 3.0;
		this.m.HealingTimeMin = 3;
		this.m.HealingTimeMax = 6;
		this.m.IsShownOnBody = true;
	}

	function getTooltip()
	{
		local ret = [
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
				id = 7,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-60%[/color] Hitpoints"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onAdded()
	{
		this.injury.onAdded();

		if (!("State" in this.Tactical) || this.Tactical.State == null)
		{
			return;
		}

		local p = this.getContainer().getActor().getCurrentProperties();

		if (!p.IsAffectedByInjuries || this.m.IsFresh && !p.IsAffectedByFreshInjuries)
		{
			return;
		}

		if (this.getContainer().getActor().getHitpointsPct() > 0.4)
		{
			this.getContainer().getActor().setHitpoints(this.getContainer().getActor().getHitpointsMax() * 0.4);
		}
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);

		if (this.m.IsShownOutOfCombat)
		{
			_properties.HitpointsMult *= 0.4;
		}
	}

});

