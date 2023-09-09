this.legend_hold_the_line <- this.inherit("scripts/skills/skill", {
	m = {
		Charges = 2
	},
	function create()
	{
		this.m.ID = "actives.legend_hold_the_line";
		this.m.Name = "Hold the line";
		this.m.Description = "Instruct your mercenaries to hold their ground! Grants the following bonuses to self and allies of your faction within 4 tiles.";
		this.m.Icon = "skills/holdtheline_square.png";
		this.m.IconDisabled = "skills/holdtheline_square_bw.png";
		this.m.Overlay = "holdtheline_square";
		this.m.SoundOnUse = [
			"sounds/combat/holdtheline_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.BeforeLast;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 9;
		this.m.FatigueCost = 25;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function isHidden()
	{
		this.m.Charges = 2;
	}

	function onCombatStarted()
	{
		this.m.Charges = 2;
		this.m.IsHidden = false;
	}

	function onCombatFinished()
	{
		this.m.Charges = 2;
		this.m.IsHidden = false;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getDefaultUtilityTooltip();
		tooltip.extend([
			{
				id = 6,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "Receive only [color=" + this.Const.UI.Color.PositiveValue + "]75%[/color] of any damage"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/locked_small.png",
				text = "Gain immunity to being knocked back or grabbed"
			}
		]);
		return tooltip;
	}

	function isUsable()
	{
		return this.skill.isUsable() && this.m.Charges > 0 && !this.getContainer().hasSkill("effects.legend_holding_the_line");
	}

	function onUse( _user, _targetTile )
	{
		this.m.Charges = this.Math.max(0, this.m.Charges - 1);
		if (this.m.Charges == 0) this.m.IsHidden = true;

		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID()) continue;
			if (myTile.getDistanceTo(a.getTile()) > 4) continue;
			if (a.getFaction() == _user.getFaction() && !a.getSkills().hasSkill("effects.holding_the_line"))
			{
				local effect = this.new("scripts/skills/effects/legend_holding_the_line");
				effect.setCommander(this.getContainer().getActor());
				a.getSkills().add(effect);
			}

			local offhand = a.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
			if (offhand != null && offhand.isItemType(this.Const.Items.ItemType.Shield))
			{
				if (!a.getSkills().hasSkill("effects.shieldwall"))
				{
					a.getSkills().add(this.new("scripts/skills/effects/shieldwall_effect"));
					::Tactical.EventLog.logIn(::Z.Log.display_basic(a, null, _skill_name, true));
				}
			}
		}

		local effect = this.new("scripts/skills/effects/legend_holding_the_line");
		effect.setCommander(this.getContainer().getActor());
		this.getContainer().add(effect);
		return true;
	}

});

