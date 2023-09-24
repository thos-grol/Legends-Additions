::mods_hookExactClass("entity/world/settlements/buildings/tavern_building", function(o) {
	o.buildText = function( _text )
	{
		local villages = this.World.EntityManager.getSettlements();
		local towns = [];

		foreach( v in villages )
		{
			if (!v.isSouthern())
			{
				towns.push(v);
			}
		}

		local distance = this.m.Location != null && !this.m.Location.isNull() ? this.m.Settlement.getTile().getDistanceTo(this.m.Location.getTile()) : 0;
		distance = ::Const.Strings.Distance[this.Math.min(::Const.Strings.Distance.len() - 1, distance / 30.0 * (::Const.Strings.Distance.len() - 1))];
		local mercCompany = this.World.EntityManager.getMercenaries().len() != 0 ? this.World.EntityManager.getMercenaries()[this.Math.rand(0, this.World.EntityManager.getMercenaries().len() - 1)].getName() : ::Const.Strings.MercenaryCompanyNames[this.Math.rand(0, ::Const.Strings.MercenaryCompanyNames.len() - 1)];
		local text;
		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_OFF",
				"\"[/color]\n\n"
			],
			[
				"companyname",
				this.World.Assets.getName()
			],
			[
				"townname",
				this.m.Settlement.getName()
			],
			[
				"settlement",
				this.m.ContractSettlement != null && !this.m.ContractSettlement.isNull() ? this.m.ContractSettlement.getName() : ""
			],
			[
				"location",
				this.m.Location != null && !this.m.Location.isNull() ? this.m.Location.getName() : ""
			],
			[
				"direction",
				this.m.Location != null && !this.m.Location.isNull() ? ::Const.Strings.Direction8[this.m.Settlement.getTile().getDirection8To(this.m.Location.getTile())] : ""
			],
			[
				"terrain",
				this.m.Location != null && !this.m.Location.isNull() ? ::Const.Strings.Terrain[this.m.Location.getTile().Type] : ""
			],
			[
				"distance",
				distance
			],
			[
				"randomname",
				::Const.Strings.CharacterNames[this.Math.rand(0, ::Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomfemalename",
				::Const.Strings.CharacterNamesFemale[this.Math.rand(0, ::Const.Strings.CharacterNamesFemale.len() - 1)]
			],
			[
				"randomnoble",
				::Const.Strings.KnightNames[this.Math.rand(0, ::Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randomtown",
				towns[this.Math.rand(0, towns.len() - 1)].getNameOnly()
			],
			[
				"randommercenarycompany",
				mercCompany
			],
			[
				"item",
				this.m.Location != null && !this.m.Location.isNull() && !this.m.Location.getLoot().isEmpty() ? this.m.Location.getLoot().getItems()[0].getName() : ""
			],
			[
				"region",
				""
			]
		];
		return this.buildTextFromTemplate(_text, vars);
	}

	o.getRumorPrice = function()
	{
		local bonus = 1;

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_troupe")
		{
			bonus = bonus * 0.5;
		}

		return this.Math.round(20 * this.m.Settlement.getBuyPriceMult() * bonus);
	}

	o.getRumor = function( _isPaidFor = false )
	{
		if (_isPaidFor)
		{
			if (this.World.Assets.getMoney() < this.Math.round(20 * this.m.Settlement.getBuyPriceMult()))
			{
				return null;
			}

			this.World.Assets.addMoney(this.Math.round(-20 * this.m.Settlement.getBuyPriceMult()));
			++this.m.RumorsGiven;
			this.Sound.play(::Const.Sound.TavernRumor[this.Math.rand(0, ::Const.Sound.TavernRumor.len() - 1)]);
		}

		if (this.m.RumorsGiven > 3)
		{
			if (_isPaidFor)
			{
				return "The patrons raise their cups to you, but it seems there is nothing more to be learned by talking to them tonight.";
			}
			else
			{
				return "The patrons talk about this and that.";
			}
		}
		else
		{
			this.m.LastRumorTime = this.Time.getVirtualTimeF();
			local rumor = "";

			if (_isPaidFor)
			{
				if (!this.m.Settlement.isMilitary())
				{
					this.World.FactionManager.getFaction(this.m.Settlement.getFactions()[0]).addPlayerRelation(0.1);
				}

				rumor = rumor + ::Const.Strings.PayTavernRumorsIntro[this.Math.rand(0, ::Const.Strings.PayTavernRumorsIntro.len() - 1)];
			}
			else if (this.m.LastRumor != "")
			{
				return this.m.LastRumor;
			}
			else
			{
				rumor = rumor + "The patrons talk about this and that.";
			}

			local candidates = [];
			local r = this.World.Assets.m.IsNonFlavorRumorsOnly ? this.Math.rand(3, 6) : this.Math.rand(1, 6);

			if (r <= 2)
			{
				if (this.World.FactionManager.isGreaterEvil())
				{
					candidates.extend(::Const.Strings.RumorsGreaterEvil[this.World.FactionManager.getGreaterEvilType()]);
					candidates.extend(::Const.Strings.RumorsGreaterEvil[this.World.FactionManager.getGreaterEvilType()]);
				}
				else
				{
					candidates.extend(::Const.Strings.RumorsGeneral);
				}

				if (this.m.Settlement.isMilitary())
				{
					candidates.extend(::Const.Strings.RumorsMilitary);
				}
				else
				{
					candidates.extend(::Const.Strings.RumorsCivilian);
				}

				candidates.extend(this.m.Settlement.getRumors());
			}
			else if (r == 3)
			{
				local best;
				local bestDist = 9000;

				foreach( s in this.World.EntityManager.getSettlements() )
				{
					if (s.isMilitary() || s.getID() == this.m.Settlement.getID())
					{
						continue;
					}

					if (this.World.FactionManager.getFaction(s.getFactions()[0]).getContracts().len() != 0)
					{
						local d = s.getTile().getDistanceTo(this.m.Settlement.getTile());

						if (d < bestDist)
						{
							bestDist = d;
							best = s;
						}
					}

					if (best != null)
					{
						candidates.extend(::Const.Strings.RumorsContract);
						this.m.ContractSettlement = this.WeakTableRef(best);
					}
					else
					{
						candidates.extend(::Const.Strings.RumorsGeneral);

						if (this.m.Settlement.isMilitary())
						{
							candidates.extend(::Const.Strings.RumorsMilitary);
						}
						else
						{
							candidates.extend(::Const.Strings.RumorsCivilian);
						}

						candidates.extend(this.m.Settlement.getRumors());
					}
				}
			}
			else if (r == 4)
			{
				local best;
				local bestDist = 9000;

				foreach( s in this.World.EntityManager.getLocations() )
				{
					if (s.isLocationType(::Const.World.LocationType.AttachedLocation) || s.isLocationType(::Const.World.LocationType.Unique) || s.isAlliedWithPlayer())
					{
						continue;
					}

					local d = s.getTile().getDistanceTo(this.m.Settlement.getTile()) - this.Math.rand(1, 10);

					if (d < bestDist)
					{
						bestDist = d;
						best = s;
					}
				}

				if (best != null)
				{
					candidates.extend(::Const.Strings.RumorsLocation);
					this.m.Location = this.WeakTableRef(best);
				}
				else
				{
					candidates.extend(::Const.Strings.RumorsGeneral);

					if (this.m.Settlement.isMilitary())
					{
						candidates.extend(::Const.Strings.RumorsMilitary);
					}
					else
					{
						candidates.extend(::Const.Strings.RumorsCivilian);
					}

					candidates.extend(this.m.Settlement.getRumors());
				}
			}
			else if (r == 5)
			{
				local best;
				local bestDist = 9000;

				foreach( s in this.World.EntityManager.getLocations() )
				{
					if (s.isAlliedWithPlayer())
					{
						continue;
					}

					if (s.getLoot().isEmpty())
					{
						continue;
					}

					local d = s.getTile().getDistanceTo(this.m.Settlement.getTile()) - this.Math.rand(1, 10);

					if (d > 20)
					{
						continue;
					}

					if (d < bestDist)
					{
						bestDist = d;
						best = s;
					}
				}

				if (best != null)
				{
					local f = this.World.FactionManager.getFaction(best.getFaction());
					local category = 0;

					if (best.getLoot().getItems()[0].isItemType(::Const.Items.ItemType.Shield))
					{
						category = 1;
					}
					else if (best.getLoot().getItems()[0].isItemType(::Const.Items.ItemType.Armor) || best.getLoot().getItems()[0].isItemType(::Const.Items.ItemType.Helmet))
					{
						category = 2;
					}

					if (f.getType() == ::Const.FactionType.Orcs)
					{
						candidates.extend(::Const.Strings.RumorsItemsOrcs[category]);
					}
					else if (f.getType() == ::Const.FactionType.Goblins)
					{
						candidates.extend(::Const.Strings.RumorsItemsGoblins[category]);
					}
					else if (f.getType() == ::Const.FactionType.Undead || f.getType() == ::Const.FactionType.Zombies)
					{
						candidates.extend(::Const.Strings.RumorsItemsUndead[category]);
					}
					else if (f.getType() == ::Const.FactionType.Barbarians)
					{
						candidates.extend(::Const.Strings.RumorsItemsBarbarians[category]);
					}
					else if (f.getType() == ::Const.FactionType.OrientalBandits)
					{
						candidates.extend(::Const.Strings.RumorsItemsNomads[category]);
					}
					else
					{
						candidates.extend(::Const.Strings.RumorsItemsBandits[category]);
					}

					this.m.Location = this.WeakTableRef(best);
				}
				else
				{
					candidates.extend(::Const.Strings.RumorsGeneral);

					if (this.m.Settlement.isMilitary())
					{
						candidates.extend(::Const.Strings.RumorsMilitary);
					}
					else
					{
						candidates.extend(::Const.Strings.RumorsCivilian);
					}

					candidates.extend(this.m.Settlement.getRumors());
				}
			}
			else if (r == 6)
			{
				local best;
				local bestDist = 9000;

				foreach( s in this.World.EntityManager.getSettlements() )
				{
					if (s.getID() == this.m.Settlement.getID())
					{
						continue;
					}

					s.updateSituations();

					if (s.getSituations().len() > 0)
					{
						local d = s.getTile().getDistanceTo(this.m.Settlement.getTile());

						if (d < bestDist)
						{
							bestDist = d;
							best = s;
						}
					}
				}

				if (best != null)
				{
					local situation = best.getSituations()[this.Math.rand(0, best.getSituations().len() - 1)];
					candidates.extend(situation.getRumors());
					this.m.ContractSettlement = this.WeakTableRef(best);
				}
				else
				{
					candidates.extend(::Const.Strings.RumorsGeneral);

					if (this.m.Settlement.isMilitary())
					{
						candidates.extend(::Const.Strings.RumorsMilitary);
					}
					else
					{
						candidates.extend(::Const.Strings.RumorsCivilian);
					}

					candidates.extend(this.m.Settlement.getRumors());
				}
			}

			rumor = rumor + "\n\n[color=#bcad8c]\"";
			rumor = rumor + candidates[this.Math.rand(0, candidates.len() - 1)];
			rumor = rumor + "\"[/color]\n\n";
			rumor = this.buildText(rumor);
			this.m.LastRumor = rumor;
			return rumor;
		}
	}

	o.getDrinkPrice = function()
	{
		local bonus = 1;

		if (this.World.Assets.getOrigin().getID() == "scenario.legends_troupe")
		{
			bonus = 0.5;
		}

		return this.Math.round(this.World.getPlayerRoster().getSize() * 5 * this.m.Settlement.getBuyPriceMult() * bonus);
	}

	o.getDrinkResult = function()
	{
		local bros = this.World.getPlayerRoster().getAll();

		if (this.World.Assets.getMoney() < this.Math.round(bros.len() * 5 * this.m.Settlement.getBuyPriceMult()))
		{
			return null;
		}

		this.Sound.play(::Const.Sound.TavernRound[this.Math.rand(0, ::Const.Sound.TavernRound.len() - 1)]);
		this.World.Assets.addMoney(this.Math.round(bros.len() * -5 * this.m.Settlement.getBuyPriceMult()));
		++this.m.RoundsGiven;
		this.m.LastRoundTime = this.Time.getVirtualTimeF();
		local result = {
			Intro = ::Const.Strings.PayTavernRoundIntro[this.Math.rand(0, ::Const.Strings.PayTavernRoundIntro.len() - 1)],
			Result = []
		};

		foreach( b in bros )
		{
			if (result.Result.len() >= 5)
			{
				break;
			}

			local drunkChance = (this.m.RoundsGiven - 1) * 10;

			if (this.World.Assets.getOrigin().getID() == "scenario.legends_troupe")
			{
				drunkChance = drunkChance * 0.5;
			}

			if (!b.getSkills().hasSkill("effects.drunk"))
			{
				if (b.getSkills().hasSkill("trait.drunkard"))
				{
					drunkChance = drunkChance + 20;
				}

				if (b.getSkills().hasSkill("trait.strong"))
				{
					drunkChance = drunkChance - 10;
				}

				if (b.getSkills().hasSkill("trait.tough"))
				{
					drunkChance = drunkChance - 10;
				}

				if (b.getSkills().hasSkill("trait.fragile"))
				{
					drunkChance = drunkChance + 10;
				}

				if (b.getSkills().hasSkill("trait.tiny"))
				{
					drunkChance = drunkChance + 10;
				}

				if (b.getSkills().hasSkill("trait.bright"))
				{
					drunkChance = drunkChance - 10;
				}
				else if (b.getSkills().hasSkill("trait.dumb"))
				{
					drunkChance = drunkChance + 10;
				}
			}
			else
			{
				drunkChance = 0;

				if (!b.getSkills().hasSkill("trait.drunkard"))
				{
					if (this.Math.rand(1, 100) <= this.m.RoundsGiven + 5)
					{
						local drunk = this.new("scripts/skills/traits/drunkard_trait");
						b.getSkills().add(drunk);
						result.Result.push({
							Icon = drunk.getIcon(),
							Text = b.getName() + " is now a drunkard."
						});
					}
				}
			}

			if (this.Math.rand(1, 100) <= drunkChance)
			{
				local drunk = this.new("scripts/skills/effects_world/drunk_effect");
				b.getSkills().add(drunk);
				result.Result.push({
					Icon = drunk.getIcon(),
					Text = b.getName() + " is now drunk."
				});
			}

			if ((b.getLastDrinkTime() == 0 || this.Time.getVirtualTimeF() - b.getLastDrinkTime() > this.World.getTime().SecondsPerDay) && this.Math.rand(1, 100) <= 35)
			{
				b.setLastDrinkTime(this.Time.getVirtualTimeF());
				b.improveMood(::Const.MoodChange.DrunkAtTavern, "Got drunk with the company");
				result.Result.push({
					Icon = ::Const.MoodStateIcon[b.getMoodState()],
					Text = b.getName() + ::Const.MoodStateEvent[b.getMoodState()]
				});
			}
		}

		return result;
	}

});
