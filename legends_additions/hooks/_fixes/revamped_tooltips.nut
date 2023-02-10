local modTacticalTooltip = function ( tooltip, _targetedWithSkill )
{
	if (tooltip.len() < 3)
	{
		return tooltip;
	}

	local shownPerks = {};
	local stackEffects = function ( effects )
	{
		local stacks = {};

		foreach( _, effect in effects )
		{
			local name = effect.getName();

			if (name in stacks)
			{
				stacks[name] += 1;
			}
			else
			{
				stacks[name] <- 1;
			}
		}

		return stacks;
	};
	local pushSectionName = function ( items, title, startID )
	{
		if (items.len() && title)
		{
			tooltip.push({
				id = startID,
				type = "text",
				text = "[u][size=14]" + title + "[/size][/u]"
			});
		}
	};
	local isPerk = function ( _, _skill )
	{
		return _skill.isType(this.Const.SkillType.Perk);
	};
	local isInjury = function ( _, _skill )
	{
		return _skill.isType(this.Const.SkillType.TemporaryInjury);
	};
	local isTextRow = function ( _, row )
	{
		return ("type" in row) && row.type == "text";
	};
	local pushSection = function ( items, title, startID, filter = 0, prependIcon = "", stackInOneLine = false )
	{
		if (!items)
		{
			return;
		}

		if (filter == 1)
		{
			items = items.filter(isPerk);
		}
		else if (filter == 2)
		{
			items = items.filter(function ( i, item )
			{
				return !isPerk(i, item);
			});
		}

		local stacks = {};

		if (stackInOneLine)
		{
			stacks = stackEffects(items);
			local newItems = [];
			local added = {};

			foreach( i, item in items )
			{
				local name = item.getName();

				if (!(name in added))
				{
					newItems.push(item);
					added[name] <- 1;
				}
			}

			items = newItems;
		}

		pushSectionName(items, title, startID);
		startID = startID + 1;

		foreach( i, item in items )
		{
			local name = item.getName();
			local text = name;

			if (filter != 0)
			{
				shownPerks[name] <- 1;
			}

			if (stackInOneLine && stacks[name] > 1)
			{
				text = text + (" [color=" + this.Const.UI.Color.NegativeValue + "]" + "x" + stacks[name] + "[/color]");
			}

			tooltip.push({
				id = startID + i,
				type = "text",
				icon = prependIcon + item.getIcon(),
				text = text
			});
		}
	};
	local removeDuplicates = function ( items )
	{
		if (!items)
		{
			return items;
		}

		return items.filter(function ( i, item )
		{
			return !(item.getName() in shownPerks);
		});
	};
	local getPlural = function ( items )
	{
		if (!items)
		{
			return "";
		}

		return items.len() > 1 ? "s" : "";
	};
	local patchedPerkIcons = {};
	patchedPerkIcons[this.Const.Strings.PerkName.BatteringRam] <- "ui/settlement_status/settlement_effect_13.png";
	local getRealPerkIcon = function ( perk )
	{
		local realPerk = this.Const.Perks.findById(perk.getID());

		if (realPerk)
		{
			return realPerk.Icon;
		}

		local name = perk.getName();

		if (name in patchedPerkIcons)
		{
			return patchedPerkIcons[name];
		}

		return perk.getIcon();
	};

	if (!this.isKindOf(this, "player"))
	{
		local _type = "progressbar";

		foreach( i, row in tooltip )
		{
			if (("type" in row) && row.type == _type && ("id" in row) && "icon" in row)
			{
				if (row.id == 5 && row.icon == "ui/icons/armor_head.png")
				{
					row.text <- "" + this.getArmor(this.Const.BodyPart.Head) + " / " + this.getArmorMax(this.Const.BodyPart.Head) + "";
				}
				else if (row.id == 6 && row.icon == "ui/icons/armor_body.png")
				{
					row.text <- "" + this.getArmor(this.Const.BodyPart.Body) + " / " + this.getArmorMax(this.Const.BodyPart.Body) + "";
				}
				else if (row.id == 7 && row.icon == "ui/icons/health.png")
				{
					row.text <- "" + this.getHitpoints() + " / " + this.getHitpointsMax() + "";
				}
				else if (row.id == 9 && row.icon == "ui/icons/fatigue.png")
				{
					row.text <- "" + this.getFatigue() + " / " + this.getFatigueMax() + "";
				}
			}
		}
	}

	local pushRemainingAP = function ()
	{
		local turnsToGo = this.Tactical.TurnSequenceBar.getTurnsUntilActive(this.getID());
		local remainingAP = this.m.IsTurnDone || turnsToGo == null ? 0 : this.getActionPoints();
		tooltip.push({
			id = 10,
			type = "progressbar",
			icon = "ui/icons/action_points.png",
			value = remainingAP,
			valueMax = this.getActionPointsMax(),
			text = "" + this.getActionPoints() + " / " + this.getActionPointsMax() + "",
			style = "action-points-slim"
		});
	};

	if (_targetedWithSkill != null && this.isKindOf(_targetedWithSkill, "skill"))
	{
		local tile = this.getTile();

		if (tile.IsVisibleForEntity && _targetedWithSkill.isUsableOn(tile))
		{
			tooltip.push({
				id = 2048,
				type = "hint",
				icon = "ui/icons/mouse_right_button.png",
				text = "Expand tooltip"
			});
			return tooltip;
		}
	}

	local statusEffects = this.getSkills().query(this.Const.SkillType.StatusEffect | this.Const.SkillType.TemporaryInjury, false, true);
	local count = tooltip.len() - statusEffects.len();

	if (statusEffects.len() && count > 0)
	{
		if (tooltip[count].text == statusEffects[0].getName())
		{
			tooltip.resize(count);
			pushRemainingAP();
			statusEffects = statusEffects.filter(function ( _, item )
			{
				return !isInjury(_, item);
			});
			statusEffects = removeDuplicates(statusEffects);
			pushSection(statusEffects, null, 100, 2, "", true);
			local injuries = this.getSkills().query(this.Const.SkillType.TemporaryInjury, false, true);

			foreach( i, injury in injuries )
			{
				local children = injury.getTooltip().filter(function ( _, row )
				{
					return isTextRow(_, row);
				});
				local addedTooltipHints = [];
				injury.addTooltipHint(addedTooltipHints);
				addedTooltipHints = addedTooltipHints.filter(function ( _, row )
				{
					return isTextRow(_, row);
				});
				local added_count = addedTooltipHints.len();

				if (added_count)
				{
					children.resize(children.len() - added_count);
				}

				local isUnderIronWill = function ()
				{
					local pattern = this.regexp("Iron Will");

					foreach( _, row in addedTooltipHints )
					{
						if (("text" in row) && pattern.search(row.text))
						{
							return true;
						}
					}

					return false;
				}();
				local injuryRow = {
					id = 133 + i,
					type = "text",
					icon = injury.getIcon(),
					text = injury.getName()
				};

				if (!isUnderIronWill)
				{
					injuryRow.children <- children;
				}
				else
				{
					injuryRow.text += "[color=" + this.Const.UI.Color.PositiveValue + "]" + " (Iron Will)[/color]";
				}

				tooltip.push(injuryRow);
					// [317]  OP_CLOSE          0     21    0    0
			}

			statusEffects = removeDuplicates(statusEffects);
			pushSection(statusEffects, "Status perks", 150, 1);
		}
		else
		{
			foreach( _, row in tooltip )
			{
				if (("type" in row) && row.type == "text" && "text" in row)
				{
					shownPerks[row.text] <- 1;
				}
			}
		}
	}
	else if (!statusEffects.len())
	{
		pushRemainingAP();
	}

	local activePerks = this.getSkills().query(this.Const.SkillType.Active, false, true);
	activePerks = removeDuplicates(activePerks);
	pushSection(activePerks, "Usable perks", 200, 1);
	local perks = this.getSkills().query(this.Const.SkillType.Perk, false, true);
	perks = removeDuplicates(perks);
	pushSectionName(perks, "Perks", 300);

	foreach( i, perk in perks )
	{
		tooltip.push({
			id = 301 + i,
			type = "text",
			icon = getRealPerkIcon(perk),
			text = perk.getName()
		});
	}

	local accessories = this.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Accessory);
	pushSection(accessories, "Accessory", 400, 0, "ui/items/");
	local ammos = this.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Ammo);
	pushSection(ammos, "Ammo", 500, 0, "ui/items/");
	local items = this.getItems().getAllItemsAtSlot(this.Const.ItemSlot.Bag);
	local itemsTitle = "Item" + getPlural(items) + " in bags";
	pushSection(items, itemsTitle, 600, 0, "ui/items/", true);
	local itemsOnGround = this.getTile().Items;
	pushSection(itemsOnGround, "Item" + getPlural(itemsOnGround) + " on ground", 700, 0, "ui/items/", true);

	//Push stats
	tooltip.push({
		id = 101,
		type = "hint",
		icon = "ui/icons/bravery.png",
		text = "" + this.getBravery()
	});
	tooltip.push({
		id = 102,
		type = "hint",
		icon = "ui/icons/initiative.png",
		text = "" + this.getInitiative()
	});
	tooltip.push({
		id = 103,
		type = "hint",
		icon = "ui/icons/melee_skill.png",
		text = "" + this.m.CurrentProperties.MeleeSkill
	});
	tooltip.push({
		id = 104,
		type = "hint",
		icon = "ui/icons/ranged_skill.png",
		text = "" + this.m.CurrentProperties.RangedSkill
	});
	tooltip.push({
		id = 105,
		type = "hint",
		icon = "ui/icons/melee_defense.png",
		text = "" + this.m.CurrentProperties.MeleeDefense
	});
	tooltip.push({
		id = 106,
		type = "hint",
		icon = "ui/icons/ranged_defense.png",
		text = "" + this.m.CurrentProperties.RangedDefense
	});
	return tooltip;
};

