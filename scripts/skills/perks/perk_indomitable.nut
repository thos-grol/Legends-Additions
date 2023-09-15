::Const.Strings.PerkName.Indomitable = "Indomitable";
::Const.Strings.PerkDescription.Indomitable = "Indomitable, like the mountain..."
+ "\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "[u]Destiny[/u]")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]\'Indomitable\'[/u] (5 AP, 25 Fat):")
+ "\n" + ::MSU.Text.colorGreen("-50%") + " damage taken"
+ "\n" + ::MSU.Text.colorGreen("+Stun Immunity")
+ "\n" + ::MSU.Text.colorGreen("+Displacement Immunity")
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "When at or below 50% Hitpoints:")
+ "\n" + ::MSU.Text.colorGreen("Gain Indomitable without using the skill")
+ "\n\n" + ::MSU.Text.colorRed("This effect remains active even after the unit is healed over 50% Hitpoints")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "You may only pick 1 destiny");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Indomitable].Name = ::Const.Strings.PerkName.Indomitable;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Indomitable].Tooltip = ::Const.Strings.PerkDescription.Indomitable;

this.perk_indomitable <- this.inherit("scripts/skills/skill", {
	m = {
		On = false
	},
	function create()
	{
		this.m.ID = "perk.indomitable";
		this.m.Name = this.Const.Strings.PerkName.Indomitable;
		this.m.Description = this.Const.Strings.PerkDescription.Indomitable;
		this.m.Icon = "ui/perks/perk_30.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onAdded()
	{
		if (!this.m.Container.hasSkill("actives.indomitable"))
			this.m.Container.add(this.new("scripts/skills/actives/indomitable"));
	}

	function onRemoved()
	{
		this.m.Container.removeByID("actives.indomitable");
	}

	function onCombatStarted()
	{
		local projected_hitpoints_pct = (actor.getHitpoints() - _damageHitpoints) / actor.getHitpointsMax();
		if (projected_hitpoints_pct > 0.5) return;

		this.m.On = true;
		if (!this.getContainer().hasSkill("effects.indomitable"))
			this.m.Container.add(this.new("scripts/skills/effects/indomitable_effect"));
	}

	function onCombatFinished()
	{
		this.m.On = false;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (this.m.On) return;
		local actor = this.getContainer().getActor();
		local projected_hitpoints_pct = (actor.getHitpoints() - _damageHitpoints) / actor.getHitpointsMax();
		if (projected_hitpoints_pct > 0.5) return;

		this.m.On = true;
		if (!this.getContainer().hasSkill("effects.indomitable"))
			this.m.Container.add(this.new("scripts/skills/effects/indomitable_effect"));

	}

});

