::Const.Strings.PerkName.Colossus = "Colossus";
::Const.Strings.PerkDescription.Colossus = "This character looms over their enemies..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.colorGreen("+25%") + " Hitpoints."
+ "\n" + ::MSU.Text.colorGreen("+Cull Immunity")
+ "\n" + ::MSU.Text.colorGreen("+Hits to the head no longer cause critical damage")
+ "\n" + ::MSU.Text.colorGreen("+Most attacks that would stun, now dazes")
+ "\n\n" + ::MSU.Text.colorRed("More hitpoints and lower damage taken reduce the chances of becoming injured");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Colossus].Name = ::Const.Strings.PerkName.Colossus;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Colossus].Tooltip = ::Const.Strings.PerkDescription.Colossus;

this.perk_colossus <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.colossus";
		this.m.Name = this.Const.Strings.PerkName.Colossus;
		this.m.Description = this.Const.Strings.PerkDescription.Colossus;
		this.m.Icon = "ui/perks/perk_06.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (actor.getHitpoints() == actor.getHitpointsMax())
		{
			actor.setHitpoints(this.Math.floor(actor.getHitpoints() * 1.25));
		}

		if (!this.m.Container.hasSkill("effects.steel_brow"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/steel_brow_effect"));
		}
	}

	function onRemoved()
	{
		this.m.Container.removeByID("effects.steel_brow");
	}


	function onUpdate( _properties )
	{
		_properties.HitpointsMult *= 1.25;
	}


});