::mods_hookExactClass("entity/tactical/actor", function ( o )
{
	o.getTooltip_original <- function ( _targetedWithSkill = null )
	{
		if (!this.isPlacedOnMap() || !this.isAlive() || this.isDying()) return [];

		if (!this.isDiscovered())
		{
			local tooltip = [
				{
					id = 1,
					type = "title",
					text = "Hidden Opponent"
				}
			];
			return tooltip;
		}

		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName(),
				icon = this.getLevelImagePath()
			}
		];

		if (this.isHiddenToPlayer())
		{
			tooltip.push({
				id = 3,
				type = "headerText",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]Not currently in sight[/color]"
			});
		}
		else
		{
			if (_targetedWithSkill != null && this.isKindOf(_targetedWithSkill, "skill"))
			{
				local tile = this.getTile();

				if (tile.IsVisibleForEntity && _targetedWithSkill.isUsableOn(tile))
				{
					local hitchance = _targetedWithSkill.getHitchance(this);
					tooltip.push({
						id = 3,
						type = "headerText",
						icon = "ui/icons/hitchance.png",
						children = _targetedWithSkill.getHitFactors(tile),
						text = "[color=" + this.Const.UI.Color.PositiveValue + "]" + hitchance + "%[/color] chance to hit"
					});
				}
			}

			if (this.m.IsActingEachTurn)
			{
				local turnsToGo = this.Tactical.TurnSequenceBar.getTurnsUntilActive(this.getID());

				if (this.Tactical.TurnSequenceBar.getActiveEntity() == this)
				{
					tooltip.push({
						id = 4,
						type = "text",
						icon = "ui/icons/initiative.png",
						text = "Acting right now!"
					});
				}
				else if (this.m.IsTurnDone || turnsToGo == null)
				{
					tooltip.push({
						id = 4,
						type = "text",
						icon = "ui/icons/initiative.png",
						text = "Turn done"
					});
				}
				else
				{
					tooltip.push({
						id = 4,
						type = "text",
						icon = "ui/icons/initiative.png",
						text = "Acts in " + turnsToGo + (turnsToGo > 1 ? " turns" : " turn")
					});
				}
			}

			tooltip.push({
				id = 5,
				type = "progressbar",
				icon = "ui/icons/armor_head.png",
				value = this.getArmor(this.Const.BodyPart.Head),
				valueMax = this.getArmorMax(this.Const.BodyPart.Head),
				text = this.Const.ArmorStateName[this.getArmorState(this.Const.BodyPart.Head)],
				style = "armor-head-slim"
			});
			tooltip.push({
				id = 6,
				type = "progressbar",
				icon = "ui/icons/armor_body.png",
				value = this.getArmor(this.Const.BodyPart.Body),
				valueMax = this.getArmorMax(this.Const.BodyPart.Body),
				text = this.Const.ArmorStateName[this.getArmorState(this.Const.BodyPart.Body)],
				style = "armor-body-slim"
			});
			tooltip.push({
				id = 7,
				type = "progressbar",
				icon = "ui/icons/health.png",
				value = this.getHitpoints() >= 0 ? this.getHitpoints() : 0,
				valueMax = this.getHitpointsMax(),
				text = this.Const.HitpointsStateName[this.getHitpointsState()],
				style = "hitpoints-slim"
			});
			tooltip.push({
				id = 8,
				type = "progressbar",
				icon = "ui/icons/morale.png",
				value = this.getMoraleState(),
				valueMax = this.Const.MoraleState.COUNT - 1,
				text = this.Const.MoraleStateName[this.getMoraleState()],
				style = "morale-slim"
			});
			tooltip.push({
				id = 9,
				type = "progressbar",
				icon = "ui/icons/fatigue.png",
				value = this.getFatigue(),
				valueMax = this.getFatigueMax(),
				text = this.Const.FatigueStateName[this.getFatigueState()],
				style = "fatigue-slim"
			});
			local result = [];
			local statusEffects = this.getSkills().query(this.Const.SkillType.StatusEffect | this.Const.SkillType.TemporaryInjury, false, true);

			foreach( i, statusEffect in statusEffects )
			{
				tooltip.push({
					id = 100 + i,
					type = "text",
					icon = statusEffect.getIcon(),
					text = statusEffect.getName()
				});
			}
		}

		return tooltip;
	}

	o.getTooltip = function ( _targetedWithSkill = null )
	{
		return modTacticalTooltip(getTooltip_original(_targetedWithSkill), _targetedWithSkill);
	};
});

