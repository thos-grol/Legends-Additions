//Escape artist auto break free from nets on start of turn, also gives chance to dodge net using ranged defence.
::Const.Strings.PerkDescription.LegendEscapeArtist = "Grants a chance to dodge nets with ranged defence. At the start of your turn, perform a free break free action. Also reduces the AP cost of movement and escape skills by 1 and the fatigue by 25%.";
::Const.Perks.PerkDefObjects[::Const.Perks.PerkDefs.LegendEscapeArtist].Tooltip = ::Const.Strings.PerkDescription.LegendEscapeArtist;

//move rebound from agile to fit, replace with escape artist
::Const.Perks.FitTree.Tree[2] = [::Const.Perks.PerkDefs.Rebound]; //[] -> Rebound
::Const.Perks.AgileTree.Tree[6] = [::Const.Perks.PerkDefs.LegendEscapeArtist]; //Rebound -> Escape Artist

//remove escape artist from trapper tree
::Const.Perks.TrapperClassTree.Tree[6] = []; //Escape Artist -> []

::mods_hookExactClass("skills/perks/perk_legend_escape_artist", function (o)
{
	o.create = function()
	{
        this.m.ID = "perk.legend_escape_artist";
		this.m.Name = ::Const.Strings.PerkName.LegendEscapeArtist;
		this.m.Description = ::Const.Strings.PerkDescription.LegendEscapeArtist;
		this.m.Icon = "ui/perks/net_perk.png";
		this.m.Type = ::Const.SkillType.Perk;
		this.m.Order = ::Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
    }
    //reduce movement skill costs by 1
	o.onAfterUpdate = function( _properties )
	{
        local skills = this.getContainer().getSkillsByFunction(function ( _skill )
		{
			return _skill.getID() == "actives.break_free"
			|| _skill.getID() == "actives.footwork"
			|| _skill.getID() == "actives.rotation"
			|| _skill.getID() == "actives.legend_tumble"
			|| _skill.getID() == "actives.legend_evasion"
			|| _skill.getID() == "actives.legend_leap"
			|| _skill.getID() == "actives.charge";
		});

		foreach( s in skills )
		{
			s.m.ActionPointCost -= 1;
			s.m.FatigueCostMult *= 0.75;
		}
	}

	//Autobreak free on turn start
	o.onTurnStart <- function()
    {
        local _user = this.getContainer().getActor();
		if ( !_user.getSkills().hasSkill("effects.net")
			&& !_user.getSkills().hasSkill("effects.rooted")
			&& !_user.getSkills().hasSkill("effects.web")
			&& !_user.getSkills().hasSkill("effects.kraken_ensnare")
			&& !_user.getSkills().hasSkill("effects.serpent_ensnare") ) return;

		local skill = _user.getCurrentProperties().getMeleeSkill();
		local toHit = this.Math.min(100, skill - 10);
        local rolled = this.Math.rand(1, 100);

		if (rolled <= toHit)
		{
			this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " breaks free (Chance: " + toHit + ", Rolled: " + rolled + ")");

			local SoundOnHitHitpoints = [
				"sounds/combat/break_free_net_01.wav",
				"sounds/combat/break_free_net_02.wav",
				"sounds/combat/break_free_net_03.wav"
			];
			this.Sound.play(SoundOnHitHitpoints[this.Math.rand(0, SoundOnHitHitpoints.len() - 1)], ::Const.Sound.Volume.Skill, _user.getTile().Pos);

			_user.getSprite("status_rooted").Visible = false;
			_user.getSprite("status_rooted_back").Visible = false;

			local breakfree_decal = _user.getSkills().getSkillByID("actives.break_free").m.Decal;
			if (breakfree_decal != "")
			{
				local ourTile = _user.getTile();
				local candidates = [];

				if (ourTile.Properties.has("IsItemSpawned") || ourTile.IsCorpseSpawned)
				{
					for( local i = 0; i < ::Const.Direction.COUNT; i = i )
					{
						if (!ourTile.hasNextTile(i))
						{
						}
						else
						{
							local tile = ourTile.getNextTile(i);

							if (tile.IsEmpty && !tile.Properties.has("IsItemSpawned") && !tile.IsCorpseSpawned && tile.Level <= ourTile.Level + 1)
							{
								candidates.push(tile);
							}
						}

						i = ++i;
					}
				}
				else
				{
					candidates.push(ourTile);
				}

				if (candidates.len() != 0)
				{
					local tileToSpawnAt = candidates[this.Math.rand(0, candidates.len() - 1)];
					tileToSpawnAt.spawnDetail(breakfree_decal);
					tileToSpawnAt.Properties.add("IsItemSpawned");
				}
			}

			_user.setDirty(true);
			this.getContainer().removeByID("effects.net");
			this.getContainer().removeByID("effects.rooted");
			this.getContainer().removeByID("effects.web");
			this.getContainer().removeByID("effects.kraken_ensnare");
			this.getContainer().removeByID("effects.serpent_ensnare");
		}
		else
		{
			this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " fails to break free (Chance: " + toHit + ", Rolled: " + rolled + ")");

			if (this.m.SoundOnMiss.len() != 0)
			this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill, _user.getTile().Pos);
		}

	}

});

