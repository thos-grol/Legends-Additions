::Const.Strings.PerkName.LegendBlendIn = "Sneak Attack";
::Const.Strings.PerkDescription.LegendBlendIn = ::MSU.Text.color(::Z.Log.Color.Purple, "Destiny")
+ "\n"+"If you notice me, you're already dead..."
+ "\n\n" + ::MSU.Text.color(::Z.Log.Color.Blue, "Passive:")
+ "\n"+ ::MSU.Text.colorGreen("– 90%") + " target attraction"
+ "\n"+ ::MSU.Text.colorRed("Makes it much less likely to be targeted for an attack")
+ "\n\n"+ ::MSU.Text.colorGreen("+25%") + " melee damage"
+ "\n"+ ::MSU.Text.colorGreen("+20%") + " armor penetration"
+ "\n"+ ::MSU.Text.colorRed("Invalid if this unit started their turn next to the target")
+ "\n\n"+ ::MSU.Text.colorGreen("+25%") + " ranged damage"
+ "\n"+ ::MSU.Text.colorGreen("+20%") + " armor penetration"
+ "\n"+ ::MSU.Text.colorRed("Invalid if this target has been hit before");

::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendBlendIn].Name = ::Const.Strings.PerkName.LegendBlendIn;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendBlendIn].Tooltip = ::Const.Strings.PerkDescription.LegendBlendIn;
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendBlendIn].Icon = "ui/perks/sneak_attack.png";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendBlendIn].IconDisabled = "ui/perks/sneak_attack_bw.png";

this.perk_legend_blend_in <- this.inherit("scripts/skills/skill", {
	m = {
		Enemies = [],
		EnemiesHitWithRanged = []
	},
	function create()
	{
		this.m.ID = "perk.legend_blend_in";
		this.m.Name = ::Const.Strings.PerkName.LegendBlendIn;
		this.m.Description = ::Const.Strings.PerkDescription.LegendBlendIn;
		this.m.Icon = "ui/perks/perk_42.png";
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
		_properties.TargetAttractionMult *= 0.1;
	}

	function onTurnStart()
	{
		this.m.Enemies.clear();
		local actor = this.getContainer().getActor();

		foreach (tile in ::Z.getNeighbors(actor.getTile()))
		{
			if (tile.IsOccupiedByActor && !tile.getEntity().isAlliedWithPlayer()) this.m.Enemies.push(tile.getEntity().getID());
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