// {
// 	if (!this.isPlacedOnMap() || !this.isAlive() || this.isDying())
// 	{
// 		return [];
// 	}

// 	if (!this.isDiscovered())
// 	{
// 		local tooltip = [
// 			{
// 				id = 1,
// 				type = "title",
// 				text = "Hidden Opponent"
// 			}
// 		];
// 		return tooltip;
// 	}

// 	local tooltip = [
// 		{
// 			id = 1,
// 			type = "title",
// 			text = this.getName(),
// 			icon = this.getLevelImagePath()
// 		}
// 	];

// 	if (this.isHiddenToPlayer())
// 	{
// 		tooltip.push({
// 			id = 3,
// 			type = "headerText",
// 			icon = "ui/tooltips/warning.png",
// 			text = "[color=" + ::Const.UI.Color.NegativeValue + "]Not currently in sight[/color]"
// 		});
// 	}
// 	else
// 	{
// 		if (_targetedWithSkill != null && this.isKindOf(_targetedWithSkill, "skill"))
// 		{
// 			local tile = this.getTile();

// 			if (tile.IsVisibleForEntity && _targetedWithSkill.isUsableOn(tile))
// 			{
// 				local hitchance = _targetedWithSkill.getHitchance(this);
// 				tooltip.push({
// 					id = 3,
// 					type = "headerText",
// 					icon = "ui/icons/hitchance.png",
// 					children = _targetedWithSkill.getHitFactors(tile),
// 					text = "[color=" + ::Const.UI.Color.PositiveValue + "]" + hitchance + "%[/color] chance to hit"
// 				});
// 			}
// 		}