//change break free chance back to normal
::mods_hookExactClass("skills/actives/break_free_skill", function (o)
{
	o.onUse = function( _user, _targetTile )
	{
		local skill = this.m.SkillBonus == null ? _user.getCurrentProperties().getMeleeSkill() : this.m.SkillBonus;
		local toHit = this.Math.min(100, skill - 10);

		local rolled = this.Math.rand(1, 100);
		this.Tactical.EventLog.log_newline();

		if (rolled <= toHit)
		{
			this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " breaks free (Chance: " + toHit + ", Rolled: " + rolled + ")");

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], ::Const.Sound.Volume.Skill, _targetTile.Pos);
			}

			_user.getSprite("status_rooted").Visible = false;
			_user.getSprite("status_rooted_back").Visible = false;

			if (this.m.Decal != "")
			{
				local ourTile = this.getContainer().getActor().getTile();
				local candidates = [];

				if (ourTile.Properties.has("IsItemSpawned") || ourTile.IsCorpseSpawned)
				{
					for( local i = 0; i < ::Const.Direction.COUNT; i = i )
					{
						if (!ourTile.hasNextTile(i))
						{
						}
						else
						{
							local tile = ourTile.getNextTile(i);

							if (tile.IsEmpty && !tile.Properties.has("IsItemSpawned") && !tile.IsCorpseSpawned && tile.Level <= ourTile.Level + 1)
							{
								candidates.push(tile);
							}
						}

						i = ++i;
					}
				}
				else
				{
					candidates.push(ourTile);
				}

				if (candidates.len() != 0)
				{
					local tileToSpawnAt = candidates[this.Math.rand(0, candidates.len() - 1)];
					tileToSpawnAt.spawnDetail(this.m.Decal);
					tileToSpawnAt.Properties.add("IsItemSpawned");
				}
			}

			_user.setDirty(true);
			this.getContainer().removeByID("effects.net");
			this.getContainer().removeByID("effects.rooted");
			this.getContainer().removeByID("effects.web");
			this.getContainer().removeByID("effects.kraken_ensnare");
			this.getContainer().removeByID("effects.serpent_ensnare");
			this.removeSelf();
			return true;
		}
		else
		{
			this.Tactical.EventLog.logEx(::Const.UI.getColorizedEntityName(_user) + " fails to break free (Chance: " + toHit + ", Rolled: " + rolled + ")");

			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], ::Const.Sound.Volume.Skill, _targetTile.Pos);
			}

			this.m.ChanceBonus += 10;
			return false;
		}

		this.m.SkillBonus = null;
	}

});