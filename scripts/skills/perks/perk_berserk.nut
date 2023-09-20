::Const.Strings.PerkName.Berserk = "Brutality";
::Const.Strings.PerkDescription.Berserk = "Go berserk, brutalize them, destroy them..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Upon killing an enemy:")
+ "\n" + ::MSU.Text.colorGreen("+4") + " AP, "  + ::MSU.Text.colorRed("cannot exceed the max")
+ "\n\n"+::MSU.Text.colorRed("After the first kill, only fatalities will provide AP. This clause resets each turn");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Berserk].Name = ::Const.Strings.PerkName.Berserk;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.Berserk].Tooltip = ::Const.Strings.PerkDescription.Berserk;

this.perk_berserk <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "perk.berserk";
		this.m.Name = this.Const.Strings.PerkName.Berserk;
		this.m.Description = this.Const.Strings.PerkDescription.Berserk;
		this.m.Icon = "ui/perks/perk_35.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onTargetKilled( _targetEntity, _skill )
	{
		local actor = this.getContainer().getActor();

		if (actor.isAlliedWith(_targetEntity))
		{
			return;
		}

		if (!this.m.IsSpent && this.Tactical.TurnSequenceBar.getActiveEntity() != null && this.Tactical.TurnSequenceBar.getActiveEntity().getID() == actor.getID())
		{
			this.m.IsSpent = true;
			actor.setActionPoints(this.Math.min(actor.getActionPointsMax(), actor.getActionPoints() + 4));
			actor.setDirty(true);
			this.spawnIcon("perk_35", this.m.Container.getActor().getTile());
		}
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

	function onCombatStarted()
	{
		this.m.IsSpent = false;
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.1;
	}

});