// 		if (this.m.IsActingEachTurn)
// 		{
// 			local turnsToGo = this.Tactical.TurnSequenceBar.getTurnsUntilActive(this.getID());

// 			if (this.Tactical.TurnSequenceBar.getActiveEntity() == this)
// 			{
// 				tooltip.push({
// 					id = 4,
// 					type = "text",
// 					icon = "ui/icons/initiative.png",
// 					text = "Acting right now!"
// 				});
// 			}
// 			else if (this.m.IsTurnDone || turnsToGo == null)
// 			{
// 				tooltip.push({
// 					id = 4,
// 					type = "text",
// 					icon = "ui/icons/initiative.png",
// 					text = "Turn done"
// 				});
// 			}
// 			else
// 			{
// 				tooltip.push({
// 					id = 4,
// 					type = "text",
// 					icon = "ui/icons/initiative.png",
// 					text = "Acts in " + turnsToGo + (turnsToGo > 1 ? " turns" : " turn")
// 				});
// 			}
// 		}

// 		tooltip.push({
// 			id = 5,
// 			type = "progressbar",
// 			icon = "ui/icons/armor_head.png",
// 			value = this.getArmor(::Const.BodyPart.Head),
// 			valueMax = this.getArmorMax(::Const.BodyPart.Head),
// 			text = ::Const.ArmorStateName[this.getArmorState(::Const.BodyPart.Head)],
// 			style = "armor-head-slim"
// 		});
// 		tooltip.push({
// 			id = 6,
// 			type = "progressbar",
// 			icon = "ui/icons/armor_body.png",
// 			value = this.getArmor(::Const.BodyPart.Body),
// 			valueMax = this.getArmorMax(::Const.BodyPart.Body),
// 			text = ::Const.ArmorStateName[this.getArmorState(::Const.BodyPart.Body)],
// 			style = "armor-body-slim"
// 		});
// 		tooltip.push({
// 			id = 7,
// 			type = "progressbar",
// 			icon = "ui/icons/health.png",
// 			value = this.getHitpoints() >= 0 ? this.getHitpoints() : 0,
// 			valueMax = this.getHitpointsMax(),
// 			text = ::Const.HitpointsStateName[this.getHitpointsState()],
// 			style = "hitpoints-slim"
// 		});
// 		tooltip.push({
// 			id = 8,
// 			type = "progressbar",
// 			icon = "ui/icons/morale.png",
// 			value = this.getMoraleState(),
// 			valueMax = ::Const.MoraleState.COUNT - 1,
// 			text = ::Const.MoraleStateName[this.getMoraleState()],
// 			style = "morale-slim"
// 		});
// 		tooltip.push({
// 			id = 9,
// 			type = "progressbar",
// 			icon = "ui/icons/fatigue.png",
// 			value = this.getFatigue(),
// 			valueMax = this.getFatigueMax(),
// 			text = ::Const.FatigueStateName[this.getFatigueState()],
// 			style = "fatigue-slim"
// 		});

