::Const.Strings.PerkName.LegendBlendIn = "Sneak Attack";
::Const.Strings.PerkDescription.LegendBlendIn = ::MSU.Text.color(::Z.Log.Color.Purple, "[u]Destiny[/u]")
+ "\n"+"If you notice me, you're already dead..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "[u]Passive:[/u]")
+ "\n"+ ::MSU.Text.colorGreen("– 90%") + " target attraction. Makes it less likely to be targeted for an attack."
+ "\n\n"+ ::MSU.Text.colorGreen("+25%") + " melee damage"
+ "\n"+ ::MSU.Text.colorGreen("+20%") + " armor penetration"
+ "\n"+ ::MSU.Text.colorRed("Invalid if this unit started their turn next to the target")
+ "\n\n"+ ::MSU.Text.colorGreen("+25%") + " ranged damage"
+ "\n"+ ::MSU.Text.colorGreen("+20%") + " armor penetration"
+ "\n"+ ::MSU.Text.colorRed("Invalid if this target has been hit before")

+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Purple, "You may only pick 1 destiny");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendBlendIn].Name = ::Const.Strings.PerkName.LegendBlendIn;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendBlendIn].Tooltip = ::Const.Strings.PerkDescription.LegendBlendIn;

this.perk_legend_blend_in <- this.inherit("scripts/skills/skill", {
	m = {
		Enemies = [],
		EnemiesHitWithRanged = []
	},
	function create()
	{
		this.m.ID = "perk.legend_blend_in";
		this.m.Name = this.Const.Strings.PerkName.LegendBlendIn;
		this.m.Description = this.Const.Strings.PerkDescription.LegendBlendIn;
		this.m.Icon = "ui/perks/perk_42.png";
		this.m.Type = this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 0.1;
	}

	function onTurnStart()
	{
		this.m.Enemies.clear();
		local actor = this.getContainer().getActor();

		foreach (tile in ::MSU.Tile.getNeighbors(actor.getTile()))
		{
			if (tile.IsOccupiedByActor) this.m.Enemies.push(tile.getEntity().getID());
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null) return;

		if (!_skill.isRanged())
		{
			if (this.m.Enemies.find(_targetEntity.getID()) == null)
			{
				_properties.DamageDirectAdd += 0.2;
				_properties.DamageTotalMult *= 1.25;
				this.m.Enemies.push(_targetEntity.getID());
			}
		}
		else
		{
			if (this.m.EnemiesHitWithRanged.find(_targetEntity.getID()) == null)
			{
				_properties.DamageDirectAdd += 0.2;
				_properties.DamageTotalMult *= 1.25;
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity == null) return;

		local success = false;
		if (!_skill.isRanged())
		{
			local idx = this.m.Enemies.find(_targetEntity.getID());
			if (idx == null)
			{
				success = true;
				this.m.Enemies.push(_targetEntity.getID());
			}
		}
		else if (this.m.EnemiesHitWithRanged.find(_targetEntity.getID()) == null)
		{
			success = true;
			this.m.EnemiesHitWithRanged.push(_targetEntity.getID());
		}

		if (success) ::Tactical.EventLog.logIn(::Const.UI.getColorizedEntityName(this.getContainer().getActor()) + " performed a Sneak Attack");
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		local targetEntity = _targetTile.getEntity();
		if (targetEntity == null) return;

		if ((!_skill.isRanged() && this.m.Enemies.find(targetEntity.getID()) == null) ||
			(_skill.isRanged() && this.m.EnemiesHitWithRanged.find(targetEntity.getID()) == null))
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = this.getName()
			});
		}
	}

	function onTurnEnd()
	{
		this.m.Enemies.clear();
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Enemies.clear();
		this.m.EnemiesHitWithRanged.clear();
	}

});

