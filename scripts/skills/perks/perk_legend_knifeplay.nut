::Const.Strings.PerkName.LegendKnifeplay = "Knifeplay";
::Const.Strings.PerkDescription.LegendKnifeplay = "Become proficient in daggers"
+"\n\n" + ::MSU.Text.color(::Z.Color.Blue, "Passive:")
+ "\n " + ::MSU.Text.colorGreen("– 33%") + " skill fatigue (Daggers)"
+ "\n " + ::MSU.Text.colorGreen("– 1") + " AP cost for Stab, Puncture and Deathblow"

+ "\n\n" + ::MSU.Text.color(::Z.Color.Blue, "\'Throw Knife\' (4 AP, 10 Fat, 3 Charges):")
+ "\nThrow a knife at the enemy, using the dagger's properties and the user's perks to calculate damage. Can be used in melee range"
+ "\nA dagger must be equipped or in the bag. Hybridization is applied in calculations";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendKnifeplay].Name = ::Const.Strings.PerkName.LegendKnifeplay;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendKnifeplay].Tooltip = ::Const.Strings.PerkDescription.LegendKnifeplay;

this.perk_legend_knifeplay <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_knifeplay";
		this.m.Name = ::Const.Strings.PerkName.LegendKnifeplay;
		this.m.Description = ::Const.Strings.PerkDescription.LegendKnifeplay;
		this.m.Icon = "ui/perks/knifeplay.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.legend_throw_knife"))
		{
			this.m.Container.add(::new("scripts/skills/actives/legend_throw_knife"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.legend_throw_knife");
	}

	function onUpdate( _properties )
	{
		_properties.IsSpecializedInDaggers = true;
	}

});


