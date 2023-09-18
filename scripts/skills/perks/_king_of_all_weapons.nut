this.perk_ptr_king_of_all_weapons <- this.inherit("scripts/skills/skill", {
	m = {
		IsForceEnabled = false,
		IsSpent = true,
		DamageReductionPercentage = 50,
		Skills = [
			"actives.thrust",
			"actives.prong"
		]
	},
	function create()
	{
		this.m.ID = "perk.ptr_king_of_all_weapons";
		this.m.Name = this.Const.Strings.PerkName.PTRKingOfAllWeapons;
		this.m.Description = "This character is highly skilled in spears and can perform a free attack during %their% turn.";
		this.m.Icon = "ui/perks/ptr_king_of_all_weapons.png";
		this.m.IconMini = "ptr_king_of_all_weapons_mini";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.IsSpent;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "The next Thrust or Prong attack costs [color=" + this.Const.UI.Color.PositiveValue + "]0[/color] Action Points, builds [color=" + this.Const.UI.Color.NegativeValue + "]0[/color] Fatigue but does [color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.DamageReductionPercentage + "%[/color] Damage"
		});

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/warning.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]Will be lost upon switching your weapon![/color]"
		});

		return tooltip;
	}

	// So that it shows upon AI entities even before their turn starts so that the player can see they have it.
	function onAdded()
	{
		if (!this.getContainer().getActor().isPlayerControlled() && this.isEnabled())
		{
			this.m.IsSpent = false;
		}
	}

	function isEnabled()
	{
		if (this.m.IsForceEnabled)
		{
			return true;
		}

		local weapon = this.getContainer().getActor().getMainhandItem();
		if (weapon == null || !weapon.isWeaponType(this.Const.Items.WeaponType.Spear) || this.getContainer().getSkillsByFunction((@(_skill) this.m.Skills.find(_skill.getID()) != null).bindenv(this)).len() == 0)
		{
			return false;
		}

		return true;
	}

	function onAfterUpdate(_properties)
	{
		if (this.m.IsSpent || !this.isEnabled() || !this.getContainer().getActor().isPlacedOnMap())
		{
			this.m.IsSpent = true;
			return;
		}

		local skills = this.getContainer().getSkillsByFunction((@(_skill) this.m.Skills.find(_skill.getID()) != null).bindenv(this));

		if (skills.len() == 0)
		{
			return;
		}

		foreach (s in skills)
		{
			if (s != null)
			{
				s.m.ActionPointCost -= s.m.ActionPointCost;
				s.m.FatigueCostMult *= 0;
			}
		}
	}

	function onAffordablePreview( _skill, _movementTile )
	{
		if (_skill != null)
		{
			foreach (skill in this.getContainer().getSkillsByFunction((@(_skill) this.m.Skills.find(_skill.getID()) != null).bindenv(this)))
			{
				this.modifyPreviewField(skill, "ActionPointCost", 0, false);
				this.modifyPreviewField(skill, "FatigueCostMult", 1, true);
			}
		}
	}

	function onAnySkillExecuted( _skill, _targetTile, _targetEntity, _forFree )
	{
		if (_targetEntity != null && 
			this.Tactical.TurnSequenceBar.getActiveEntity() != null && 
			this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID() && 
			this.m.Skills.find(_skill.getID()) != null
			)
		{
			this.m.IsSpent = true;
		}
	}

	function onPayForItemAction( _skill, _items )
	{
		foreach (item in _items)
		{
			if (item != null && item.getSlotType() == ::Const.ItemSlot.Mainhand)
			{
				this.m.IsSpent = true;
				return;
			}
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (this.m.IsSpent || this.m.IsHidden)
		{
			return;
		}

		if (this.m.Skills.find(_skill.getID()) != null)
		{
			local actor = this.getContainer().getActor();
			if (!actor.isPlacedOnMap() || this.Tactical.TurnSequenceBar.getActiveEntity() == null || this.Tactical.TurnSequenceBar.getActiveEntity().getID() != actor.getID())
			{
				return;
			}

			_properties.MeleeDamageMult *= this.m.DamageReductionPercentage * 0.01;
		}
	}

	function onTurnStart()
	{
		if (this.isEnabled())
		{
			this.m.IsSpent = false;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsSpent = true;
	}
});