// 		// if (tooltip.len() < 3)
// 		// {
// 		// 	return tooltip;
// 		// }

// 		local shownPerks = {};
// 		local stackEffects = function ( effects )
// 		{
// 			local stacks = {};

// 			foreach( _, effect in effects )
// 			{
// 				local name = effect.getName();

// 				if (name in stacks)
// 				{
// 					stacks[name] += 1;
// 				}
// 				else
// 				{
// 					stacks[name] <- 1;
// 				}
// 			}

// 			return stacks;
// 		};
// 		local pushSectionName = function ( items, title, startID )
// 		{
// 			if (items.len() && title)
// 			{
// 				tooltip.push({
// 					id = startID,
// 					type = "text",
// 					text = "[u][size=14]" + title + "[/size][/u]"
// 				});
// 			}
// 		};
// 		local isPerk = function ( _, _skill )
// 		{
// 			return _skill.isType(::Const.SkillType.Perk);
// 		};
// 		local isInjury = function ( _, _skill )
// 		{
// 			return _skill.isType(::Const.SkillType.TemporaryInjury);
// 		};
// 		local isTextRow = function ( _, row )
// 		{
// 			return ("type" in row) && row.type == "text";
// 		};
// 		//pushSection(statusEffects, null, 100, 2, "", true);
// 		local pushSection = function ( items, title, startID, filter = 0, prependIcon = "", stackInOneLine = false )
// 		{
// 			if (!items)
// 			{
// 				return;
// 			}

// 			if (filter == 1)
// 			{
// 				items = items.filter(isPerk);
// 			}
// 			else if (filter == 2)
// 			{
// 				items = items.filter(function ( i, item )
// 				{
// 					return !isPerk(i, item);
// 				});
// 			}

// 			local stacks = {};

// 			if (stackInOneLine)
// 			{
// 				stacks = stackEffects(items);
// 				local newItems = [];
// 				local added = {};

// 				foreach( i, item in items )
// 				{
// 					local name = item.getName();

// 					if (!(name in added))
// 					{
// 						newItems.push(item);
// 						added[name] <- 1;
// 					}
// 				}

// 				items = newItems;
// 			}

// 			pushSectionName(items, title, startID);
// 			startID = startID + 1;

// 			foreach( i, item in items )
// 			{
// 				local name = item.getName();
// 				local text = name;

// 				if (filter != 0)
// 				{
// 					shownPerks[name] <- 1;
// 				}

// 				if (stackInOneLine && stacks[name] > 1)
// 				{
// 					text = text + (" [color=" + ::Const.UI.Color.NegativeValue + "]" + "x" + stacks[name] + "[/color]");
// 				}

