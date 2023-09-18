this.perk_ptr_a_better_grip <- this.inherit("scripts/skills/skill", {
	m = {
		DamageMultAtTwoTiles = 0.80,
		BonusPerStack = 5,
		MaxStacks = 4,
		Opponents = {}
	},
	function create()
	{
		this.m.ID = "perk.ptr_a_better_grip";
		this.m.Name = this.Const.Strings.PerkName.PTRABetterGrip;
		this.m.Description = "This character is using %their% spear to great effect, manifesting %their% advantage in combat.";
		this.m.Icon = "ui/perks/ptr_a_better_grip.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function isHidden()
	{
		return this.m.Opponents.len() == 0;
	}

	function getTooltip()
	{
		local tooltip = this.skill.getTooltip();

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/icons/plus.png",
			text = "Increased Melee Skill and Melee Defense"
		});

		foreach (id, stacks in this.m.Opponents)
		{
			local opponent = this.Tactical.getEntityByID(id);
			if (opponent != null && opponent.isAlive() && opponent.isPlacedOnMap())
			{
				tooltip.push({
					id = 10,
					type = "text",
					icon = "ui/orientation/" + opponent.getOverlayImage() + ".png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.getBonus(id) + "[/color] against " + opponent.getName()
				});
			}
		}

		tooltip.push({
			id = 10,
			type = "text",
			icon = "ui/tooltips/warning.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]The bonus against an opponent expires upon receiving damage from that opponent[/color]"
		});

		return tooltip;
	}

	function getBonus( _entityID )
	{
		return ::Math.floor(this.m.Opponents[_entityID] * this.m.BonusPerStack);
	}
	
	function isEnabled()
	{
		local weapon = this.getContainer().getActor().getMainhandItem();
		return weapon != null && weapon.isWeaponType(this.Const.Items.WeaponType.Spear);
	}

	function onAfterUpdate(_properties)
	{
		if (this.isEnabled() && this.getContainer().getActor().isDoubleGrippingWeapon())
		{
			local s = this.getContainer().getSkillByID("actives.thrust");
			if (s != null) s.m.MaxRange += 1;
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker != null && (_attacker.getID() in this.m.Opponents))
		{
			delete this.m.Opponents[_attacker.getID()];
		}
	}

	function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
	{
		if (!this.isEnabled() || !_skill.isAttack()) return;

		if  (_targetEntity.isAlive())
		{
			if (!(_targetEntity.getID() in this.m.Opponents)) this.m.Opponents[_targetEntity.getID()] <- 1;
			else this.m.Opponents[_targetEntity.getID()] = ::Math.min(this.m.MaxStacks, this.m.Opponents[_targetEntity.getID()] + 1);
		}
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		if (_attacker.getID() in this.m.Opponents)
		{
			_properties.MeleeDefense += this.getBonus(_attacker.getID());
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (!this.isEnabled() || !_skill.isAttack() || _targetEntity == null) return;
		
		if (_skill.getID() == "actives.thrust")
		{
			if (_targetEntity != null && this.getContainer().getActor().isDoubleGrippingWeapon())
			{
				local targetTile = _targetEntity.getTile();
				local myTile = this.getContainer().getActor().getTile();

				if (myTile.getDistanceTo(targetTile) == 2)
				{
					_properties.DamageTotalMult *= this.m.DamageMultAtTwoTiles;

					local betweenTiles = [];
					local malus = _skill.m.HitChanceBonus;
					
					for (local i = 0; i < 6; i++)
					{
						if (targetTile.hasNextTile(i))
						{
							local nextTile = targetTile.getNextTile(i);
							if (nextTile.getDistanceTo(myTile) == 1)
							{
								betweenTiles.push(nextTile);
								if (betweenTiles.len() == 2)
								{
									break;
								}
							}
						}
					}

					foreach (tile in betweenTiles)
					{
						if (tile.IsOccupiedByActor)
						{
							malus += 20;
						}
					}

					_skill.m.HitChanceBonus -= malus;
					_properties.MeleeSkill -= malus;
				}
			}
		}

		if (_targetEntity.getID() in this.m.Opponents)
		{
			_properties.MeleeSkill += this.getBonus(_targetEntity.getID());
		}
	}

	function onGetHitFactors( _skill, _targetTile, _tooltip )
	{
		if (_targetTile.getEntity().getID() in this.m.Opponents)
		{
			_tooltip.push({
				icon = "ui/tooltips/positive.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + this.getBonus(_targetTile.getEntity().getID()) + "%[/color] " + this.getName()
			});
		}
	}

	function onQueryTooltip( _skill, _tooltip )
	{
		if (_skill.getID() == "actives.thrust")
		{
			if (this.getContainer().getActor().isDoubleGrippingWeapon())
			{
				foreach (entry in _tooltip)
				{
					if (entry.text.find("chance to hit") != null)
					{
						entry.text += " adjacent targets";
						break;
					}
				}

				_tooltip.push(
					{
						id = 6,
						type = "text",
						icon = "ui/icons/hitchance.png",
						text = "Has [color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color] chance to hit per character between you and the target"
					}
				);

				_tooltip.push(
					{
						id = 6,
						type = "text",
						icon = "ui/icons/damage_dealt.png",
						text = "When attacking at a distance of 2 tiles, damage is reduced by [color=" + this.Const.UI.Color.NegativeValue + "]20%[/color]"
					}
				);
			}
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.Opponents.clear();
	}
});
