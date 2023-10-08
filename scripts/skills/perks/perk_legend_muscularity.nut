::Const.Strings.PerkName.LegendMuscularity = "Muscularity";
::Const.Strings.PerkDescription.LegendMuscularity = ::MSU.Text.color(::Z.Log.Color.Purple, "Destiny")
+ "\n"+"Put one's full weight into every blow..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+::MSU.Text.colorGreen("+25% of current Hitpoints") + " to Minimum and Maximum damage"
+ "\n"+::MSU.Text.colorRed("+100%") + " target attraction, due to being huge";

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].Name = ::Const.Strings.PerkName.LegendMuscularity;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].Tooltip = ::Const.Strings.PerkDescription.LegendMuscularity;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].Icon = "ui/perks/muscularity.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].IconDisabled = "ui/perks/muscularity_bw.png";

this.perk_legend_muscularity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_muscularity";
		this.m.Name = ::Const.Strings.PerkName.LegendMuscularity;
		this.m.Description = ::Const.Strings.PerkDescription.LegendMuscularity;
		this.m.Icon = "ui/perks/muscularity_circle.png";
		this.m.IconDisabled = "ui/perks/muscularity_circle_bw.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		actor.getFlags().set("Destiny", true);
	}

	function onUpdate( _properties )
	{
		local bodyHealth = this.getContainer().getActor().getHitpoints();
		_properties.DamageRegularMin += this.Math.min(50, this.Math.floor(bodyHealth * 0.25));
		_properties.DamageRegularMax += this.Math.min(50, this.Math.floor(bodyHealth * 0.25));
		_properties.TargetAttractionMult *= 2.0;
	}

});