// 				tooltip.push({
// 					id = startID + i,
// 					type = "text",
// 					icon = prependIcon + item.getIcon(),
// 					text = text
// 				});
// 			}
// 		};
// 		local removeDuplicates = function ( items )
// 		{
// 			if (!items)
// 			{
// 				return items;
// 			}

// 			return items.filter(function ( i, item )
// 			{
// 				return !(item.getName() in shownPerks);
// 			});
// 		};
// 		local getPlural = function ( items )
// 		{
// 			if (!items)
// 			{
// 				return "";
// 			}

// 			return items.len() > 1 ? "s" : "";
// 		};
// 		local patchedPerkIcons = {};
// 		patchedPerkIcons[::Const.Strings.PerkName.BatteringRam] <- "ui/settlement_status/settlement_effect_13.png";
// 		local getRealPerkIcon = function ( perk )
// 		{
// 			local realPerk = ::Const.Perks.findById(perk.getID());

// 			if (realPerk)
// 			{
// 				return realPerk.Icon;
// 			}

// 			local name = perk.getName();

// 			if (name in patchedPerkIcons)
// 			{
// 				return patchedPerkIcons[name];
// 			}

// 			return perk.getIcon();
// 		};


// 		local _type = "progressbar";

// 		foreach( i, row in tooltip )
// 		{
// 			if (("type" in row) && row.type == _type && ("id" in row) && "icon" in row)
// 			{
// 				if (row.id == 5 && row.icon == "ui/icons/armor_head.png")
// 				{
// 					row.text <- "" + this.getArmor(::Const.BodyPart.Head) + " / " + this.getArmorMax(::Const.BodyPart.Head) + "";
// 				}
// 				else if (row.id == 6 && row.icon == "ui/icons/armor_body.png")
// 				{
// 					row.text <- "" + this.getArmor(::Const.BodyPart.Body) + " / " + this.getArmorMax(::Const.BodyPart.Body) + "";
// 				}
// 				else if (row.id == 7 && row.icon == "ui/icons/health.png")
// 				{
// 					row.text <- "" + this.getHitpoints() + " / " + this.getHitpointsMax() + "";
// 				}
// 				else if (row.id == 9 && row.icon == "ui/icons/fatigue.png")
// 				{
// 					row.text <- "" + this.getFatigue() + " / " + this.getFatigueMax() + "";
// 				}
// 			}
// 		}

// 		local pushRemainingAP = function ()
// 		{
// 			local turnsToGo = this.Tactical.TurnSequenceBar.getTurnsUntilActive(this.getID());
// 			local remainingAP = this.m.IsTurnDone || turnsToGo == null ? 0 : this.getActionPoints();
// 			tooltip.push({
// 				id = 10,
// 				type = "progressbar",
// 				icon = "ui/icons/action_points.png",
// 				value = remainingAP,
// 				valueMax = this.getActionPointsMax(),
// 				text = "" + this.getActionPoints() + " / " + this.getActionPointsMax() + "",
// 				style = "action-points-slim"
// 			});
// 		};

// 		if (_targetedWithSkill != null && this.isKindOf(_targetedWithSkill, "skill"))
// 		{
// 			local tile = this.getTile();

// 			if (tile.IsVisibleForEntity && _targetedWithSkill.isUsableOn(tile))
// 			{
// 				tooltip.push({
// 					id = 2048,
// 					type = "hint",
// 					icon = "ui/icons/mouse_right_button.png",
// 					text = "Expand tooltip"
// 				});
// 				return tooltip;
// 			}
// 		}

// 		local statusEffects = this.getSkills().query(::Const.SkillType.StatusEffect | ::Const.SkillType.TemporaryInjury, false, true);
// 		local count = tooltip.len() - statusEffects.len();

// 		if (statusEffects.len() && count > 0)
// 		{
// 			if (tooltip[count].text == statusEffects[0].getName())
// 			{
// 				tooltip.resize(count);
// 				pushRemainingAP();
// 				statusEffects = statusEffects.filter(function ( _, item )
// 				{
// 					return !isInjury(_, item);
// 				});
// 				statusEffects = removeDuplicates(statusEffects);
// 				pushSection(statusEffects, null, 100, 2, "", true);
// 				local injuries = this.getSkills().query(::Const.SkillType.TemporaryInjury, false, true);

