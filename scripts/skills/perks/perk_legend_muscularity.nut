::Const.Strings.PerkName.LegendMuscularity = "Muscularity";
::Const.Strings.PerkDescription.LegendMuscularity = "Put one's full weight into every blow..."
+ "\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "[u]Destiny[/u]")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n"+::MSU.Text.colorGreen("+25% of current Hitpoints") + " to Minimum and Maximum damage."

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "You may only pick 1 destiny");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].Name = ::Const.Strings.PerkName.LegendMuscularity;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendMuscularity].Tooltip = ::Const.Strings.PerkDescription.LegendMuscularity;

this.perk_legend_muscularity <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.legend_muscularity";
		this.m.Name = this.Const.Strings.PerkName.LegendMuscularity;
		this.m.Description = this.Const.Strings.PerkDescription.LegendMuscularity;
		this.m.Icon = "ui/perks/muscularity_circle.png";
		this.m.IconDisabled = "ui/perks/muscularity_circle_bw.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		local bodyHealth = this.getContainer().getActor().getHitpoints();
		_properties.DamageRegularMin += this.Math.min(50, this.Math.floor(bodyHealth * 0.25));
		_properties.DamageRegularMax += this.Math.min(50, this.Math.floor(bodyHealth * 0.25));
	}

});

