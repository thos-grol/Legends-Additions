this.getroottable().anatomists_expanded.hook_effects <- function ()
{
	//"Enhanced Eye Rods";
	//"This character\'s eyes have mutated to respond faster and more drastically to low light environments. As a result, they have night vision nearly on par with their sight during the day.";
	::mods_hookExactClass("skills/effects/alp_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/morale.png",
					text = "Not affected by nighttime penalties" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+2[/color] Vision"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			onUpdate(_properties);
			_properties.Vision += 2;
		}
	});
	
	//"Synapse Blockage";
	//"This character\'s body has mutated in such a way that their fight-or-flight response is altered. In high stress situations, their limbic system is simply refused resources for flight, making them effectively unbreakable in the battle line.";
	::mods_hookExactClass("skills/effects/ancient_priest_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/morale.png",
					text = "Morale cannot be reduced below Steady\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Resolve"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local function onUpdate(_properties)
		{
			_properties.Bravery += 10;
		}

		::mods_addMember(o, "ancient_priest_potion_effect", "onUpdate", onUpdate);
	});

	//"Elasticized Sinew";
	//"This character\'s muscles have mutated and respond differently to movement impulses. It is much less fatiguing to interrupt or stop mid-motion as a consequence, making it much easier to recover from errant or blocked attacks.";
	::mods_hookExactClass("skills/effects/direwolf_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/morale.png",
					text = "Attacks that miss have [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] of their Fatigue cost refunded" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local function onUpdate(_properties)
		{
			_properties.Stamina += 10;
		}
		::mods_addMember(o, "direwolf_potion_effect", "onUpdate", onUpdate);

	});

	//"Reactive Muscle Tissue";
	//"This character\'s body reacts to physical trauma, secreting a calciferous substance that causes their muscles to reflexively sieze and contract at points of impact to minimize muscle damage.";
	::mods_hookExactClass("skills/effects/fallen_hero_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/morale.png",
					text = "This character accumulates no Fatigue from enemy attacks, whether they hit or miss\n" + "[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			onUpdate(_properties);
			_properties.Hitpoints += 10;
		}
	});


	//"Kinetic Coating";
	//"This character is able to secrete a substance that vibrates rapidly when stimulated. When applied to weapons, this creates a strong kinetic force that aids in armor penetration.";
	::mods_hookExactClass("skills/effects/geist_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/morale.png",
					text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]10%[/color] of damage ignores armor when using melee weapons"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			_properties.DamageDirectMeleeAdd += 0.10;
		}
	});

	//"Reactive Leg Muscles";
	//"This character\'s legs have been mutated, allowing them to make swift, complex movements more smoothly and with greater rapidity. When at rest, the muscles can still occasionally be seen twitching underneath the skin.";
	::mods_hookExactClass("skills/effects/goblin_grunt_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/action_points.png",
					text = "The Action Point costs of the Rotation and Footwork skills are reduced to [color=" + this.Const.UI.Color.PositiveValue + "]2[/color]"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "The Fatigue costs of the Rotation and Footwork skills are reduced by [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color] Initiative"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			onUpdate(_properties);
			_properties.Initiative += 5;
		}
	});

	//"Mutated Cornea";
	//"This character\'s eyes have been permanently mutated and are now capable of detecting the subtlest movements of wind and air. While minor on its own, this allows them to better predict the trajectory of projectile attacks and better land hits on vulnerable parts of a target.";
	::mods_hookExactClass("skills/effects/goblin_overseer_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/morale.png",
					text = "An additional [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] of damage ignores armor when using bows or crossbows" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Ranged Skill"  + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color] Ranged Defense"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			_properties.IsSharpshooter = true;
			_properties.RangedSkill += 10;
			_properties.RangedDefense += 15;
		}
	});
	
	//sharpshooter changes
		::mods_hookExactClass("skills/actives/aimed_shot", function (o)
		{
			local onAnySkillUsed = ::mods_getMember(o, "onAnySkillUsed");
			o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
			{
				onAnySkillUsed( _skill, _targetEntity, _properties);
				if (_skill == this && _properties.IsSharpshooter) _properties.DamageDirectMult += 0.1;
			}
		});

		::mods_hookExactClass("skills/actives/quick_shot", function (o)
		{
			local onAnySkillUsed = ::mods_getMember(o, "onAnySkillUsed");
			o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
			{
				onAnySkillUsed( _skill, _targetEntity, _properties);
				if (_skill == this && _properties.IsSharpshooter) _properties.DamageDirectMult += 0.1;
			}
		});

		::mods_hookExactClass("skills/actives/shoot_bolt", function (o)
		{
			local onAnySkillUsed = ::mods_getMember(o, "onAnySkillUsed");
			o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
			{
				onAnySkillUsed( _skill, _targetEntity, _properties);
				if (_skill == this && _properties.IsSharpshooter) _properties.DamageDirectMult += 0.1;
			}
		});

		::mods_hookExactClass("skills/actives/shoot_stake", function (o)
		{
			local onAnySkillUsed = ::mods_getMember(o, "onAnySkillUsed");
			o.onAnySkillUsed = function(_skill, _targetEntity, _properties)
			{
				onAnySkillUsed( _skill, _targetEntity, _properties);
				if (_skill == this && _properties.IsSharpshooter) _properties.DamageDirectMult += 0.1;
			}
		});

	//"Subdermal Stitching";
	//"This character\'s skin and subdermal tissue has mutated and will rapidly stitch itself back together. The effect is most pronounced on small puncture wounds, where the flesh can seal the wound from all directions evenly.";
	::mods_hookExactClass("skills/effects/honor_guard_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/morale.png",
					text = "This character takes between [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] and [color=" + this.Const.UI.Color.PositiveValue + "]50%[/color] less damage from piercing attacks, such as those from bows or spears" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"  
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local function onUpdate(_properties)
		{
			_properties.Hitpoints += 10;
		}
		::mods_addMember(o, "honor_guard_potion_effect", "onUpdate", onUpdate);

	});

	//"Subdermal Clotting"
	//"When this character\'s skin is broken, a substance is secreted that drastically quickens the blood clotting process in the area. Bleeding wounds are much less harmful as a result, although some blood loss still occurs.";
	::mods_hookExactClass("skills/effects/hyena_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "Damage received from the Bleeding status effect is reduced by [color=" + this.Const.UI.Color.NegativeValue + "]50%[/color]"  
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Hitpoints"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local function onUpdate(_properties)
		{
			_properties.Hitpoints += 10;
		}
		::mods_addMember(o, "hyena_potion_effect", "onUpdate", onUpdate);

	});


	//"Acidic blood";
	//"This character\'s blood is highly pressurized and burns upon prolonged exposure to air. Attackers who break skin will find themselves unpleasantly surprised by the resultant spray.";

	::mods_hookExactClass("skills/effects/lindwurm_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				}
			];
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "This character\'s blood burns with acid, damaging adjacent attackers whenever they deal hitpoint damage"
			});

			if (this.getContainer().getActor().getFlags().has("wurm_8"))
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 30 + "[/color] Hitpoints"
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "Attacks do [color=" + this.Const.UI.Color.PositiveValue + "]+30%[/color] additional damage"
				});
			}
			
			ret.push({
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
			});

			return ret;
		}

		local function onUpdate(_properties)
		{
			if (this.getContainer().getActor().getFlags().has("wurm_8"))
			{
				_properties.Hitpoints += 30;
				_properties.DamageTotalMult *= 1.30;
			}
		}
		::mods_addMember(o, "lindwurm_potion_effect", "onUpdate", onUpdate);
	});

	//"Hyperactive Tissue Growth";
	//"This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal. Deep injuries heal much faster than normal as a result. They also seem to have developed a strong taste for red meat, but that\'s probably unrelated.";
	::mods_hookExactClass("skills/effects/nachzehrer_potion_effect", function (o)
	{
		
		local getDescription = ::mods_getMember(o, "getDescription");
		o.getDescription = function()
		{
			return "This character\'s body has mutated to regrow skin and muscle tissue much more quickly than normal and they gain the speed of nachzehrer. Deep injuries heal much faster than normal as a result. They also seem to have developed a hunger for red meat, but that\'s probably unrelated.";
		}
		
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				}
			];
			
			if (this.getContainer().getActor().getFlags().has("ghoul_8"))
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/days_wounded.png",
					text = "Reduces the time it takes to heal from any injury by one day, down to a mininum of one day."
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 20 + "[/color] Initiative"
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/days_wounded.png",
					text = "Reduces the time it takes to heal from any injury by one day, down to a mininum of one day."
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Initiative"
				});
			}
			
			ret.push({
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
			});
			return ret;
		}

		local function onUpdate(_properties)
		{
			if (this.getContainer().getActor().getFlags().has("ghoul_8"))
			{
				_properties.Initiative += 20;
			}
			else
			{
				_properties.Initiative += 10;
			}
			
		}
		::mods_addMember(o, "nachzehrer_potion_effect", "onUpdate", onUpdate);

	});

	::mods_hookExactClass("skills/actives/legend_gruesome_feast", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.Description = "Feast on a corpse to regain health and cure injuries. Will daze and disgust any non-mutated ally within four tiles.";
			this.m.ActionPointCost = 6;
			this.m.FatigueCost = 25;
		}
		
		local onUse = ::mods_getMember(o, "onUse");
		o.onUse = function(_user, _targetTile)
		{
			_targetTile = _user.getTile();

		if (_targetTile.IsVisibleForPlayer)
		{
			if (this.Const.Tactical.GruesomeFeastParticles.len() != 0)
			{
				for( local i = 0; i < this.Const.Tactical.GruesomeFeastParticles.len(); i = i )
				{
					this.Tactical.spawnParticleEffect(false, this.Const.Tactical.GruesomeFeastParticles[i].Brushes, _targetTile, this.Const.Tactical.GruesomeFeastParticles[i].Delay, this.Const.Tactical.GruesomeFeastParticles[i].Quantity, this.Const.Tactical.GruesomeFeastParticles[i].LifeTimeQuantity, this.Const.Tactical.GruesomeFeastParticles[i].SpawnRate, this.Const.Tactical.GruesomeFeastParticles[i].Stages);
					i = ++i;
				}
			}

			if (_user.isDiscovered() && (!_user.isHiddenToPlayer() || _targetTile.IsVisibleForPlayer))
				{
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + " feasts on a corpse");
				}
			}

			if (!_user.isHiddenToPlayer())
			{
				this.Time.scheduleEvent(this.TimeUnit.Virtual, 500, this.onRemoveCorpse, _targetTile);
			}
			else
			{
				this.onRemoveCorpse(_targetTile);
			}

			this.spawnBloodbath(_targetTile);
			_user.setHitpoints(this.Math.min(_user.getHitpoints() + 50, _user.getHitpointsMax()));
			local skills = _user.getSkills().getAllSkillsOfType(this.Const.SkillType.Injury);

			foreach( s in skills )
			{
				if (s.getOrder() == this.Const.SkillOrder.PermanentInjury)
				{
					continue;
				}

				s.removeSelf();
			}

			local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

			foreach( a in actors )
			{
				if (a.getID() == _user.getID()) continue;
				if (_user.getTile().getDistanceTo(a.getTile()) > 4) continue;
				if (a.getFaction() != _user.getFaction()) continue;
				if (_user.getFlags().getAsInt("SequencesUsed") > 0) continue;

				a.getSkills().add(this.new("scripts/skills/effects/legend_dazed_effect"));
				a.worsenMood(2.0, "Witnessed someone eat a corpse");
			}

			_user.onUpdateInjuryLayer();
			return true;
		}
	});

	//"Parasitic Blood";
	//"This character\'s body has the incredible ability to incorporate different blood types - or indeed, blood from entirely different creatures - into itself. This grants them remarkable healing via absorption of blood through skin pores (or more dramatically by drinking it directly).";
	::mods_hookExactClass("skills/effects/necrosavant_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				}
			];

			if (this.getContainer().getActor().getFlags().has("vampire_8"))
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "Heal [color=" + this.Const.UI.Color.PositiveValue + "]25%[/color] of hitpoint damage inflicted on adjacent enemies that have blood"
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 30 + "[/color] Hitpoints"
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Melee Skill"
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "Heal [color=" + this.Const.UI.Color.PositiveValue + "]15%[/color] of hitpoint damage inflicted on adjacent enemies that have blood"
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 10 + "[/color] Hitpoints"
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 5 + "[/color] Melee Skill"
				});
			}
			
			ret.push({
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
			});
			return ret;
		}

		local function onUpdate(_properties)
		{
			if (this.getContainer().getActor().getFlags().has("vampire_8"))
			{
				_properties.MeleeSkill += 15;
				_properties.Hitpoints += 30;
			}
			else
			{
				_properties.MeleeSkill += 5;
				_properties.Hitpoints += 10;
			}
			
		}
		::mods_addMember(o, "necrosavant_potion_effect", "onUpdate", onUpdate);

		local lifesteal = ::mods_getMember(o, "lifesteal");
		o.lifesteal = function( _damageInflictedHitpoints )
		{
			local actor = this.m.Container.getActor();
			this.spawnIcon("status_effect_09", actor.getTile());
			local hasMastery = this.getContainer().getActor().getFlags().has("vampire_8");
			local lifesteal_percent = hasMastery ? 0.25 : 0.15;

			local hitpointsHealed = this.Math.round(_damageInflictedHitpoints * lifesteal_percent);

			if (!actor.isHiddenToPlayer())
			{
				if (this.m.SoundOnUse.len() != 0)
				{
					this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect, actor.getPos());
				}

				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " heals for " + this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), hitpointsHealed) + " points");
			}

			actor.setHitpoints(this.Math.min(actor.getHitpointsMax(), actor.getHitpoints() + hitpointsHealed));
			actor.onUpdateInjuryLayer();
		}
	});

	::mods_hookExactClass("skills/effects/ptr_swordmaster_scenario_avatar_effect", function (o)
	{
		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function( _properties )
		function onUpdate( _properties )
		{
			this.ptr_swordmaster_scenario_effect.onUpdate(_properties);
				
			local actor = this.getContainer().getActor();
			if (this.isEnabled())
			{
				local skillBonus = this.getSkillBonus();
				_properties.MeleeSkill += skillBonus;
				_properties.MeleeDefense += skillBonus;
				_properties.Bravery += skillBonus;
				_properties.DamageDirectAdd += skillBonus * 0.01;			
			}

			if (!actor.getFlags().has("IsRejuvinated"))
			{
				local skillMalus = this.getSkillMalus();
				_properties.Stamina -= skillMalus;
				_properties.Initiative -= ::Math.floor(skillMalus * 1.5);
				_properties.Hitpoints -= skillMalus;
				_properties.FatigueEffectMult *= 1.0 + 2 * skillMalus * 0.01;
			}
		}

		local getSkillMalus = ::mods_getMember(o, "getSkillMalus");
		o.getSkillMalus = function()
		{
			local actor = this.getContainer().getActor();
			if (actor.getFlags().has("IsRejuvinated")) return 0;

			if (this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_1"))
			{
				return this.Math.min(30, this.Math.max(1, (this.World.getTime().Days - this.m.OldAgeStartDays) / 10));
			}
			
			return 0;
		}

		local onNewDay = ::mods_getMember(o, "onNewDay");
		o.onNewDay = function()
		{
			if (this.World.getPlayerRoster().getAll().len() < 3)
			{
				this.m.DaysWithoutRecruits++;
				if (this.m.DaysWithoutRecruits > 25)
				{
					this.World.Events.fire("event.ptr_swordmaster_scenario_no_recruits_force_end");
				}
			}

			local actor = this.getContainer().getActor();
			if (actor.getFlags().has("IsRejuvinated"))
			{
				if (!actor.getFlags().has("IsRejuvinated_addback"))
				{
					actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRSwordmasterJuggernaut, 3, false);
            		actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_swordmaster_juggernaut"));

					actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRSwordmasterGrappler, 3, false);
            		actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_swordmaster_grappler"));

					actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRSwordmasterReaper, 3, false);
            		actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_swordmaster_reaper"));

					actor.getBackground().addPerk(this.Const.Perks.PerkDefs.PTRSwordmasterBladeDancer, 3, false);
            		actor.getSkills().add(this.new("scripts/skills/perks/perk_ptr_swordmaster_blade_dancer"));
					
					actor.getFlags().add("IsRejuvinated_addback");
				}
				return;
			}


			local bros = this.World.getPlayerRoster().getAll();
			local hasMet = this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_1");
			
			if (!hasMet && bros.len() >= 3 && this.World.getTime().Days >= this.m.OldAgeStartDays)
			{
				if (this.World.Events.fire("event.ptr_swordmaster_scenario_old_age_1"))
				{
					this.World.Flags.set("PTR_SwordmasterScenario_OldAgeEvent_1", true);
				}
			}

			hasMet = this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_2");
			
			if (!hasMet && bros.len() >= 3 && this.World.getTime().Days >= this.m.OldAgeStartDays * 2)
			{
				if (this.World.Events.fire("event.ptr_swordmaster_scenario_old_age_2"))
				{
					this.World.Flags.set("PTR_SwordmasterScenario_OldAgeEvent_2", true);
				}
			}

			hasMet = this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_3");
			
			if (!hasMet && bros.len() >= 3 && this.World.getTime().Days >= this.m.OldAgeStartDays * 3)
			{
				if (this.World.Events.fire("event.ptr_swordmaster_scenario_old_age_3"))
				{
					this.World.Flags.set("PTR_SwordmasterScenario_OldAgeEvent_3", true);
				}
			}

			hasMet = this.World.Flags.get("PTR_SwordmasterScenario_OldAgeEvent_4");
			
			if (!hasMet && bros.len() >= 3 && this.World.getTime().Days >= this.m.OldAgeStartDays * 4)
			{
				if (this.World.Events.fire("event.ptr_swordmaster_scenario_old_age_4"))
				{
					this.World.Flags.set("PTR_SwordmasterScenario_OldAgeEvent_4", true);
				}
			}

			
		}
	});

	

	//"Hyperactive Glands";
	//"This character\'s adrenaline and hormonal glands have mutated, causing a constant heightened emotional state. They can mostly keep this under control in camp, but in high-stress situations the effect is much stronger and fills them with an intense, unconsolable rage.";
	::mods_hookExactClass("skills/effects/orc_berserker_potion_effect", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.Name = "Hyperactive Glands";
		}
		
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "This character gains two stacks of Rage each time they take hitpoint damage, and loses one stack at the end of each turn."
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}
	});

	//"Improved Limbic System";
	//"This character\'s limbic system has been altered with an additional substance that allows them to sustain particularly strenuous anaerobic activity for longer. Their skin seems vaguely greener than you remember, too, but you\'re sure that\'s a coincidence.";
	::mods_hookExactClass("skills/effects/orc_warlord_potion_effect", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.Name = "Improved Limbic System";
		}

		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/fatigue.png",
					text = "Using orc weapons no longer imposes additional fatigue costs" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			onUpdate(_properties);
			_properties.Stamina += 10;
		}
	});

	//"Sensory Redundancy";
	//"This character\'s body has mutated to develop a number of redundant synapses, allowing them to maintain a degree of control over sight, hearing, and muscle control even when struck with debilitating blows.";
	::mods_hookExactClass("skills/effects/orc_warrior_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				}
			];

			if (this.getContainer().getActor().getFlags().has("orc_8"))
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color] Hitpoints"
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]33%[/color] chance to resist the Dazed, Staggered, Stunned, Distracted, and Withered status effects" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
				});
			}
			
			ret.push({
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
			});

			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			onUpdate(_properties);
			if (this.getContainer().getActor().getFlags().has("orc_8"))
			{
				_properties.Hitpoints += 20;
			}
			else
			{
				_properties.Hitpoints += 10;
			}
		}
	});

	//"Shock Absorbant Wrists";
	//"This character\'s wrists have mutated in such a way that the they dampen the initial shock of opposing forces. In more practical terms, they reduce the protective qualities of an enemy\'s armor when struck. They can also make some pretty outlandish shadow puppets.";
	::mods_hookExactClass("skills/effects/orc_young_potion_effect", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.Name = "Shock Absorbant Wrists";
		}

		local getDescription = ::mods_getMember(o, "getDescription");
		o.getDescription = function()
		{
			return "This character\'s wrists have mutated in such a way that the they dampen the initial shock of opposing forces. In more practical terms, this lets them hit harder. They can also make some pretty outlandish shadow puppets.";
		}

		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				}
			];

			if (this.getContainer().getActor().getFlags().has("orc_8"))
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "Attacks do [color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color] additional damage"
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "Attacks do [color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] additional damage"
				});
			}
			
			ret.push({
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
			});

			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			if (this.getContainer().getActor().getFlags().has("orc_8"))
			{
				_properties.DamageTotalMult *= 1.2;
			}
			else
			{
				_properties.DamageTotalMult *= 1.10;
			}
		}
	});

	//"Schrat Symbiosis";
	//"With the proper concoction, and implanting the heart of schrat into the body, the test subject can form a symbiosis with the heart, gaining the abilities and properties of a schrat.";
	::mods_hookExactClass("skills/effects/schrat_potion_effect", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.Name = "Schrat Symbiosis";
		}

		local getDescription = ::mods_getMember(o, "getDescription");
		o.getDescription = function()
		{
			return "With the proper concoction, and implanting the heart of schrat into the body, the test subject can form a symbiosis with the heart, gaining the abilities and properties of a schrat.";
		}

		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/armor_body.png",
					text = "Greatly reduces any form of piercing damage, but you take 33% more burning damage."
				}
			];

			if (this.getContainer().getActor().getFlags().has("schrat_8"))
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "When taking damage more than or equal to 15% of your health, birth a minature greenwood schrat from your blood and surroundings to help you in combat."
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "When taking damage more than or equal to 15% of your health, birth a minature schrat from your blood and surroundings to help you in combat."
				});
			}

			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "Immune to being knocked back or grabbed"
			});

			ret.push({
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
			});

			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			_properties.IsImmuneToKnockBackAndGrab = true;

			if (this.getContainer().getActor().getFlags().has("schrat_8"))
			{
				if (!this.m.Container.hasSkill("actives.uproot"))
				{
					this.m.Container.add(this.new("scripts/skills/actives/uproot_skill"));
				}
			}
			
		}

		local function onRemoved()
		{
			if (this.getContainer().getActor().getFlags().has("schrat_8"))
			{
				this.m.Container.removeByID("actives.uproot");
			}
		}
		::mods_addMember(o, "schrat_potion_effect", "onRemoved", onRemoved);

		local function onBeforeDamageReceived( _attacker, _skill, _hitInfo, _properties )
		{
			if (_skill == null)
			{
				return;
			}

			switch(_hitInfo.DamageType)
			{
			case this.Const.Damage.DamageType.Piercing:
				if (_skill == null) _properties.DamageReceivedRegularMult *= 0.25;
				else if (_skill.isRanged())
				{
					local weapon = _skill.getItem();

					if (weapon != null && weapon.isItemType(this.Const.Items.ItemType.Weapon))
					{
						if (weapon.isWeaponType(this.Const.Items.WeaponType.Bow) || weapon.isWeaponType(this.Const.Items.WeaponType.Crossbow))
						{
							_properties.DamageReceivedRegularMult *= 0.25;
						}
						else if (weapon.isWeaponType(this.Const.Items.WeaponType.Throwing))
						{
							_properties.DamageReceivedRegularMult *= 0.5;
						}
						else
						{
							_properties.DamageReceivedRegularMult *= 0.5;
						}
					}
					else
					{
						_properties.DamageReceivedRegularMult *= 0.2;
					}
				}
				break;

			case this.Const.Damage.DamageType.Burning:
				_properties.DamageReceivedRegularMult *= 1.33;
				break;
			}
		}
		::mods_addMember(o, "schrat_potion_effect", "onBeforeDamageReceived", onBeforeDamageReceived);

		local function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
		{
			local actor = this.getContainer().getActor();

			if (_damageHitpoints >= actor.getHitpointsMax() * 0.25)
			{
				local candidates = [];
				local myTile = actor.getTile();

				for( local i = 0; i < 6; i = i )
				{
					if (!myTile.hasNextTile(i))
					{
					}
					else
					{
						local nextTile = myTile.getNextTile(i);

						if (nextTile.IsEmpty && this.Math.abs(myTile.Level - nextTile.Level) <= 1)
						{
							candidates.push(nextTile);
						}
					}

					i = ++i;
				}

				if (candidates.len() != 0)
				{
					local spawnTile = candidates[this.Math.rand(0, candidates.len() - 1)];
					local sapling = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/schrat_small", spawnTile.Coords);
					//local sapling = this.Tactical.spawnEntity("scripts/entity/tactical/enemies/legend_greenwood_schrat_small", spawnTile.Coords);
					sapling.setFaction(actor.getFaction() == this.Const.Faction.Player ? this.Const.Faction.PlayerAnimals : actor.getFaction());
					sapling.riseFromGround();
				}
			}
		}
		::mods_addMember(o, "schrat_potion_effect", "onDamageReceived", onDamageReceived);

	});

	::mods_hookExactClass("skills/actives/uproot_skill", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.FatigueCost = 40;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			local _actor = this.getContainer().getActor();

			if (_actor.getFaction() != this.Const.Faction.PlayerAnimals && _actor.getFaction() != this.Const.Faction.Player)
			{
				_properties.DamageRegularMin += 70;
				_properties.DamageRegularMax += 100;
			}
			_properties.DamageArmorMult *= 0.85;
		}
	});

	//"Venom Glands"
	//"This character has developed venom glands that allow them to produce poison strong enough to kill any man. Sadly they do not have the fangs of a snake or spider to deliver this venom and have to resort using piercing or cutting weapons to apply it.";
	::mods_hookExactClass("skills/effects/serpent_potion_effect", function (o)
	{
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.Name = "Venom Glands";
		}

		local getDescription = ::mods_getMember(o, "getDescription");
		o.getDescription = function()
		{
			return "This character has developed venom glands that allow them to produce poison strong enough to kill any man. Sadly they do not have the fangs of a snake or spider to deliver this venom and have to resort using piercing or cutting weapons to apply it.";
		}

		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				}
			];

			if (this.getContainer().getActor().getFlags().has("spider_8"))
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Piercing or cutting attacks poison the target with redback venom."
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 30 + "[/color] Initiative"
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Melee Skill"
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Piercing or cutting attacks poison the target."
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/initiative.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 15 + "[/color] Initiative"
				});
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "+[color=" + this.Const.UI.Color.PositiveValue + "]" + 5 + "[/color] Melee Skill"
				});
			}
			
			ret.push({
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
			});

			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			if (this.getContainer().getActor().getFlags().has("spider_8"))
			{
				_properties.Initiative += 30;
				_properties.MeleeSkill += 15;
			}
			else
			{
				_properties.Initiative += 15;
				_properties.MeleeSkill += 5;
			}

		}

		local function onTargetHit( _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor )
		{
			if (_targetEntity.getCurrentProperties().IsImmuneToPoison || _damageInflictedHitpoints < this.Const.Combat.PoisonEffectMinDamage || _targetEntity.getHitpoints() <= 0) return;

			if (!_targetEntity.isAlive()) return;
			if (_targetEntity.getFlags().has("undead")) return;

			if (_skill.m.InjuriesOnBody != this.Const.Injury.PiercingBody && _skill.m.InjuriesOnBody != this.Const.Injury.CuttingBody) return;

			if (!_targetEntity.isHiddenToPlayer())
			{
				if (this.m.SoundOnUse.len() != 0) this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.5, _targetEntity.getPos());
				
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is poisoned");
			}

			this.spawnIcon("status_effect_54", _targetEntity.getTile());

			if (this.getContainer().getActor().getFlags().has("spider_8"))
			{
				local poison = _targetEntity.getSkills().getSkillByID("effects.legend_redback_spider_poison");
				if (!_targetEntity.getSkills().hasSkill("effects.stunned") && !_targetEntity.getCurrentProperties().IsImmuneToStun)
				{
					_targetEntity.getSkills().add(this.new("scripts/skills/effects/stunned_effect"));
					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_targetEntity) + " is stunned");
				}

				if (poison == null) _targetEntity.getSkills().add(this.new("scripts/skills/effects/legend_redback_spider_poison_effect"));
				else poison.resetTime();
			}
			else
			{
				local poison = _targetEntity.getSkills().getSkillByID("effects.spider_poison");
				if (poison == null) _targetEntity.getSkills().add(this.new("scripts/skills/effects/spider_poison_effect"));
				else poison.resetTime();
			}

			
		}
		::mods_addMember(o, "serpent_potion_effect", "onTargetHit", onTargetHit);
	});

	//"Locking Joints";
	//"This character\'s body has mutated such that they can lock their limbs into certain positions almost indefinitely, allowing them to brace against blows while barely breaking a sweat.";
	::mods_hookExactClass("skills/effects/skeleton_warrior_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "Reduces the Fatigue cost of the \'Shieldwall\' skill by [color=" + this.Const.UI.Color.PositiveValue + "]" + 100 * (1 - this.Const.Combat.WeaponSpecFatigueMult) + "%[/color]" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Melee Defense" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Fatigue"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			onUpdate(_properties);
			_properties.MeleeDefense += 10;
			_properties.Stamina += 10;
		}
	});

	//"Hyperactive Cell Growth";
	//"This character\'s body has mutated to grow at an unnatural pace. In battle, this causes their wounds to close and heal within moments. Outside of battle, it causes unseemly growths, an unquenchable thirst, and disgustingly long finger nails. You once saw them lacerate both arms with a meat cleaver, screeching maniacally that it was \'the only way to keep it in check\'. Odd.";
	::mods_hookExactClass("skills/effects/unhold_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local actor = this.getContainer().getActor();

			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				}
			];

			if (actor.getFlags().has("unhold_8") || actor.getFlags().has("ghoul_8"))
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]10[/color] hitpoints each turn. Cannot heal if poisoned."
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/health.png",
					text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]5[/color] hitpoints each turn. Cannot heal if poisoned."
				});
			}

			if (actor.getFlags().has("unhold_8"))
			{
				ret.push({
					id = 11,
					type = "text",
					icon = "ui/icons/armor_body.png",
					text = "Heals [color=" + this.Const.UI.Color.PositiveValue + "]20[/color] head and body armor each turn.  Cannot heal if poisoned."
				});
			}
			
			ret.push({
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
			});
			return ret;
		}

		local onCombatFinished = ::mods_getMember(o, "onCombatFinished");
		o.onCombatFinished = function()
		{
			local actor = this.getContainer().getActor();

			if (actor != null && !actor.isNull() && actor.isAlive())
			{
				actor.setHitpoints(actor.getHitpointsMax());
				
				if (actor.getFlags().has("unhold_8"))
				{	
					local head = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
					local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

					if (head != null) head.setArmor(head.getArmorMax());
					if (body != null) body.setArmor(body.getArmorMax());
				}
				actor.setDirty(true);
			}
		}

		local onTurnStart = ::mods_getMember(o, "onTurnStart");
		o.onTurnStart = function()
		{
			local actor = this.getContainer().getActor();
			if (actor.getSkills().getSkillByID("effects.spider_poison") != null) return;
			if (actor.getSkills().getSkillByID("effects.legend_redback_spider_poison") != null) return;
			if (actor.getSkills().getSkillByID("effects.legend_RSW_poison_effect") != null) return;
			
			local regen_value = (actor.getFlags().has("unhold_8") || actor.getFlags().has("ghoul_8")) ? 10 : 5;
			local health_added = this.Math.min(actor.getHitpointsMax() - actor.getHitpoints(), regen_value);
			
			if (health_added > 0)
			{
				actor.setHitpoints(actor.getHitpoints() + health_added);
				actor.setDirty(true);

				if (!actor.isHiddenToPlayer())
				{
					this.spawnIcon("status_effect_79", actor.getTile());

					if (this.m.SoundOnUse.len() != 0) this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());

					this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + "\'s Hyperactive Cell Growth mutation regenerated " + health_added + " hitpoints");
				}
			}

			if (actor.getFlags().has("unhold_8"))
			{
				local head = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Head);
				local body = actor.getItems().getItemAtSlot(this.Const.ItemSlot.Body);
				
                local head_added = head != null ? this.Math.min(head.getArmorMax() - head.getArmor(), 20) : 0;
				local body_added = body != null ? this.Math.min(body.getArmorMax() - body.getArmor(), 20) : 0;

				// if (head != null) this.logInfo("Head| Max armor: " + head.getArmorMax() + " | Curr Armor: " + head.getArmor() + " | Regen: " + head_added);
				// if (head != null) this.logInfo("Body| Max armor: " + body.getArmorMax() + " | Curr Armor: " + body.getArmor() + " | Regen: " + body_added);

				if (head_added > 0 || body_added > 0)
				{
					if (head != null) head.setArmor(head.getArmor() + head_added);
					if (body != null) body.setArmor(body.getArmor() + body_added);

					// if (head != null) this.logInfo("Head| New armor: " + head.getArmor());
					// if (body != null) this.logInfo("Body| New armor: " + body.getArmor());
					
					actor.setDirty(true);

					if (!actor.isHiddenToPlayer())
					{
						this.spawnIcon("status_effect_79", actor.getTile());

						if (this.m.SoundOnUse.len() != 0) this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());

						if (head_added > 0) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + "\'s Hyperactive Cell Growth mutation regenerated " + head_added + " points of head armor");

						if (body_added > 0) this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + "\'s Hyperactive Cell Growth mutation regenerated " + body_added + " points of body armor");
					}
				}				
			}

		}
	});

	//"Mutated Circulatory System";
	//"This character\'s body has mutated and propagates poisons and other hazardous substances through the bloodstream much more slowly, allowing them to be disposed of without serious health effects. Curiously, this doesn\'t seem to affect their ability to get drunk.";
	
	//"Subdermal Reactivity";
	//"It\'s just a flesh wound! This character\'s subdermal flesh has mutated and automatically reacts to sudden trauma, lessening the chance to suffer injuries in battle.";
	::mods_hookExactClass("skills/effects/wiederganger_potion_effect", function (o)
	{
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "The threshold to sustain injuries on getting hit is increased by [color=" + this.Const.UI.Color.PositiveValue + "]33%[/color]" + "\n[color=" + this.Const.UI.Color.PositiveValue + "]+10[/color] Hitpoints"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}

		local onUpdate = ::mods_getMember(o, "onUpdate");
		o.onUpdate = function(_properties)
		{
			onUpdate(_properties);
			_properties.Hitpoints += 10;
		}
	});

	::mods_hookExactClass("skills/effects/ifrit_potion_effect", function (o)
	{
		
		local m = {
			HeadArmorBoost = 50,
			HeadDamageTaken = 0,
			BodyArmorBoost = 50,
			BodyDamageTaken = 0
		}

		::mods_addMember(o, "ifrit_potion_effect", "m", m);
		
		local create = ::mods_getMember(o, "create");
		o.create = function()
		{
			create();
			this.m.Name = "Stone Skin";
		}
		
		local getDescription = ::mods_getMember(o, "getDescription");
		o.getDescription = function()
		{
			return "This character\'s skin has mutated and now forms hard, rock-like patches that are much hardier and difficult to puncture. When broken, these patches will gradually reform in what is apparently a rather painful, uncomfortable process. You should tell them to stop picking at that scab.";
		}
		
		local getTooltip = ::mods_getMember(o, "getTooltip");
		o.getTooltip = function()
		{
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = this.getDescription()
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/armor_body.png",
					text = "This character\'s skin is hard and stone-like, granting [color=" + this.Const.UI.Color.PositiveValue + "]50[/color] points of natural armor"
				},
				{
					id = 12,
					type = "hint",
					icon = "ui/tooltips/warning.png",
					text = "Further mutations may cause this character's genes to spiral out of control, crippling them"
				}
			];
			return ret;
		}
	});

	//goblin_shaman_potion_effect
	//"Hyperactive Sweat Glands";
	//"When in high stress situations, this character\'s mutated body produces a slimy, viscous substance and begins sweating it excessively. They\'ll have a much easier time escaping from any nets or traps in such a state. Just bring a towel.";

	//"Auspice of the Mad God";
	//"There\'s something wrong with this character. Fits of crazed laughter and muttered tirades aside, their body seems to, at random, reject changes visited upon it. In battle, this has the fortunate effect of letting them sometimes shrug off debilitating effects.";

	//"Ascendant Flesh"
	//"The character draws strength from some limitless source, with the health and durability of two men. You pretend to not notice the eviscerated corpses you sometimes find in their wake.";

	//"Lorekeeper\'s Rib Bone";
	//"This character has had part of the Lorekeeper\'s skeleton fused into their body, and as a result possesses the ability to rapidly recover when delivered seemingly fatal wounds. Now if they could just make it through the night without screaming in their sleep...";

	//"Visions";
	//"This character has strange visions of things that have been and things to come. While less than cheery around the campfire, it does seem to give them a certain ability to connect and internalize new experiences faster.";

	//"Ghastly Aura";
	//"This character has consumed a substance, now in their bloodstream, that emits a kinetic field. This field gets stronger as their health deteriorates, eventually emitting a blue shimmer and producing a noticable effect on any blows that they deal, or that are dealt to them. They also claim to hear a constant, almost imperceptible whisper when alone, but that\'s probably superstition.";

	//bugfixes
	::mods_hookExactClass("skills/racial/unhold_racial", function (o)
	{
		local onTurnStart = ::mods_getMember(o, "onTurnStart");
		o.onTurnStart = function()
		{
			local actor = this.getContainer().getActor();
			if (actor.getSkills().getSkillByID("effects.spider_poison") != null) return;
			if (actor.getSkills().getSkillByID("effects.legend_redback_spider_poison") != null) return;
			if (actor.getSkills().getSkillByID("effects.legend_RSW_poison_effect") != null) return;

			local healthMissing = actor.getHitpointsMax() - actor.getHitpoints();
			local healthAdded = this.Math.min(healthMissing, this.Math.floor(actor.getHitpointsMax() * 0.15));

			if (healthAdded <= 0) return;

			actor.setHitpoints(actor.getHitpoints() + healthAdded);
			actor.setDirty(true);

			if (!actor.isHiddenToPlayer())
			{
				this.spawnIcon("status_effect_79", actor.getTile());

				if (this.m.SoundOnUse.len() != 0)
				{
					this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
				}

				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " regenerated " + healthAdded + " hitpoints");
			}
			
		}
	});
	
	::mods_hookExactClass("skills/racial/legend_rock_unhold_racial", function (o)
	{
		local onTurnStart = ::mods_getMember(o, "onTurnStart");
		o.onTurnStart = function()
		{
			local actor = this.getContainer().getActor();
			if (actor.getSkills().getSkillByID("effects.spider_poison") != null) return;
			if (actor.getSkills().getSkillByID("effects.legend_redback_spider_poison") != null) return;
			if (actor.getSkills().getSkillByID("effects.legend_RSW_poison_effect") != null) return;
			
			local totalBodyArmor = actor.getArmorMax(this.Const.BodyPart.Body);
			local totalHeadArmor = actor.getArmorMax(this.Const.BodyPart.Head);
			local currentBodyArmor = actor.getArmor(this.Const.BodyPart.Body);
			local currentHeadArmor = actor.getArmor(this.Const.BodyPart.Head);
			local missingBodyArmor = totalBodyArmor - currentBodyArmor;
			local missingHeadArmor = totalHeadArmor - currentHeadArmor;
			local healRateBody = totalBodyArmor * 0.1;
			local healRateHead = totalHeadArmor * 0.1;
			local addedBodyArmor = this.Math.abs(this.Math.min(missingBodyArmor, healRateBody));
			local addedHeadArmor = this.Math.abs(this.Math.min(missingHeadArmor, healRateBody));
			local newBodyArmor = currentBodyArmor + addedBodyArmor;
			local newHeadArmor = currentHeadArmor + addedHeadArmor;

			if (addedBodyArmor <= 0 && addedHeadArmor <= 0) return;

			actor.setArmor(this.Const.BodyPart.Body, newBodyArmor);
			actor.setArmor(this.Const.BodyPart.Head, newHeadArmor);
			actor.setDirty(true);

			if (!actor.isHiddenToPlayer())
			{
				this.spawnIcon("status_effect_79", actor.getTile());

				if (this.m.SoundOnUse.len() != 0)
				{
					this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.25, actor.getPos());
				}

				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " regenerated " + addedBodyArmor + " points of body armor");
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + " regenerated " + addedHeadArmor + " points of head armor");
			}
			
		}
	});
};