// 				foreach( i, injury in injuries )
// 				{
// 					local children = injury.getTooltip().filter(function ( _, row )
// 					{
// 						return isTextRow(_, row);
// 					});
// 					local addedTooltipHints = [];
// 					injury.addTooltipHint(addedTooltipHints);
// 					addedTooltipHints = addedTooltipHints.filter(function ( _, row )
// 					{
// 						return isTextRow(_, row);
// 					});
// 					local added_count = addedTooltipHints.len();

// 					if (added_count)
// 					{
// 						children.resize(children.len() - added_count);
// 					}

// 					local isUnderIronWill = function ()
// 					{
// 						local pattern = this.regexp("Iron Will");

// 						foreach( _, row in addedTooltipHints )
// 						{
// 							if (("text" in row) && pattern.search(row.text))
// 							{
// 								return true;
// 							}
// 						}

// 						return false;
// 					}();
// 					local injuryRow = {
// 						id = 133 + i,
// 						type = "text",
// 						icon = injury.getIcon(),
// 						text = injury.getName()
// 					};

// 					if (!isUnderIronWill)
// 					{
// 						injuryRow.children <- children;
// 					}
// 					else
// 					{
// 						injuryRow.text += "[color=" + ::Const.UI.Color.PositiveValue + "]" + " (Iron Will)[/color]";
// 					}

// 					tooltip.push(injuryRow);
// 						// [317]  OP_CLOSE          0     21    0    0
// 				}

// 				statusEffects = removeDuplicates(statusEffects);
// 				pushSection(statusEffects, "Status perks", 150, 1);
// 			}
// 			else
// 			{
// 				foreach( _, row in tooltip )
// 				{
// 					if (("type" in row) && row.type == "text" && "text" in row)
// 					{
// 						shownPerks[row.text] <- 1;
// 					}
// 				}
// 			}
// 		}
// 		else if (!statusEffects.len())
// 		{
// 			pushRemainingAP();
// 		}

// 		//other stats
// 		tooltip.push({
// 			id = 101,
// 			type = "hint",
// 			icon = "ui/icons/bravery.png",
// 			text = "" + this.getBravery()
// 		});
// 		tooltip.push({
// 			id = 102,
// 			type = "hint",
// 			icon = "ui/icons/initiative.png",
// 			text = "" + this.getInitiative()
// 		});
// 		tooltip.push({
// 			id = 103,
// 			type = "hint",
// 			icon = "ui/icons/melee_skill.png",
// 			text = "" + this.m.CurrentProperties.MeleeSkill
// 		});
// 		tooltip.push({
// 			id = 104,
// 			type = "hint",
// 			icon = "ui/icons/ranged_skill.png",
// 			text = "" + this.m.CurrentProperties.RangedSkill
// 		});
// 		tooltip.push({
// 			id = 105,
// 			type = "hint",
// 			icon = "ui/icons/melee_defense.png",
// 			text = "" + this.m.CurrentProperties.MeleeDefense
// 		});
// 		tooltip.push({
// 			id = 106,
// 			type = "hint",
// 			icon = "ui/icons/ranged_defense.png",
// 			text = "" + this.m.CurrentProperties.RangedDefense
// 		});

// 		local activePerks = this.getSkills().query(::Const.SkillType.Active, false, true);
// 		activePerks = removeDuplicates(activePerks);
// 		pushSection(activePerks, "Usable perks", 200, 1);
// 		local perks = this.getSkills().query(::Const.SkillType.Perk, false, true);
// 		perks = removeDuplicates(perks);
// 		pushSectionName(perks, "Perks", 300);

// 		foreach( i, perk in perks )
// 		{
// 			tooltip.push({
// 				id = 301 + i,
// 				type = "text",
// 				icon = getRealPerkIcon(perk),
// 				text = perk.getName()
// 			});
// 		}

// 		local accessories = this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Accessory);
// 		pushSection(accessories, "Accessory", 400, 0, "ui/items/");
// 		local ammos = this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Ammo);
// 		pushSection(ammos, "Ammo", 500, 0, "ui/items/");
// 		local items = this.getItems().getAllItemsAtSlot(::Const.ItemSlot.Bag);
// 		local itemsTitle = "Item" + getPlural(items) + " in bags";
// 		pushSection(items, itemsTitle, 600, 0, "ui/items/", true);
// 		local itemsOnGround = this.getTile().Items;
// 		pushSection(itemsOnGround, "Item" + getPlural(itemsOnGround) + " on ground", 700, 0, "ui/items/", true);
// 	}

// 	return tooltip;
// };

